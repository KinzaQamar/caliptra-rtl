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

`ifndef CSRNG_COVERGROUPS
    `define CSRNG_COVERGROUPS
    
    /*----------------------- CSRNG__INTERRUPT_STATE COVERGROUPS -----------------------*/
    covergroup csrng__INTERRUPT_STATE_bit_cg with function sample(input bit reg_bit);
        option.per_instance = 1;
        reg_bit_cp : coverpoint reg_bit {
            bins value[2] = {0,1};
        }
        reg_bit_edge_cp : coverpoint reg_bit {
            bins rise = (0 => 1);
            bins fall = (1 => 0);
        }

    endgroup
    covergroup csrng__INTERRUPT_STATE_fld_cg with function sample(
    input bit [1-1:0] CS_CMD_REQ_DONE,
    input bit [1-1:0] CS_ENTROPY_REQ,
    input bit [1-1:0] CS_HW_INST_EXC,
    input bit [1-1:0] CS_FATAL_ERR
    );
        option.per_instance = 1;
        CS_CMD_REQ_DONE_cp : coverpoint CS_CMD_REQ_DONE;
        CS_ENTROPY_REQ_cp : coverpoint CS_ENTROPY_REQ;
        CS_HW_INST_EXC_cp : coverpoint CS_HW_INST_EXC;
        CS_FATAL_ERR_cp : coverpoint CS_FATAL_ERR;

    endgroup

    /*----------------------- CSRNG__INTERRUPT_ENABLE COVERGROUPS -----------------------*/
    covergroup csrng__INTERRUPT_ENABLE_bit_cg with function sample(input bit reg_bit);
        option.per_instance = 1;
        reg_bit_cp : coverpoint reg_bit {
            bins value[2] = {0,1};
        }
        reg_bit_edge_cp : coverpoint reg_bit {
            bins rise = (0 => 1);
            bins fall = (1 => 0);
        }

    endgroup
    covergroup csrng__INTERRUPT_ENABLE_fld_cg with function sample(
    input bit [1-1:0] CS_CMD_REQ_DONE,
    input bit [1-1:0] CS_ENTROPY_REQ,
    input bit [1-1:0] CS_HW_INST_EXC,
    input bit [1-1:0] CS_FATAL_ERR
    );
        option.per_instance = 1;
        CS_CMD_REQ_DONE_cp : coverpoint CS_CMD_REQ_DONE;
        CS_ENTROPY_REQ_cp : coverpoint CS_ENTROPY_REQ;
        CS_HW_INST_EXC_cp : coverpoint CS_HW_INST_EXC;
        CS_FATAL_ERR_cp : coverpoint CS_FATAL_ERR;

    endgroup

    /*----------------------- CSRNG__INTERRUPT_TEST COVERGROUPS -----------------------*/
    covergroup csrng__INTERRUPT_TEST_bit_cg with function sample(input bit reg_bit);
        option.per_instance = 1;
        reg_bit_cp : coverpoint reg_bit {
            bins value[2] = {0,1};
        }
        reg_bit_edge_cp : coverpoint reg_bit {
            bins rise = (0 => 1);
            bins fall = (1 => 0);
        }

    endgroup
    covergroup csrng__INTERRUPT_TEST_fld_cg with function sample(
    input bit [1-1:0] CS_CMD_REQ_DONE,
    input bit [1-1:0] CS_ENTROPY_REQ,
    input bit [1-1:0] CS_HW_INST_EXC,
    input bit [1-1:0] CS_FATAL_ERR
    );
        option.per_instance = 1;
        CS_CMD_REQ_DONE_cp : coverpoint CS_CMD_REQ_DONE;
        CS_ENTROPY_REQ_cp : coverpoint CS_ENTROPY_REQ;
        CS_HW_INST_EXC_cp : coverpoint CS_HW_INST_EXC;
        CS_FATAL_ERR_cp : coverpoint CS_FATAL_ERR;

    endgroup

    /*----------------------- CSRNG__ALERT_TEST COVERGROUPS -----------------------*/
    covergroup csrng__ALERT_TEST_bit_cg with function sample(input bit reg_bit);
        option.per_instance = 1;
        reg_bit_cp : coverpoint reg_bit {
            bins value[2] = {0,1};
        }
        reg_bit_edge_cp : coverpoint reg_bit {
            bins rise = (0 => 1);
            bins fall = (1 => 0);
        }

    endgroup
    covergroup csrng__ALERT_TEST_fld_cg with function sample(
    input bit [1-1:0] RECOV_ALERT,
    input bit [1-1:0] FATAL_ALERT
    );
        option.per_instance = 1;
        RECOV_ALERT_cp : coverpoint RECOV_ALERT;
        FATAL_ALERT_cp : coverpoint FATAL_ALERT;

    endgroup

    /*----------------------- CSRNG__REGWEN COVERGROUPS -----------------------*/
    covergroup csrng__REGWEN_bit_cg with function sample(input bit reg_bit);
        option.per_instance = 1;
        reg_bit_cp : coverpoint reg_bit {
            bins value[2] = {0,1};
        }
        reg_bit_edge_cp : coverpoint reg_bit {
            bins rise = (0 => 1);
            bins fall = (1 => 0);
        }

    endgroup
    covergroup csrng__REGWEN_fld_cg with function sample(
    input bit [1-1:0] REGWEN
    );
        option.per_instance = 1;
        REGWEN_cp : coverpoint REGWEN;

    endgroup

    /*----------------------- CSRNG__CTRL COVERGROUPS -----------------------*/
    covergroup csrng__CTRL_bit_cg with function sample(input bit reg_bit);
        option.per_instance = 1;
        reg_bit_cp : coverpoint reg_bit {
            bins value[2] = {0,1};
        }
        reg_bit_edge_cp : coverpoint reg_bit {
            bins rise = (0 => 1);
            bins fall = (1 => 0);
        }

    endgroup
    covergroup csrng__CTRL_fld_cg with function sample(
    input bit [4-1:0] ENABLE,
    input bit [4-1:0] SW_APP_ENABLE,
    input bit [4-1:0] READ_INT_STATE,
    input bit [4-1:0] FIPS_FORCE_ENABLE
    );
        option.per_instance = 1;
        ENABLE_cp : coverpoint ENABLE;
        SW_APP_ENABLE_cp : coverpoint SW_APP_ENABLE;
        READ_INT_STATE_cp : coverpoint READ_INT_STATE;
        FIPS_FORCE_ENABLE_cp : coverpoint FIPS_FORCE_ENABLE;

    endgroup

    /*----------------------- CSRNG__CMD_REQ COVERGROUPS -----------------------*/
    covergroup csrng__CMD_REQ_bit_cg with function sample(input bit reg_bit);
        option.per_instance = 1;
        reg_bit_cp : coverpoint reg_bit {
            bins value[2] = {0,1};
        }
        reg_bit_edge_cp : coverpoint reg_bit {
            bins rise = (0 => 1);
            bins fall = (1 => 0);
        }

    endgroup
    covergroup csrng__CMD_REQ_fld_cg with function sample(
    input bit [4-1:0] acmd,
    input bit [4-1:0] clen,
    input bit [4-1:0] flag0,
    input bit [13-1:0] glen
    );
        option.per_instance = 1;
        acmd_cp : coverpoint acmd;
        clen_cp : coverpoint clen;
        flag0_cp : coverpoint flag0;
        glen_cp : coverpoint glen;

    endgroup

    /*----------------------- CSRNG__RESEED_INTERVAL COVERGROUPS -----------------------*/
    covergroup csrng__RESEED_INTERVAL_bit_cg with function sample(input bit reg_bit);
        option.per_instance = 1;
        reg_bit_cp : coverpoint reg_bit {
            bins value[2] = {0,1};
        }
        reg_bit_edge_cp : coverpoint reg_bit {
            bins rise = (0 => 1);
            bins fall = (1 => 0);
        }

    endgroup
    covergroup csrng__RESEED_INTERVAL_fld_cg with function sample(
    input bit [32-1:0] RESEED_INTERVAL
    );
        option.per_instance = 1;
        RESEED_INTERVAL_cp : coverpoint RESEED_INTERVAL;

    endgroup

    /*----------------------- CSRNG__RESEED_COUNTER COVERGROUPS -----------------------*/
    covergroup csrng__RESEED_COUNTER_bit_cg with function sample(input bit reg_bit);
        option.per_instance = 1;
        reg_bit_cp : coverpoint reg_bit {
            bins value[2] = {0,1};
        }
        reg_bit_edge_cp : coverpoint reg_bit {
            bins rise = (0 => 1);
            bins fall = (1 => 0);
        }

    endgroup
    covergroup csrng__RESEED_COUNTER_fld_cg with function sample(
    input bit [32-1:0] RESEED_COUNTER
    );
        option.per_instance = 1;
        RESEED_COUNTER_cp : coverpoint RESEED_COUNTER;

    endgroup

    /*----------------------- CSRNG__SW_CMD_STS COVERGROUPS -----------------------*/
    covergroup csrng__SW_CMD_STS_bit_cg with function sample(input bit reg_bit);
        option.per_instance = 1;
        reg_bit_cp : coverpoint reg_bit {
            bins value[2] = {0,1};
        }
        reg_bit_edge_cp : coverpoint reg_bit {
            bins rise = (0 => 1);
            bins fall = (1 => 0);
        }

    endgroup
    covergroup csrng__SW_CMD_STS_fld_cg with function sample(
    input bit [1-1:0] CMD_RDY,
    input bit [1-1:0] CMD_ACK,
    input bit [3-1:0] CMD_STS
    );
        option.per_instance = 1;
        CMD_RDY_cp : coverpoint CMD_RDY;
        CMD_ACK_cp : coverpoint CMD_ACK;
        CMD_STS_cp : coverpoint CMD_STS;

    endgroup

    /*----------------------- CSRNG__GENBITS_VLD COVERGROUPS -----------------------*/
    covergroup csrng__GENBITS_VLD_bit_cg with function sample(input bit reg_bit);
        option.per_instance = 1;
        reg_bit_cp : coverpoint reg_bit {
            bins value[2] = {0,1};
        }
        reg_bit_edge_cp : coverpoint reg_bit {
            bins rise = (0 => 1);
            bins fall = (1 => 0);
        }

    endgroup
    covergroup csrng__GENBITS_VLD_fld_cg with function sample(
    input bit [1-1:0] GENBITS_VLD,
    input bit [1-1:0] GENBITS_FIPS
    );
        option.per_instance = 1;
        GENBITS_VLD_cp : coverpoint GENBITS_VLD;
        GENBITS_FIPS_cp : coverpoint GENBITS_FIPS;

    endgroup

    /*----------------------- CSRNG__GENBITS COVERGROUPS -----------------------*/
    covergroup csrng__GENBITS_bit_cg with function sample(input bit reg_bit);
        option.per_instance = 1;
        reg_bit_cp : coverpoint reg_bit {
            bins value[2] = {0,1};
        }
        reg_bit_edge_cp : coverpoint reg_bit {
            bins rise = (0 => 1);
            bins fall = (1 => 0);
        }

    endgroup
    covergroup csrng__GENBITS_fld_cg with function sample(
    input bit [32-1:0] GENBITS
    );
        option.per_instance = 1;
        GENBITS_cp : coverpoint GENBITS;

    endgroup

    /*----------------------- CSRNG__INT_STATE_READ_ENABLE COVERGROUPS -----------------------*/
    covergroup csrng__INT_STATE_READ_ENABLE_bit_cg with function sample(input bit reg_bit);
        option.per_instance = 1;
        reg_bit_cp : coverpoint reg_bit {
            bins value[2] = {0,1};
        }
        reg_bit_edge_cp : coverpoint reg_bit {
            bins rise = (0 => 1);
            bins fall = (1 => 0);
        }

    endgroup
    covergroup csrng__INT_STATE_READ_ENABLE_fld_cg with function sample(
    input bit [3-1:0] INT_STATE_READ_ENABLE
    );
        option.per_instance = 1;
        INT_STATE_READ_ENABLE_cp : coverpoint INT_STATE_READ_ENABLE;

    endgroup

    /*----------------------- CSRNG__INT_STATE_READ_ENABLE_REGWEN COVERGROUPS -----------------------*/
    covergroup csrng__INT_STATE_READ_ENABLE_REGWEN_bit_cg with function sample(input bit reg_bit);
        option.per_instance = 1;
        reg_bit_cp : coverpoint reg_bit {
            bins value[2] = {0,1};
        }
        reg_bit_edge_cp : coverpoint reg_bit {
            bins rise = (0 => 1);
            bins fall = (1 => 0);
        }

    endgroup
    covergroup csrng__INT_STATE_READ_ENABLE_REGWEN_fld_cg with function sample(
    input bit [1-1:0] INT_STATE_READ_ENABLE_REGWEN
    );
        option.per_instance = 1;
        INT_STATE_READ_ENABLE_REGWEN_cp : coverpoint INT_STATE_READ_ENABLE_REGWEN;

    endgroup

    /*----------------------- CSRNG__INT_STATE_NUM COVERGROUPS -----------------------*/
    covergroup csrng__INT_STATE_NUM_bit_cg with function sample(input bit reg_bit);
        option.per_instance = 1;
        reg_bit_cp : coverpoint reg_bit {
            bins value[2] = {0,1};
        }
        reg_bit_edge_cp : coverpoint reg_bit {
            bins rise = (0 => 1);
            bins fall = (1 => 0);
        }

    endgroup
    covergroup csrng__INT_STATE_NUM_fld_cg with function sample(
    input bit [4-1:0] INT_STATE_NUM
    );
        option.per_instance = 1;
        INT_STATE_NUM_cp : coverpoint INT_STATE_NUM;

    endgroup

    /*----------------------- CSRNG__INT_STATE_VAL COVERGROUPS -----------------------*/
    covergroup csrng__INT_STATE_VAL_bit_cg with function sample(input bit reg_bit);
        option.per_instance = 1;
        reg_bit_cp : coverpoint reg_bit {
            bins value[2] = {0,1};
        }
        reg_bit_edge_cp : coverpoint reg_bit {
            bins rise = (0 => 1);
            bins fall = (1 => 0);
        }

    endgroup
    covergroup csrng__INT_STATE_VAL_fld_cg with function sample(
    input bit [32-1:0] INT_STATE_VAL
    );
        option.per_instance = 1;
        INT_STATE_VAL_cp : coverpoint INT_STATE_VAL;

    endgroup

    /*----------------------- CSRNG__FIPS_FORCE COVERGROUPS -----------------------*/
    covergroup csrng__FIPS_FORCE_bit_cg with function sample(input bit reg_bit);
        option.per_instance = 1;
        reg_bit_cp : coverpoint reg_bit {
            bins value[2] = {0,1};
        }
        reg_bit_edge_cp : coverpoint reg_bit {
            bins rise = (0 => 1);
            bins fall = (1 => 0);
        }

    endgroup
    covergroup csrng__FIPS_FORCE_fld_cg with function sample(
    input bit [3-1:0] FIPS_FORCE
    );
        option.per_instance = 1;
        FIPS_FORCE_cp : coverpoint FIPS_FORCE;

    endgroup

    /*----------------------- CSRNG__HW_EXC_STS COVERGROUPS -----------------------*/
    covergroup csrng__HW_EXC_STS_bit_cg with function sample(input bit reg_bit);
        option.per_instance = 1;
        reg_bit_cp : coverpoint reg_bit {
            bins value[2] = {0,1};
        }
        reg_bit_edge_cp : coverpoint reg_bit {
            bins rise = (0 => 1);
            bins fall = (1 => 0);
        }

    endgroup
    covergroup csrng__HW_EXC_STS_fld_cg with function sample(
    input bit [16-1:0] HW_EXC_STS
    );
        option.per_instance = 1;
        HW_EXC_STS_cp : coverpoint HW_EXC_STS;

    endgroup

    /*----------------------- CSRNG__RECOV_ALERT_STS COVERGROUPS -----------------------*/
    covergroup csrng__RECOV_ALERT_STS_bit_cg with function sample(input bit reg_bit);
        option.per_instance = 1;
        reg_bit_cp : coverpoint reg_bit {
            bins value[2] = {0,1};
        }
        reg_bit_edge_cp : coverpoint reg_bit {
            bins rise = (0 => 1);
            bins fall = (1 => 0);
        }

    endgroup
    covergroup csrng__RECOV_ALERT_STS_fld_cg with function sample(
    input bit [1-1:0] ENABLE_FIELD_ALERT,
    input bit [1-1:0] SW_APP_ENABLE_FIELD_ALERT,
    input bit [1-1:0] READ_INT_STATE_FIELD_ALERT,
    input bit [1-1:0] FIPS_FORCE_ENABLE_FIELD_ALERT,
    input bit [1-1:0] ACMD_FLAG0_FIELD_ALERT,
    input bit [1-1:0] CS_BUS_CMP_ALERT,
    input bit [1-1:0] CMD_STAGE_INVALID_ACMD_ALERT,
    input bit [1-1:0] CMD_STAGE_INVALID_CMD_SEQ_ALERT,
    input bit [1-1:0] CMD_STAGE_RESEED_CNT_ALERT
    );
        option.per_instance = 1;
        ENABLE_FIELD_ALERT_cp : coverpoint ENABLE_FIELD_ALERT;
        SW_APP_ENABLE_FIELD_ALERT_cp : coverpoint SW_APP_ENABLE_FIELD_ALERT;
        READ_INT_STATE_FIELD_ALERT_cp : coverpoint READ_INT_STATE_FIELD_ALERT;
        FIPS_FORCE_ENABLE_FIELD_ALERT_cp : coverpoint FIPS_FORCE_ENABLE_FIELD_ALERT;
        ACMD_FLAG0_FIELD_ALERT_cp : coverpoint ACMD_FLAG0_FIELD_ALERT;
        CS_BUS_CMP_ALERT_cp : coverpoint CS_BUS_CMP_ALERT;
        CMD_STAGE_INVALID_ACMD_ALERT_cp : coverpoint CMD_STAGE_INVALID_ACMD_ALERT;
        CMD_STAGE_INVALID_CMD_SEQ_ALERT_cp : coverpoint CMD_STAGE_INVALID_CMD_SEQ_ALERT;
        CMD_STAGE_RESEED_CNT_ALERT_cp : coverpoint CMD_STAGE_RESEED_CNT_ALERT;

    endgroup

    /*----------------------- CSRNG__ERR_CODE COVERGROUPS -----------------------*/
    covergroup csrng__ERR_CODE_bit_cg with function sample(input bit reg_bit);
        option.per_instance = 1;
        reg_bit_cp : coverpoint reg_bit {
            bins value[2] = {0,1};
        }
        reg_bit_edge_cp : coverpoint reg_bit {
            bins rise = (0 => 1);
            bins fall = (1 => 0);
        }

    endgroup
    covergroup csrng__ERR_CODE_fld_cg with function sample(
    input bit [1-1:0] SFIFO_CMD_ERR,
    input bit [1-1:0] SFIFO_GENBITS_ERR,
    input bit [1-1:0] SFIFO_CMDREQ_ERR,
    input bit [1-1:0] SFIFO_RCSTAGE_ERR,
    input bit [1-1:0] SFIFO_KEYVRC_ERR,
    input bit [1-1:0] SFIFO_UPDREQ_ERR,
    input bit [1-1:0] SFIFO_BENCREQ_ERR,
    input bit [1-1:0] SFIFO_BENCACK_ERR,
    input bit [1-1:0] SFIFO_PDATA_ERR,
    input bit [1-1:0] SFIFO_FINAL_ERR,
    input bit [1-1:0] SFIFO_GBENCACK_ERR,
    input bit [1-1:0] SFIFO_GRCSTAGE_ERR,
    input bit [1-1:0] SFIFO_GGENREQ_ERR,
    input bit [1-1:0] SFIFO_GADSTAGE_ERR,
    input bit [1-1:0] SFIFO_GGENBITS_ERR,
    input bit [1-1:0] SFIFO_BLKENC_ERR,
    input bit [1-1:0] CMD_STAGE_SM_ERR,
    input bit [1-1:0] MAIN_SM_ERR,
    input bit [1-1:0] DRBG_GEN_SM_ERR,
    input bit [1-1:0] DRBG_UPDBE_SM_ERR,
    input bit [1-1:0] DRBG_UPDOB_SM_ERR,
    input bit [1-1:0] AES_CIPHER_SM_ERR,
    input bit [1-1:0] CMD_GEN_CNT_ERR,
    input bit [1-1:0] FIFO_WRITE_ERR,
    input bit [1-1:0] FIFO_READ_ERR,
    input bit [1-1:0] FIFO_STATE_ERR
    );
        option.per_instance = 1;
        SFIFO_CMD_ERR_cp : coverpoint SFIFO_CMD_ERR;
        SFIFO_GENBITS_ERR_cp : coverpoint SFIFO_GENBITS_ERR;
        SFIFO_CMDREQ_ERR_cp : coverpoint SFIFO_CMDREQ_ERR;
        SFIFO_RCSTAGE_ERR_cp : coverpoint SFIFO_RCSTAGE_ERR;
        SFIFO_KEYVRC_ERR_cp : coverpoint SFIFO_KEYVRC_ERR;
        SFIFO_UPDREQ_ERR_cp : coverpoint SFIFO_UPDREQ_ERR;
        SFIFO_BENCREQ_ERR_cp : coverpoint SFIFO_BENCREQ_ERR;
        SFIFO_BENCACK_ERR_cp : coverpoint SFIFO_BENCACK_ERR;
        SFIFO_PDATA_ERR_cp : coverpoint SFIFO_PDATA_ERR;
        SFIFO_FINAL_ERR_cp : coverpoint SFIFO_FINAL_ERR;
        SFIFO_GBENCACK_ERR_cp : coverpoint SFIFO_GBENCACK_ERR;
        SFIFO_GRCSTAGE_ERR_cp : coverpoint SFIFO_GRCSTAGE_ERR;
        SFIFO_GGENREQ_ERR_cp : coverpoint SFIFO_GGENREQ_ERR;
        SFIFO_GADSTAGE_ERR_cp : coverpoint SFIFO_GADSTAGE_ERR;
        SFIFO_GGENBITS_ERR_cp : coverpoint SFIFO_GGENBITS_ERR;
        SFIFO_BLKENC_ERR_cp : coverpoint SFIFO_BLKENC_ERR;
        CMD_STAGE_SM_ERR_cp : coverpoint CMD_STAGE_SM_ERR;
        MAIN_SM_ERR_cp : coverpoint MAIN_SM_ERR;
        DRBG_GEN_SM_ERR_cp : coverpoint DRBG_GEN_SM_ERR;
        DRBG_UPDBE_SM_ERR_cp : coverpoint DRBG_UPDBE_SM_ERR;
        DRBG_UPDOB_SM_ERR_cp : coverpoint DRBG_UPDOB_SM_ERR;
        AES_CIPHER_SM_ERR_cp : coverpoint AES_CIPHER_SM_ERR;
        CMD_GEN_CNT_ERR_cp : coverpoint CMD_GEN_CNT_ERR;
        FIFO_WRITE_ERR_cp : coverpoint FIFO_WRITE_ERR;
        FIFO_READ_ERR_cp : coverpoint FIFO_READ_ERR;
        FIFO_STATE_ERR_cp : coverpoint FIFO_STATE_ERR;

    endgroup

    /*----------------------- CSRNG__ERR_CODE_TEST COVERGROUPS -----------------------*/
    covergroup csrng__ERR_CODE_TEST_bit_cg with function sample(input bit reg_bit);
        option.per_instance = 1;
        reg_bit_cp : coverpoint reg_bit {
            bins value[2] = {0,1};
        }
        reg_bit_edge_cp : coverpoint reg_bit {
            bins rise = (0 => 1);
            bins fall = (1 => 0);
        }

    endgroup
    covergroup csrng__ERR_CODE_TEST_fld_cg with function sample(
    input bit [5-1:0] ERR_CODE_TEST
    );
        option.per_instance = 1;
        ERR_CODE_TEST_cp : coverpoint ERR_CODE_TEST;

    endgroup

    /*----------------------- CSRNG__MAIN_SM_STATE COVERGROUPS -----------------------*/
    covergroup csrng__MAIN_SM_STATE_bit_cg with function sample(input bit reg_bit);
        option.per_instance = 1;
        reg_bit_cp : coverpoint reg_bit {
            bins value[2] = {0,1};
        }
        reg_bit_edge_cp : coverpoint reg_bit {
            bins rise = (0 => 1);
            bins fall = (1 => 0);
        }

    endgroup
    covergroup csrng__MAIN_SM_STATE_fld_cg with function sample(
    input bit [8-1:0] MAIN_SM_STATE
    );
        option.per_instance = 1;
        MAIN_SM_STATE_cp : coverpoint MAIN_SM_STATE;

    endgroup

`endif