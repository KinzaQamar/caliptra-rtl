// SPDX-License-Identifier: Apache-2.0
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

class csrng_reg_block extends csrng;
    `uvm_object_utils(csrng_reg_block)

    function new(string name = "csrng_reg_block");
        super.new(name);
    endfunction

    function void add_hdl_path_intr_state();
        INTERRUPT_STATE.add_hdl_path_slice("u_reg.u_intr_state_cs_cmd_req_done.q",
                                           0,
                                           1,
                                           0,
                                           "BkdrRegPathRtl");
        INTERRUPT_STATE.add_hdl_path_slice("u_reg.u_intr_state_cs_entropy_req.q",
                                           1,
                                           1,
                                           0,
                                           "BkdrRegPathRtl");
        INTERRUPT_STATE.add_hdl_path_slice("u_reg.u_intr_state_cs_hw_inst_exc.q",
                                           2,
                                           1,
                                           0,
                                           "BkdrRegPathRtl");
        INTERRUPT_STATE.add_hdl_path_slice("u_reg.u_intr_state_cs_fatal_err.q",
                                           3,
                                           1,
                                           0,
                                           "BkdrRegPathRtl");
    endfunction

    function void add_hdl_path_intr_enable();
        INTERRUPT_ENABLE.add_hdl_path_slice("u_reg.u_intr_enable_cs_cmd_req_done.q",
                                       0,
                                       1,
                                       0,
                                       "BkdrRegPathRtl");
        INTERRUPT_ENABLE.add_hdl_path_slice("u_reg.u_intr_enable_cs_entropy_req.q",
                                       1,
                                       1,
                                       0,
                                       "BkdrRegPathRtl");
        INTERRUPT_ENABLE.add_hdl_path_slice("u_reg.u_intr_enable_cs_hw_inst_exc.q",
                                       2,
                                       1,
                                       0,
                                       "BkdrRegPathRtl");
        INTERRUPT_ENABLE.add_hdl_path_slice("u_reg.u_intr_enable_cs_fatal_err.q",
                                       3,
                                       1,
                                       0,
                                       "BkdrRegPathRtl");
    endfunction

    function void add_hdl_path_regwen();
        REGWEN.add_hdl_path_slice("u_reg.u_regwen.q",
                                  0,
                                  1,
                                  0,
                                  "BkdrRegPathRtl");
    endfunction

    function void add_hdl_path_ctrl();
        CTRL.add_hdl_path_slice("u_reg.u_ctrl_enable.q",
                                0,
                                4,
                                0,
                                "BkdrRegPathRtl");
        CTRL.add_hdl_path_slice("u_reg.u_ctrl_sw_app_enable.q",
                                4,
                                4,
                                0,
                                "BkdrRegPathRtl");
        CTRL.add_hdl_path_slice("u_reg.u_ctrl_read_int_state.q",
                                8,
                                4,
                                0,
                                "BkdrRegPathRtl");
        CTRL.add_hdl_path_slice("u_reg.u_ctrl_fips_force_enable.q",
                                12, 
                                4,
                                0,
                                "BkdrRegPathRtl");
    endfunction

    function void add_hdl_path_cmd_req();
        CMD_REQ.add_hdl_path_slice("u_reg.u_cmd_req.q",
                                   0,
                                   32,
                                   0,
                                   "BkdrRegPathRtl");
    endfunction

    function void add_hdl_path_reseed_interval();
        RESEED_INTERVAL.add_hdl_path_slice("u_reg.u_reseed_interval.q",
                                           0,
                                           32,
                                           0,
                                           "BkdrRegPathRtl");
    endfunction

    function void add_hdl_path_reseed_counter();
        foreach(RESEED_COUNTER[i])
            RESEED_COUNTER[i].add_hdl_path_slice($sformatf("u_reg.u_reseed_counter_%0d.qs", i),
                                                           0,
                                                           32,
                                                           0,
                                                           "BkdrRegPathRtl");
    endfunction

    function void add_hdl_path_sw_cmd_sts();
        SW_CMD_STS.add_hdl_path_slice("u_reg.u_sw_cmd_sts_cmd_rdy.q",
                                      1,
                                      1,
                                      0,
                                      "BkdrRegPathRtl");
        SW_CMD_STS.add_hdl_path_slice("u_reg.u_sw_cmd_sts_cmd_ack.q",
                                      2,
                                      1,
                                      0,
                                      "BkdrRegPathRtl");
        SW_CMD_STS.add_hdl_path_slice("u_reg.u_sw_cmd_sts_cmd_sts.q",
                                      3,
                                      3,
                                      0,
                                      "BkdrRegPathRtl");
    endfunction

    function void add_hdl_path_sw_genbits_vld();
        GENBITS_VLD.add_hdl_path_slice("u_reg.u_genbits_vld_genbits_vld.qs",
                                       0,
                                       1,
                                       0,
                                       "BkdrRegPathRtl");
        GENBITS_VLD.add_hdl_path_slice("u_reg.u_genbits_vld_genbits_fips.qs",
                                       1,
                                       1,
                                       0,
                                       "BkdrRegPathRtl");
    endfunction

    function void add_hdl_path_sw_genbits();
        GENBITS.add_hdl_path_slice("u_reg.u_genbits.qs",
                                   0,
                                   32,
                                   0,
                                   "BkdrRegPathRtl");
    endfunction

    function void add_hdl_path_sw_int_state_read_enable();
        INT_STATE_READ_ENABLE.add_hdl_path_slice("u_reg.u_int_state_read_enable.q",
                                                 0,
                                                 3,
                                                 0,
                                                 "BkdrRegPathRtl");
    endfunction

    function void add_hdl_path_sw_int_state_read_regwen();
        INT_STATE_READ_ENABLE_REGWEN.add_hdl_path_slice("u_reg.u_int_state_read_enable_regwen.q",
                                                        0,
                                                        1,
                                                        0,
                                                        "BkdrRegPathRtl");
    endfunction

    function void add_hdl_path_sw_int_state_num();
        INT_STATE_NUM.add_hdl_path_slice("u_reg.u_int_state_num.q",
                                         0,
                                         4,
                                         0,
                                         "BkdrRegPathRtl");
    endfunction

    function void add_hdl_path_sw_int_state_val();
        INT_STATE_VAL.add_hdl_path_slice("u_reg.u_int_state_val.qs",
                                         0,
                                         32,
                                         0,
                                         "BkdrRegPathRtl");
    endfunction

    function void add_hdl_path_fips_force();
        FIPS_FORCE.add_hdl_path_slice("u_reg.u_fips_force.q",
                                      0,
                                      3,
                                      0,
                                      "BkdrRegPathRtl");
    endfunction

    function void add_hdl_path_hw_exc_sts();
        HW_EXC_STS.add_hdl_path_slice("u_reg.u_hw_exc_sts.q",
                                      0,
                                      16,
                                      0,
                                      "BkdrRegPathRtl");
    endfunction

    function void add_hdl_path_err_code();
        ERR_CODE.add_hdl_path_slice("u_reg.u_err_code_sfifo_cmd_err.q",
                                    0,
                                    1,
                                    0,
                                    "BkdrRegPathRtl");
        ERR_CODE.add_hdl_path_slice("u_reg.u_err_code_sfifo_genbits_err.q",
                                    1,
                                    1,
                                    0,
                                    "BkdrRegPathRtl");
        ERR_CODE.add_hdl_path_slice("u_reg.u_err_code_cmd_stage_sm_err.q",
                                    20,
                                    1,
                                    0,
                                    "BkdrRegPathRtl");
        ERR_CODE.add_hdl_path_slice("u_reg.u_err_code_main_sm_err.q",
                                    21,
                                    1,
                                    0,
                                    "BkdrRegPathRtl");
        ERR_CODE.add_hdl_path_slice("u_reg.u_err_code_ctr_drbg_sm_err.q",
                                    22,
                                    1,
                                    0,
                                    "BkdrRegPathRtl");
        ERR_CODE.add_hdl_path_slice("u_reg.u_err_code_aes_cipher_sm_err.q",
                                    25,
                                    1,
                                    0,
                                    "BkdrRegPathRtl");
        ERR_CODE.add_hdl_path_slice("u_reg.u_err_code_ctr_err.q",
                                    26,
                                    1,
                                    0,
                                    "BkdrRegPathRtl");
        ERR_CODE.add_hdl_path_slice("u_reg.u_err_code_fifo_write_err.q",
                                    28,
                                    1,
                                    0,
                                    "BkdrRegPathRtl");
        ERR_CODE.add_hdl_path_slice("u_reg.u_err_code_fifo_read_err.q",
                                    29,
                                    1,
                                    0,
                                    "BkdrRegPathRtl");
        ERR_CODE.add_hdl_path_slice("u_reg.u_err_code_fifo_state_err.q",
                                    30,
                                    1,
                                    0,
                                    "BkdrRegPathRtl");
    endfunction : add_hdl_path_err_code

    function void add_hdl_path_err_code_test();
        ERR_CODE_TEST.add_hdl_path_slice("u_reg.u_err_code_test.q",
                                         0,
                                         5,
                                         0,
                                         "BkdrRegPathRtl");
    endfunction

    function void add_hdl_path_main_sm_state();
        MAIN_SM_STATE.add_hdl_path_slice("u_reg.u_main_sm_state.q",
                                         0,
                                         6,
                                         0,
                                         "BkdrRegPathRtl");
    endfunction

    function void build();
        super.build();

        set_hdl_path_root("tb.dut", "BkdrRegPathRtl");
        set_hdl_path_root("tb.dut", "BkdrRegPathRtlShadow");

        add_hdl_path_intr_state();
        add_hdl_path_intr_enable();
        add_hdl_path_regwen();
        add_hdl_path_ctrl();
        add_hdl_path_cmd_req();
        add_hdl_path_reseed_interval();
        add_hdl_path_reseed_counter();
        add_hdl_path_sw_cmd_sts();
        add_hdl_path_sw_genbits_vld();
        add_hdl_path_sw_genbits();
        add_hdl_path_sw_int_state_read_enable();
        add_hdl_path_sw_int_state_read_regwen();
        add_hdl_path_sw_int_state_num();
        add_hdl_path_sw_int_state_val();
        add_hdl_path_fips_force();
        add_hdl_path_hw_exc_sts();
        add_hdl_path_err_code();
        add_hdl_path_err_code_test();
        add_hdl_path_main_sm_state();
    endfunction

endclass : csrng_reg_block
