// Copyright lowRISC contributors (OpenTitan project).
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

package dv_lib_pkg;
  // dep packages
  import uvm_pkg::*;
  import dv_utils_pkg::*;
  import csr_utils_pkg::*;
  import dv_base_reg_pkg::*;
  import dv_base_agent_pkg::*;
  import prim_mubi_pkg::*;
  import ahb_agent_pkg::*;

  // macro includes
  `include "uvm_macros.svh"
  `include "dv_macros.svh"

  // package variables
  string msg_id = "dv_lib_pkg";

  // AHB bus data width
  parameter int unsigned BUS_DW = 32;

  // Create functions that return a random value for the mubi type variable, based on weight
  // settings.
  //
  // The function is `get_rand_mubi4|8|16_val(t_weight, f_weight, other_weight)`
  // t_weight: randomization weight of the value True
  // f_weight: randomization weight of the value False
  // other_weight: collective randomization weight of all values other than True or False
  `define _DV_MUBI_RAND_VAL(WIDTH_)                                         \
    function automatic mubi``WIDTH_``_t get_rand_mubi``WIDTH_``_val(        \
        int t_weight = 2, int f_weight = 2, int other_weight = 1);          \
      bit[WIDTH_-1:0] val;                                                  \
      `DV_CHECK_STD_RANDOMIZE_WITH_FATAL(val,                               \
          `DV_MUBI``WIDTH_``_DIST(val, t_weight, f_weight, other_weight), , \
                                         msg_id)                            \
      return mubi``WIDTH_``_t'(val);                                        \
    endfunction

  // Create function - get_rand_mubi4_val.
  `_DV_MUBI_RAND_VAL(4)

  // Create function - get_rand_mubi8_val.
  `_DV_MUBI_RAND_VAL(8)

  // Create function - get_rand_mubi12_val.
  `_DV_MUBI_RAND_VAL(12)

  // Create function - get_rand_mubi16_val.
  `_DV_MUBI_RAND_VAL(16)

  `undef _DV_MUBI_RAND_VAL

  // package sources

  // base env
  `include "dv_base_env_cfg.sv"
  `include "bit_toggle_cg_wrap.sv"
  `include "dv_base_env_cov.sv"
  `include "dv_base_virtual_sequencer.sv"
  `include "dv_base_scoreboard.sv"
  `include "dv_base_env.sv"

  // base test vseq
  `include "dv_base_vseq.sv"

  // base test
  `include "dv_base_test.sv"

endpackage
