// Copyright lowRISC contributors (OpenTitan project).
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

class dv_base_env #(type CFG_T               = dv_base_env_cfg,
                    type VIRTUAL_SEQUENCER_T = dv_base_virtual_sequencer,
                    type SCOREBOARD_T        = dv_base_scoreboard,
                    type COV_T               = dv_base_env_cov) extends uvm_env;
  `uvm_component_param_utils(dv_base_env #(CFG_T, VIRTUAL_SEQUENCER_T, SCOREBOARD_T, COV_T))

  CFG_T                      cfg;
  VIRTUAL_SEQUENCER_T        virtual_sequencer;
  SCOREBOARD_T               scoreboard;
  COV_T                      cov;
  ahb_mgr_agent              ahb_agent;

  // A reg_predictor used for update and mirror register values.
  local uvm_reg_predictor #(ahb_txn_item) m_reg_predictor;

  `uvm_component_new

  virtual function void build_phase(uvm_phase phase);
    string ral_models[$];

    super.build_phase(phase);
    // get dv_base_env_cfg object from uvm_config_db
    if (!uvm_config_db#(CFG_T)::get(this, "", "cfg", cfg)) begin
      `uvm_fatal(`gfn, $sformatf("failed to get %s from uvm_config_db", cfg.get_type_name()))
    end

    // Get interrupt interface from uvm_config_db.
    if (!uvm_config_db#(intr_vif)::get(this, "", "intr_vif", cfg.intr_vif) &&
        cfg.num_interrupts > 0) begin
      `uvm_fatal(get_full_name(), "failed to get intr_vif from uvm_config_db")
    end

    // Get AHB sub-ordinate index from uvm_config_db.
    if (!uvm_config_db#(int unsigned)::get(this, "", "ahb_subordinate_index",
                                           cfg.m_subordinate_idx)) begin
      `uvm_fatal(get_full_name(), "No subordinate index supplied to environment.")
    end

    // Make sure the map in cfg from RAL name to clk_rst_if is populated. Copy the clock frequencies
    // chosen by cfg to the interfaces.
    ral_models = cfg.get_ral_model_names();
    if (ral_models.size() > 0) begin
      string default_ral_name = cfg.ral.get_type_name();
      foreach (ral_models[i]) begin
        string ral_name = ral_models[i];
        configure_clk_rst_vif(ral_name, (ral_name == default_ral_name));
      end

      // assign default clk_rst_vif
      `DV_CHECK_FATAL(cfg.clk_rst_vifs.exists(default_ral_name))
      cfg.clk_rst_vif = cfg.clk_rst_vifs[default_ral_name];
    end else begin
      // no RAL model, get the default clk_rst_vif for the block
      // such as xbar, it doesn't has ral model, but it also needs a default clk_rst_vif
      if (cfg.clk_rst_vif == null &&
          !uvm_config_db#(virtual clk_rst_if)::get(this, "", "clk_rst_vif", cfg.clk_rst_vif)) begin
        `uvm_fatal(get_full_name(), "Failed to get clk_rst_if from uvm_config_db")
      end
      cfg.clk_rst_vif.set_freq_mhz(cfg.clk_freq_mhz);
    end

    // Create AHB manager agent
    ahb_agent = ahb_mgr_agent::type_id::create("ahb_agent", this);

    m_reg_predictor = uvm_reg_predictor#(ahb_txn_item)::type_id::create("m_reg_predictor", this);
    m_reg_predictor.adapter = ahb_mgr_reg_adapter::type_id::create("adapter");
    m_reg_predictor.map = cfg.ral.default_map;

    if (cfg.en_cov) begin
      cov = COV_T::type_id::create("cov", this);
      cov.cfg = cfg;
    end

    if (cfg.is_active) begin
      virtual_sequencer = VIRTUAL_SEQUENCER_T::type_id::create("virtual_sequencer", this);
      virtual_sequencer.cfg = cfg;
      virtual_sequencer.cov = cov;
    end

    // scb also monitors the reset and call cfg.reset_asserted/reset_deasserted for reset
    scoreboard = SCOREBOARD_T::type_id::create("scoreboard", this);
    scoreboard.cfg = cfg;
    scoreboard.cov = cov;
  endfunction

  // If cfg doesn't already have the vif, look up a clk_rst_if for ral_name in uvm_config_db. Either
  // way, copy the selected clock frequency to the interface.
  //
  // This should be called after the frequency has been selected for ral_name (which happens as part
  // of randomisation after setup with initialize())
  local function void configure_clk_rst_vif(string ral_name, bit is_default_ral_name);
    string if_name = is_default_ral_name ? "clk_rst_vif" : {"clk_rst_vif_", ral_name};

    // If cfg doesn't already have the interface look one up in the config_db
    if (!cfg.clk_rst_vifs.exists(ral_name) &&
        !uvm_config_db#(virtual clk_rst_if)::get(this, "",
                                                 if_name, cfg.clk_rst_vifs[ral_name])) begin
      `uvm_fatal(get_full_name(), $sformatf("No clk_rst_if called %0s in uvm_config_db", ral_name))
    end

    cfg.clk_rst_vifs[ral_name].set_freq_mhz(cfg.clk_freqs_mhz[ral_name]);
  endfunction

  function void connect_phase(uvm_phase phase);
    uvm_reg_map maps[$];

    super.connect_phase(phase);

    // Bind the RAL default_map to the AHB sequencer + adapter so register accesses are issued via
    // the AHB agent.
    if (ahb_agent.get_is_active() == UVM_ACTIVE) begin
      cfg.ral.default_map.set_sequencer(ahb_agent.get_register_layering_sequencer(),
                                        ahb_agent.get_reg_adapter());
    end

    // Tell the AHB agent which registers are mapped to which subordinate.
    cfg.ral.get_maps(maps);
    foreach (maps[i]) begin
      ahb_agent.register_subordinate_for_map(maps[i], cfg.m_subordinate_idx);
    end

    ahb_agent.m_transaction_port.connect(m_reg_predictor.bus_in);
  endfunction
endclass
