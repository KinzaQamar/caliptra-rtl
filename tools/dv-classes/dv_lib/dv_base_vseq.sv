// Copyright lowRISC contributors (OpenTitan project).
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

class dv_base_vseq #(type RAL_T               = dv_base_reg_block,
                     type CFG_T               = dv_base_env_cfg,
                     type COV_T               = dv_base_env_cov,
                     type VIRTUAL_SEQUENCER_T = dv_base_virtual_sequencer) extends uvm_sequence;
  `uvm_object_param_utils(dv_base_vseq #(RAL_T, CFG_T, COV_T, VIRTUAL_SEQUENCER_T))
  `uvm_declare_p_sequencer(VIRTUAL_SEQUENCER_T)

  // number of iterations to run the test seq - please override constraint in extended vseq
  // randomization for this is disabled in pre_start since we don't want to re-randomize it again
  rand uint num_trans;

  constraint num_trans_c {
    num_trans inside {[1:20]};
  }

  // handles for ease of op
  CFG_T   cfg;
  RAL_T   ral;
  COV_T   cov;

  // knobs to enable pre_start routines
  bit do_dut_init       = 1'b1;
  bit do_apply_reset    = 1'b1;
  bit do_wait_for_reset = 1'b0;

  // knobs to enable post_start routines
  bit do_dut_shutdown   = 1'b1;

  // various knobs to enable certain routines
  // this knob allows user to disable assertions in csr_hw_reset before random write sequence,
  // the assertions will turn back on after the hw reset deasserted
  bit enable_asserts_in_hw_reset_rand_wr  = 1'b1;

  // User can set the name of common seq to run directly without using $value$plusargs
  string common_seq_type;

  // CSR queues
  dv_base_reg all_csrs[$];

  `uvm_object_new

  virtual function void set_handles();
    `DV_CHECK_NE_FATAL(p_sequencer, null, "Did you forget to call `set_sequencer()`?")
    cfg = p_sequencer.cfg;
    cov = p_sequencer.cov;
    ral = cfg.ral;
  endfunction

  // This function is invoked in pre_randomize(). Override it in the extended classes to configure
  // / control the randomization of this sequence.
  virtual function void configure_vseq();
  endfunction

  function void pre_randomize();
    // Set the handles in pre_randomize(), so that the knobs in cfg are available during sequence
    // randomization. This forces `p_sequencer` handle to be set before the randomization - users
    // are required to call `set_sequencer()` right after creating the sequence and before
    // randomizing it.
    if (cfg == null) set_handles();
    configure_vseq();
  endfunction

  task pre_start();
    super.pre_start();
    if (cfg == null) set_handles();
    if (do_dut_init) dut_init("HARD");
    num_trans.rand_mode(0);
  endtask

  task post_start();
    super.post_start();
    if (do_dut_shutdown) dut_shutdown();
  endtask

  /*
   * startup, reset and shutdown related tasks
   */
  virtual task dut_init(string reset_kind = "HARD");
    if (do_apply_reset) begin
      apply_reset(reset_kind);
      post_apply_reset(reset_kind);
    end else if (do_wait_for_reset) wait_for_reset(reset_kind);
    // delay after reset for tl agent check seq_item_port empty
    #1ps;
  endtask

  virtual task apply_reset(string kind = "HARD");
    if (kind == "HARD") begin
      if (cfg.clk_rst_vifs.size() > 0) begin
        fork
          begin : isolation_fork
            foreach (cfg.clk_rst_vifs[i]) begin
              automatic string ral_name = i;
              fork
                cfg.clk_rst_vifs[ral_name].apply_reset();
              join_none
            end
            wait fork;
          end : isolation_fork
        join
      end else begin // no ral model and only has default clk_rst_vif
        cfg.clk_rst_vif.apply_reset();
      end
    end // if (kind == "HARD")
  endtask

  // Apply all resets in the DUT concurrently to generate a random in-test reset scenario.
  //
  // - Assert resets concurrently to make sure all resets are issued.
  // - Deassert resets concurrently is a specific requirement of the `stress_all_with_rand_reset`
  // sequence, which will randomly issue resets and terminate the parallel sequence once all DUT
  // resets are deasserted. If DUT resets are deasserted at different time, the parallel sequence
  // might send a transaction request to driver between different resets are deasserting. Then when
  // `stress_all_with_rand_reset` sequence tries to terminate the parallel sequence, an UVM_ERROR
  // will be thrown by the sequencer saying `task responsible for requesting a wait_for_grant has
  // been killed`.
  // In order to ensure all resets at least being asserted for one clock cycle, this task takes an
  // optional input `reset_duration_ps` if the DUT has additional resets. The task uses this input
  // to compute the minimal time required to keep all resets asserted.
  virtual task apply_resets_concurrently(int reset_duration_ps = 0);
    int slowest_clk_period_ps = 0;
    int reset_duration_from_clks_ps;

    // Calculate the slowest clock that we see with a RAL model or fall back to the default
    // clk_rst_if if there is no RAL model.
    if (cfg.clk_rst_vifs.size() > 0) begin
      foreach (cfg.clk_rst_vifs[i]) begin
        slowest_clk_period_ps = max2(slowest_clk_period_ps, cfg.clk_rst_vifs[i].clk_period_ps);
      end
    end else begin
      slowest_clk_period_ps = cfg.clk_rst_vif.clk_period_ps;
    end

    // Pick the reset duration by picking a random number of (slowest) clock cycles, taking at least
    // two. Then use the maximum of that value and the reset_duration_ps argument.
    reset_duration_from_clks_ps = $urandom_range(2, 10) * slowest_clk_period_ps;
    reset_duration_ps = max2(reset_duration_ps, reset_duration_from_clks_ps);

    // Now apply the reset by driving any reset pins to zero, waiting a while, and then driving the
    // back to one.
    if (cfg.clk_rst_vifs.size() > 0) begin
      foreach (cfg.clk_rst_vifs[i]) cfg.clk_rst_vifs[i].drive_rst_pin(0);
      #(reset_duration_ps * 1ps);
      foreach (cfg.clk_rst_vifs[i]) cfg.clk_rst_vifs[i].drive_rst_pin(1);
    end else begin
      cfg.clk_rst_vif.drive_rst_pin(0);
      #(reset_duration_ps * 1ps);
      cfg.clk_rst_vif.drive_rst_pin(1);
    end
  endtask

  // This is called after apply_reset in this class and after apply_resets_concurrently
  // in cip_base_vseq::run_seq_with_rand_reset_vseq.
  virtual task post_apply_reset(string reset_kind = "HARD");
  endtask

  virtual task wait_for_reset(string reset_kind     = "HARD",
                              bit wait_for_assert   = 1,
                              bit wait_for_deassert = 1);
    if (wait_for_assert) begin
      `uvm_info(`gfn, "waiting for rst_n assertion...", UVM_MEDIUM)
      @(negedge cfg.clk_rst_vif.rst_n);
    end
    if (wait_for_deassert) begin
      `uvm_info(`gfn, "waiting for rst_n de-assertion...", UVM_MEDIUM)
      @(posedge cfg.clk_rst_vif.rst_n);
    end
    `uvm_info(`gfn, "wait_for_reset done", UVM_HIGH)
  endtask

  // dut shutdown - this is called in post_start if do_dut_shutdown bit is set
  virtual task dut_shutdown();
    csr_utils_pkg::wait_no_outstanding_access();
  endtask

  // wrapper task around run_csr_vseq - the purpose is to be able to call this directly for actual
  // csr tests (as opposed to higher level stress test that could also run csr seq as a fork by
  // calling run_csr_vseq(..) task)
  virtual task run_csr_vseq_wrapper(int num_times = 1, dv_base_reg_block models[$] = {});
    string        csr_test_type;

    // Env needs to have a ral instance.
    if (models.size() == 0) begin
      `DV_CHECK_GE_FATAL(cfg.ral_models.size(), 1)
    end

    // Get csr_test_type from plusarg
    void'($value$plusargs("csr_%0s", csr_test_type));

    // run the csr seq
    for (int i = 1; i <= num_times; i++) begin
      `uvm_info(`gfn, $sformatf("Running csr %0s vseq iteration %0d/%0d.",
                                csr_test_type, i, num_times), UVM_LOW)
      run_csr_vseq(.csr_test_type(csr_test_type), .models(models));
    end
  endtask

  // capture the entire csr seq as a task that can be overridden if desired
  // arg csr_test_type: what csr test to run {hw_reset, rw, bit_bash, aliasing}
  // arg num_test_csrs:instead of testing the entire ral model or passing test chunk info via
  // plusarg, provide ability to set a random number of csrs to test from higher level sequence
  // `models` is the list of RAL models to run the common sequences on.
  // `ral_name` is the string name of the RAL to run the common sequences on.
  // Both of these inputs are 'null' by default. If externally set, `models` takes precedence over
  // `ral_name`.
  virtual task run_csr_vseq(string csr_test_type,
                            int    num_test_csrs = 0,
                            bit    do_rand_wr_and_reset = 1,
                            dv_base_reg_block models[$] = {},
                            string ral_name = "");
    csr_base_seq m_csr_seq;

    // env needs to have at least one ral instance
    `DV_CHECK_GE_FATAL(cfg.ral_models.size(), 1)

    // Filter out the RAL blocks under test with the supplied name, if available.
    if (models.size() == 0) begin
      if (ral_name != "") begin
        `DV_CHECK_FATAL(cfg.ral_models.exists(ral_name))
        models.push_back(cfg.ral_models[ral_name]);
      end else begin
        foreach (cfg.ral_models[i]) models.push_back(cfg.ral_models[i]);
      end
    end

    // check which csr test type
    case (csr_test_type)
      "hw_reset": csr_base_seq::type_id::set_type_override(csr_hw_reset_seq::get_type());
      "rw"      : csr_base_seq::type_id::set_type_override(csr_rw_seq::get_type());
      "bit_bash": csr_base_seq::type_id::set_type_override(csr_bit_bash_seq::get_type());
      "aliasing": csr_base_seq::type_id::set_type_override(csr_aliasing_seq::get_type());
      "mem_walk": csr_base_seq::type_id::set_type_override(csr_mem_walk_seq::get_type());
      default   : `uvm_fatal(`gfn, $sformatf("specified opt is invalid: +csr_%0s", csr_test_type))
    endcase

    // Print the list of available exclusions that are in effect for debug.
    foreach (models[i]) begin
      csr_excl_item csr_excl = csr_utils_pkg::get_excl_item(models[i]);
      if (csr_excl != null) csr_excl.print_exclusions();
    end

    // if hw_reset test, then write all CSRs first and reset the whole dut
    if (csr_test_type == "hw_reset" && do_rand_wr_and_reset) begin
      string        reset_type = "HARD";
      csr_write_seq m_csr_write_seq;

      // Writing random values to CSRs might trigger assertion errors. So we disable in the entire
      // DUT hierarchy and re-enable after resetting the DUT. See DV_ASSERT_CTRL macro defined in
      // hw/dv/sv/dv_utils/dv_macros.svh for more details.
      if (!enable_asserts_in_hw_reset_rand_wr) begin
        `DV_ASSERT_CTRL_REQ("dut_assert_en", 1'b0)
      end

      // run write-only sequence to randomize the csr values
      m_csr_write_seq = csr_write_seq::type_id::create("m_csr_write_seq");
      m_csr_write_seq.models = models;
      m_csr_write_seq.external_checker = cfg.en_scb;
      m_csr_write_seq.en_rand_backdoor_write = 1'b1;
      m_csr_write_seq.start(null);

      // run dut_shutdown before asserting reset
      dut_shutdown();
      // issue reset
      void'($value$plusargs("do_reset=%0s", reset_type));
      dut_init(reset_type);
      if (!enable_asserts_in_hw_reset_rand_wr) begin
        `DV_ASSERT_CTRL_REQ("dut_assert_en", 1'b1)
      end
    end

    // create base csr seq and pass our ral
    m_csr_seq = csr_base_seq::type_id::create("m_csr_seq");
    m_csr_seq.models = models;
    m_csr_seq.external_checker = cfg.en_scb;
    m_csr_seq.max_num_test_csrs = num_test_csrs;
    m_csr_seq.start(null);
  endtask

  // enable/disable csr_assert
  virtual function void set_csr_assert_en(bit enable, string path = "*");
    uvm_config_db#(bit)::set(null, path, "csr_assert_en", enable);
  endfunction

  // Use the factory to create a sequence by name and return the resulting uvm_sequence.
  //
  // The created sequence should be an instance of the class where this function is defined.
  // Creating the sequence through this method rather than the underlying function,
  // dv_utils_pkg::create_seq_by_name, allows subclasses of dv_base_seq to copy information about
  // themselves (such as sequencers or other configuration) to the new sequence.
  virtual function uvm_sequence create_seq_by_name(string name);
    return dv_utils_pkg::create_seq_by_name(name);
  endfunction

  task check_interrupts(bit [BUS_DW-1:0]  interrupts,
                        bit               check_set,
                        bit [BUS_DW-1:0]  clear = '1);
    uvm_reg          csr_intr_state, csr_intr_enable;
    bit [BUS_DW-1:0] act_pins;
    bit [BUS_DW-1:0] exp_pins;
    bit [BUS_DW-1:0] exp_intr_state;

    if (cfg.under_reset) return;

    act_pins = cfg.intr_vif.sample() & interrupts;
    if (check_set) begin
      csr_intr_enable = ral.get_dv_base_reg_by_name("intr_enable");
      exp_pins = interrupts & csr_intr_enable.get_mirrored_value();
      exp_intr_state = interrupts;
    end else begin
      exp_pins = '0;
      exp_intr_state = ~interrupts;
    end
    `DV_CHECK_EQ(act_pins, exp_pins)
    csr_intr_state = ral.get_dv_base_reg_by_name("intr_state");
    csr_rd_check(.ptr(csr_intr_state), .compare_value(exp_intr_state), .compare_mask(interrupts));

    if (check_set && |(interrupts & clear)) begin
      csr_wr(.ptr(csr_intr_state), .value(interrupts & clear));
    end
  endtask

  local function void disable_coverage_sample_for_csr_test();
    `uvm_info(`gfn, "mubi reg coverage sampling is disabled as this is a CSR test", UVM_HIGH)
    foreach (all_csrs[i]) begin
      dv_base_reg_field fields[$];

      all_csrs[i].get_dv_base_reg_fields(fields);
      // assign null to all mubi_cov object, so that coverage sampling is skipped
      foreach (fields[j]) fields[j].mubi_cov = null;
    end
  endfunction

  local task run_seq_with_rand_reset_vseq(uvm_sequence seq,
                                          int unsigned num_times,
                                          int unsigned reset_delay_bound);
    // Populate
  endtask

  local task run_same_csr_outstanding_vseq(int unsigned num_times);
    // Populate
  endtask

  local task run_shadow_reg_errors(int unsigned num_times, bit en_csr_rw_seq = 0);
    // Populate
  endtask

  local task run_mem_partial_access_vseq(int unsigned num_times);
    // Populate
  endtask

  local task run_csr_mem_rw_with_rand_reset_vseq(int unsigned num_times);
    // Populate
  endtask

  local task run_csr_mem_rw_vseq(int unsigned num_times);
    // Populate
  endtask

  local task run_sec_cm_fi_vseq(int unsigned num_times);
    // Populate
  endtask

  local task run_plusarg_vseq_with_rand_reset(int unsigned num_times);
    string stress_seq_name;
    int had_stress_seq_plusarg = $value$plusargs("stress_seq=%0s", stress_seq_name);
    `DV_CHECK_FATAL(had_stress_seq_plusarg)

    run_seq_with_rand_reset_vseq(.seq(create_seq_by_name(stress_seq_name)),
                                 .num_times(num_times),
                                 .reset_delay_bound(100_000));
  endtask

  local task run_intr_test_vseq(int unsigned num_times);
    import dv_utils_pkg::interrupt_t;
    dv_base_reg intr_csrs[$];
    dv_base_reg intr_test_csrs[$];

    foreach (all_csrs[i]) begin
      string csr_name = all_csrs[i].get_name();
      if (!uvm_re_match("intr_test*", csr_name) ||
          !uvm_re_match("intr_enable*", csr_name) ||
          !uvm_re_match("intr_state*", csr_name)) begin
        intr_csrs.push_back(ral.get_dv_base_reg_by_name(csr_name));
      end
      if (!uvm_re_match("intr_test*", csr_name)) begin
        intr_test_csrs.push_back(ral.get_dv_base_reg_by_name(csr_name));
      end
    end

    // Checking the intr_test register works only makes sense if there is at least one interrupt
    // register. We shouldn't call this sequence for blocks that don't have one, so let's fail
    // understandably if we have done so by accident.
    `DV_CHECK(intr_csrs.size() > 0, "Called intr_test vseq without any interrupt register.")

    num_times = num_times * intr_csrs.size();
    for (int trans = 1; trans <= num_times; trans++) begin
      bit [BUS_DW-1:0] num_used_bits;
      bit [BUS_DW-1:0] intr_enable_val[$];
      `uvm_info(`gfn, $sformatf("Running intr test iteration %0d/%0d", trans, num_times), UVM_LOW)

      // Random Write to all intr related registers
      intr_csrs.shuffle();
      foreach (intr_csrs[i]) begin
        uvm_reg_data_t data = $urandom();
        `uvm_info(`gfn, $sformatf("Write %s: 0x%0h", intr_csrs[i].`gfn, data), UVM_MEDIUM)
        csr_wr(.ptr(intr_csrs[i]), .value(data));
        if (cfg.under_reset) break;
      end

      // Read all intr related csr and check interrupt pins
      intr_csrs.shuffle();
      foreach (intr_csrs[i]) begin
        uvm_reg_data_t exp_val = `gmv(intr_csrs[i]);
        uvm_reg_data_t act_val;

        interrupt_t irq_ro_mask = '0;

        // Status type interrupts have RO fields in intr_state, so mask those bits off here as they
        // can't be generically predicted for all IPs.
        if (!uvm_re_match("intr_state*", intr_csrs[i].get_name())) begin
          irq_ro_mask = intr_csrs[i].get_ro_mask();
        end

        exp_val &= ~irq_ro_mask;

        csr_rd(.ptr(intr_csrs[i]), .value(act_val));
        act_val &= ~irq_ro_mask;

        if (cfg.under_reset) break;
        `uvm_info(`gfn, $sformatf("Read %s: 0x%0h", intr_csrs[i].get_full_name(), act_val),
                  UVM_MEDIUM)
        if (intr_csrs[i].get_predicted_mask() == 0) begin
          `DV_CHECK_EQ(exp_val, act_val, {"when reading the intr CSR ",
                                          intr_csrs[i].get_full_name()})

          // if it's intr_state, also check the interrupt pin value
          if (!uvm_re_match("intr_state*", intr_csrs[i].get_name())) begin
            interrupt_t exp_intr_pin = intr_csrs[i].get_intr_pins_exp_value();
            interrupt_t act_intr_pin = cfg.intr_vif.sample();
            act_intr_pin &= interrupt_t'((1 << cfg.num_interrupts) - 1);
            `DV_CHECK_CASE_EQ(exp_intr_pin, act_intr_pin)
          end // if (!uvm_re_match
        end
      end // foreach (intr_csrs[i])
    end
    // Write 0 to intr_test to clean up status interrupts, otherwise, status interrupts may remain
    // active. And writing any value to a status interrupt CSR (intr_state) can't clear its value.
    foreach (intr_test_csrs[i]) begin
      csr_wr(.ptr(intr_test_csrs[i]), .value(0));
    end
  endtask

  protected virtual task run_common_vseq_wrapper(int num_times = 1);
    if (common_seq_type == "") void'($value$plusargs("run_%0s", common_seq_type));

    disable_coverage_sample_for_csr_test();

    // check which test type
    case (common_seq_type)
      "intr_test":                     run_intr_test_vseq(num_times);
      // Each iteration only issues at most one reset. Increase to send at least 5 X num_times.
      "stress_all_with_rand_reset":    run_plusarg_vseq_with_rand_reset(5 * num_times);
      "same_csr_outstanding":          run_same_csr_outstanding_vseq(num_times);
      "shadow_reg_errors":             run_shadow_reg_errors(num_times);
      "shadow_reg_errors_with_csr_rw": run_shadow_reg_errors(num_times, 1);
      "mem_partial_access":            run_mem_partial_access_vseq(num_times);
      "csr_mem_rw_with_rand_reset":    run_csr_mem_rw_with_rand_reset_vseq(num_times);
      "csr_mem_rw":                    run_csr_mem_rw_vseq(num_times);
      // Increase iteration, otherwise each sec_cm is only tested 1-2 times
      "sec_cm_fi":                     run_sec_cm_fi_vseq(10 * num_times);
      default:                         run_csr_vseq_wrapper(num_times);
    endcase
  endtask

endclass
