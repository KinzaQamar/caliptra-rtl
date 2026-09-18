// Copyright lowRISC contributors (OpenTitan project).
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

class csrng_scoreboard extends dv_base_scoreboard #(
    .CFG_T(csrng_env_cfg),
    .RAL_T(csrng_reg_block),
    .COV_T(csrng_env_cov)
  );
  `uvm_component_utils(csrng_scoreboard)

  csrng_item                                              cs_item[NUM_HW_APPS + 1];
  push_pull_item#(.HostDataWidth(FIPS_CSRNG_BUS_WIDTH))   es_item[NUM_HW_APPS + 1],
                                                          es_item_q[NUM_HW_APPS + 1][$];
  uint                                                    more_cmd_data;
  bit [AHBDataWidth-1:0]                                  hw_genbits_reg_q[$];
  bit [GENBITS_BUS_WIDTH-1:0]                             hw_genbits,
                                                          prd_genbits_q[NUM_HW_APPS + 1][$];
  bit [CSRNG_BUS_WIDTH-1:0]                               cs_data[NUM_HW_APPS + 1],
                                                          es_data[NUM_HW_APPS + 1];
  bit                                                     fips[NUM_HW_APPS + 1];
  // Sample interrupt pins at read data phase. This is used to compare with intr_state read value.
  bit [3:0] intr_pins;
  bit [SW_APP:0] genbits_fips_previous;
  bit [SW_APP:0] genbits_fips_received = '0;
  mubi4_t [SW_APP:0] cmd_flag0_previous;
  csrng_pkg::csrng_cmd_sts_e cmd_sts[NUM_HW_APPS + 1] = '{default: CMD_STS_SUCCESS};

  bit [3:0] int_state_num;
  bit [NUM_HW_APPS:0] int_state_read_enable;

  virtual csrng_cov_if                                    cov_vif;

  // TLM agent fifos
  uvm_tlm_analysis_fifo#(push_pull_item#(.HostDataWidth(FIPS_CSRNG_BUS_WIDTH)))   entropy_src_fifo;
  uvm_tlm_analysis_fifo#(csrng_item)   csrng_cmd_fifo[NUM_HW_APPS];

  `uvm_component_new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    entropy_src_fifo = new("entropy_src_fifo", this);

    for (int i = 0; i < NUM_HW_APPS; i++) begin
      csrng_cmd_fifo[i] = new($sformatf("csrng_cmd_fifo[%0d]", i), this);
    end

    if (!uvm_config_db#(virtual csrng_cov_if)::get(null, "*.env" , "csrng_cov_if", cov_vif)) begin
      `uvm_fatal(`gfn, $sformatf("Failed to get csrng_cov_if from uvm_config_db"))
    end
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);

    fork
      collect_seeds();
      handle_disable();
    join_none;

    for (int i = 0; i < NUM_HW_APPS; i++) begin
      automatic int j = i;
      fork
        begin
          process_csrng_cmd_fifo(j);
        end
      join_none;
    end
  endtask

  virtual protected task handle_disable();
    forever begin
      wait(cfg.under_reset == 0)
      csr_spinwait(.ptr(ral.CTRL.ENABLE),
                   .exp_data(MuBi4False),
                   .backdoor(1),
                   .timeout_ns(1_000_000_000) /* practically forever */);
      `uvm_info(`gfn, "CSRNG disabled, clearing scoreboard state.", UVM_MEDIUM)
      entropy_src_fifo.flush();
      hw_genbits = '0;
      more_cmd_data = 0;
      for (int i = 0; i < NUM_HW_APPS + 1; i++) begin
        if (i != SW_APP) csrng_cmd_fifo[i].flush();
        es_item_q[i].delete();
        hw_genbits_reg_q.delete();
        prd_genbits_q[i].delete();
        ctr_drbg_uninstantiate(i);
        cs_data[i] = '0;
        es_data[i] = '0;
        fips[i] = '0;
        cmd_sts[i] = CMD_STS_SUCCESS;
      end
      csr_spinwait(.ptr(ral.CTRL.ENABLE),
                   .exp_data(MuBi4True),
                   .backdoor(1),
                   .timeout_ns(1_000_000_000) /* practically forever */);
    end
  endtask

  // Wait for an item in the entropy source queue or for CSRNG getting disabled, whichever happens
  // first.  Return whether CSRNG was disabled in the `disabled` output.
  task automatic wait_es_item_or_disable(input uint app, output bit disabled);
    disabled = 0;
    `DV_SPINWAIT(
      fork
        wait(es_item_q[app].size() > 0);
        begin
          csr_spinwait(.ptr(ral.CTRL.ENABLE),
                       .exp_data(MuBi4False),
                       .backdoor(1),
                       .timeout_ns(1_000_000_000) /* practically forever */);
          disabled = 1;
        end
      join_any
      disable fork;,
      "timeout waiting for an item in the entropy source queue or for CSRNG getting disabled",
      1_000_000_000 /* 1e9 ns = 1 s; practically forever */
    )
  endtask

  virtual function void reset(string kind = "HARD");
    super.reset(kind);
    // reset local fifos queues and variables
  endfunction

  function void check_phase(uvm_phase phase);
    super.check_phase(phase);
    // TODO(#19031): post test checks - ensure that all local fifos and queues are empty
  endfunction

  // From NIST.SP.800-90Ar1
  function bit [BLOCK_LEN-1:0] block_encrypt(
      bit [KEY_LEN-1:0]   key,
      bit [BLOCK_LEN-1:0] input_block);

    bit [BLOCK_LEN-1:0]   output_block;

    sv_dpi_aes_crypt_block(.impl_i(1'b0), .op_i(1'b0), .mode_i(6'b00_0001), .key_len_i(3'b100),
                           .iv_i('h0),
                           .key_i(key),
                           .data_i(input_block),
                           .data_o(output_block));
    return output_block;
  endfunction

  function void ctr_drbg_update(uint app, bit [CSRNG_BUS_WIDTH-1:0] provided_data);

    bit [CSRNG_BUS_WIDTH-1:0]   temp;
    bit [CTR_LEN-1:0]           inc;
    bit [BLOCK_LEN-1:0]         output_block;
    bit [63:0]                  mod_val;

    `uvm_info(`gfn, $sformatf("Update of app %0d", app), UVM_MEDIUM)
    // If the instance was not instantiated then the next acknowledge should return an error.
    if (!cfg.status[app]) begin
      cmd_sts[app] = CMD_STS_INVALID_CMD_SEQ;
    end
    for (int i = 0; i < (CSRNG_BUS_WIDTH/BLOCK_LEN); i++) begin
      if (CTR_LEN < BLOCK_LEN) begin
        inc = (cfg.v[app][CTR_LEN-1:0] + 1);
        mod_val = 2**CTR_LEN;
        inc = inc % mod_val;
        cfg.v[app] = {cfg.v[app][BLOCK_LEN - 1:CTR_LEN], inc};
      end
      else begin
        cfg.v[app] += 1;
        mod_val = 2**BLOCK_LEN;
        cfg.v[app] = cfg.v[app] % mod_val;
      end

      output_block = block_encrypt(cfg.key[app], cfg.v[app]);
      temp = {temp, output_block};
    end

    temp = temp ^ provided_data;
    cfg.key[app] = temp[CSRNG_BUS_WIDTH-1:(CSRNG_BUS_WIDTH - KEY_LEN)];
    cfg.v[app] = temp[BLOCK_LEN-1:0];
  endfunction

  function void ctr_drbg_instantiate(uint app,
                                     bit [CSRNG_BUS_WIDTH-1:0] entropy_input,
                                     bit [CSRNG_BUS_WIDTH-1:0] additional_input,
                                     bit fips);

    bit [CSRNG_BUS_WIDTH-1:0] seed_material;
    bit [CSRNG_BUS_WIDTH-1:0] fips_force;
    bit compliance_previous = cfg.compliance[app];

    `uvm_info(`gfn, $sformatf("Instantiate of app %0d", app), UVM_MEDIUM)
    // If the instance was already instantiated then the next acknowledge should return an error.
    if (cfg.status[app]) begin
      cmd_sts[app] = CMD_STS_INVALID_CMD_SEQ;
    end
    seed_material  = entropy_input ^ additional_input;
    cfg.key[app] = 'h0;
    cfg.v[app]   = 'h0;
    cfg.status[app]         = 1'b1;
    ctr_drbg_update(app, seed_material);
    cfg.reseed_counter[app] = 1'b0;
    fips_force = `gmv(ral.FIPS_FORCE);
    cfg.compliance[app]     = fips || ((`gmv(ral.CTRL.FIPS_FORCE_ENABLE) == MuBi4True) &&
                                       fips_force[app]);
    cov_vif.cg_csrng_state_db_sample(cfg.compliance[app], compliance_previous, app);
  endfunction

  function void ctr_drbg_reseed(uint app,
                                bit [CSRNG_BUS_WIDTH-1:0] entropy_input,
                                bit [CSRNG_BUS_WIDTH-1:0] additional_input,
                                bit fips);

    bit [CSRNG_BUS_WIDTH-1:0]   seed_material;
    bit [CSRNG_BUS_WIDTH-1:0] fips_force;
    bit compliance_previous = cfg.compliance[app];

    `uvm_info(`gfn, $sformatf("Reseed of app %0d", app), UVM_MEDIUM)
    seed_material = entropy_input ^ additional_input;
    ctr_drbg_update(app, seed_material);
    cfg.reseed_counter[app] = 1'b0;
    fips_force = `gmv(ral.FIPS_FORCE);
    cfg.compliance[app]     = fips || ((`gmv(ral.CTRL.FIPS_FORCE_ENABLE) == MuBi4True) &&
                                       fips_force[app]);
    cov_vif.cg_csrng_state_db_sample(cfg.compliance[app], compliance_previous, app);
  endfunction

  function void ctr_drbg_uninstantiate(uint app);
    `uvm_info(`gfn, $sformatf("Uninstantiate of app %0d", app), UVM_MEDIUM)
    cfg.key[app] = 'h0;
    cfg.v[app]   = 'h0;
    cfg.reseed_counter[app] = 1'b0;
    cfg.compliance[app]     = 1'b0;
    cfg.status[app]         = 1'b0;
  endfunction

  function void ctr_drbg_generate(uint app,
                                  bit [11:0] glen,
                                  bit [CSRNG_BUS_WIDTH-1:0] additional_input = 'h0);

    bit [GENBITS_BUS_WIDTH-1:0]   genbits, hw_genbits;
    bit [CTR_LEN-1:0]             inc;
    bit [BLOCK_LEN-1:0]           output_block;
    bit [63:0]                    mod_val;

    `uvm_info(`gfn, $sformatf("Generate of app %0d", app), UVM_MEDIUM)
    if (cfg.reseed_counter[app] == `gmv(ral.RESEED_INTERVAL)) begin
      cmd_sts[app] = CMD_STS_RESEED_CNT_EXCEEDED;
    end
    if (additional_input) begin
      ctr_drbg_update(app, additional_input);
    end
    for (int i = 0; i < glen; i++) begin
      if (CTR_LEN < BLOCK_LEN) begin
        inc = (cfg.v[app][CTR_LEN-1:0] + 1);
        mod_val = 2**CTR_LEN;
        inc = inc % mod_val;
        cfg.v[app] = {cfg.v[app][BLOCK_LEN - 1:CTR_LEN], inc};
      end
      else begin
        cfg.v[app] += 1;
        mod_val = 2**BLOCK_LEN;
        cfg.v[app] = cfg.v[app] % mod_val;
      end
      output_block = block_encrypt(cfg.key[app], cfg.v[app]);
      genbits      = output_block;
      if ((app != SW_APP) ||
          ((cfg.sw_app_enable == MuBi4True) && (cfg.otp_en_cs_sw_app_read == MuBi8True))) begin
        prd_genbits_q[app].push_back(genbits);
      end
      else begin
        prd_genbits_q[app].push_back('h0);
      end
    end
    ctr_drbg_update(app, additional_input);
    cfg.reseed_counter[app] += 1;
  endfunction

  task collect_seeds();
    push_pull_item#(.HostDataWidth(FIPS_CSRNG_BUS_WIDTH))   es_item;
    bit [1:0]   cmd_arb_idx;
    string      cmd_arb_idx_q_path = "tb.dut.u_csrng_core.cmd_arb_idx_q";
    bit [SW_APP-1:0] previous_fips;
    // Flags indicating that fips transitions can be recorded for coverage.
    bit [SW_APP-1:0] initial_fips_received = '0;

    `DV_CHECK_FATAL(uvm_hdl_check_path(cmd_arb_idx_q_path))
    forever begin
      entropy_src_fifo.get(es_item);
      if (cfg.lc_hw_debug_en == On) begin
        es_item.d_data = es_item.d_data ^ LC_HW_DEBUG_EN_ON_DATA;
      end
      else begin
        es_item.d_data = es_item.d_data ^ LC_HW_DEBUG_EN_OFF_DATA;
      end
      // Need to access rtl signal to determine which APP won arbitration
      `DV_CHECK(uvm_hdl_read(cmd_arb_idx_q_path, cmd_arb_idx))
      case (cmd_arb_idx)
        HW_APP0: begin
                   es_item_q[HW_APP0].push_back(es_item);
                 end
        HW_APP1: begin
                   es_item_q[HW_APP1].push_back(es_item);
                 end
        SW_APP:  begin
                   es_item_q[SW_APP].push_back(es_item);
                 end
        default: begin
          `uvm_fatal(`gfn, $sformatf("Invalid APP: %0d", cmd_arb_idx))
        end
      endcase
      cov_vif.cg_csrng_es_sample(es_item.d_data[CSRNG_BUS_WIDTH],
                                 previous_fips[cmd_arb_idx],
                                 cmd_arb_idx,
                                 initial_fips_received[cmd_arb_idx]);
      initial_fips_received[cmd_arb_idx] = 1'b1;
      previous_fips[cmd_arb_idx] = es_item.d_data[CSRNG_BUS_WIDTH];
     end
  endtask

  task process_csrng_cmd_fifo(bit[NUM_HW_APPS-1:0] app);
    forever begin
      csrng_cmd_fifo[app].get(cs_item[app]);
      cs_data[app] = '0;
      es_data[app] = '0;
      fips[app]    = 1'b0;

      // Check if the command status response is equal to the expected status.
      `DV_CHECK_EQ_FATAL(cs_item[app].status, cmd_sts[app])
      for (int i = 0; i < cs_item[app].cmd_data_q.size(); i++) begin
        cs_data[app] = (cs_item[app].cmd_data_q[i] << i * CSRNG_CMD_WIDTH) +
                       cs_data[app];
      end
      cov_vif.cg_cmds_sample(app, cs_item[app], cmd_flag0_previous[app]);

      case (cs_item[app].acmd)
        INS: begin
          // Record previous flag0 only after INS or RES commands.
          cmd_flag0_previous[app] = cs_item[app].flags;
          if (cs_item[app].flags != MuBi4True) begin
            // Get seed
            bit disabled;
            wait_es_item_or_disable(app, disabled);
            if (disabled) begin
              `uvm_info(`gfn,
                  $sformatf("Stopping to wait for entropy due to disable - Instantiate of app %0d",
                      app),
                  UVM_MEDIUM)
              continue;
            end
            es_item[app] = es_item_q[app].pop_front();
            es_data[app] = es_item[app].d_data[CSRNG_BUS_WIDTH-1:0];
            fips[app]    = es_item[app].d_data[CSRNG_BUS_WIDTH];
          end
          ctr_drbg_instantiate(app, es_data[app], cs_data[app], fips[app]);
        end
        GEN: begin
          ctr_drbg_generate(app, cs_item[app].glen, cs_data[app]);
          for (int i = 0; i < cs_item[app].glen; i++) begin
            `DV_CHECK_EQ_FATAL(cs_item[app].genbits_q[i], prd_genbits_q[app][i])
            // Check if the FIPS compliance bit is set correctly.
            `DV_CHECK_EQ_FATAL(cs_item[app].fips_q[i], cfg.compliance[app])
            cov_vif.cg_csrng_genbits_sample(
                .genbits_fips(cs_item[app].fips_q[i]),
                .genbits_fips_previous(genbits_fips_previous[app]),
                .app(app),
                .valid(1'b1),
                .record_transition(genbits_fips_received[app]));
            genbits_fips_previous[SW_APP] = cs_item[app].fips_q[i];
            genbits_fips_received[SW_APP] = 1'b1;
          end
          // Deletes the predicted genbits before the next comparison.
          prd_genbits_q[app].delete();
        end
        UNI: begin
          ctr_drbg_uninstantiate(app);
        end
        RES: begin
          // Record previous flag0 only after INS or RES commands.
          cmd_flag0_previous[app] = cs_item[app].flags;
          if (cs_item[app].flags != MuBi4True) begin
            // Get seed
            bit disabled;
            wait_es_item_or_disable(app, disabled);
            if (disabled) begin
              `uvm_info(`gfn,
                  $sformatf("Stopping to wait for entropy due to disable - Reseed of app %0d", app),
                  UVM_MEDIUM)
              continue;
            end
            es_item[app] = es_item_q[app].pop_front();
            es_data[app] = es_item[app].d_data[CSRNG_BUS_WIDTH-1:0];
            fips[app]    = es_item[app].d_data[CSRNG_BUS_WIDTH];
          end
          ctr_drbg_reseed(app, es_data[app], cs_data[app], fips[app]);
        end
        UPD: begin
          ctr_drbg_update(app, cs_data[app]);
        end
        default: begin
          // Expect the next acknowledgement to return an error.
          cmd_sts[app] = CMD_STS_INVALID_ACMD;
        end
      endcase
    end
  endtask
endclass
