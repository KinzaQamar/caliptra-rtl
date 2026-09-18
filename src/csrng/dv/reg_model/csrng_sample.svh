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

`ifndef CSRNG_SAMPLE
    `define CSRNG_SAMPLE
    
    /*----------------------- CSRNG__INTERRUPT_STATE SAMPLE FUNCTIONS -----------------------*/
    function void csrng__INTERRUPT_STATE::sample(uvm_reg_data_t  data,
                                                   uvm_reg_data_t  byte_en,
                                                   bit             is_read,
                                                   uvm_reg_map     map);
        m_current = get();
        m_data    = data;
        m_is_read = is_read;
        if (get_coverage(UVM_CVR_REG_BITS)) begin
            foreach(CS_CMD_REQ_DONE_bit_cg[bt]) this.CS_CMD_REQ_DONE_bit_cg[bt].sample(data[0 + bt]);
            foreach(CS_ENTROPY_REQ_bit_cg[bt]) this.CS_ENTROPY_REQ_bit_cg[bt].sample(data[1 + bt]);
            foreach(CS_HW_INST_EXC_bit_cg[bt]) this.CS_HW_INST_EXC_bit_cg[bt].sample(data[2 + bt]);
            foreach(CS_FATAL_ERR_bit_cg[bt]) this.CS_FATAL_ERR_bit_cg[bt].sample(data[3 + bt]);
        end
        if (get_coverage(UVM_CVR_FIELD_VALS)) begin
            this.fld_cg.sample( data[0:0]/*CS_CMD_REQ_DONE*/  ,  data[1:1]/*CS_ENTROPY_REQ*/  ,  data[2:2]/*CS_HW_INST_EXC*/  ,  data[3:3]/*CS_FATAL_ERR*/   );
        end
    endfunction

    function void csrng__INTERRUPT_STATE::sample_values();
        if (get_coverage(UVM_CVR_REG_BITS)) begin
            foreach(CS_CMD_REQ_DONE_bit_cg[bt]) this.CS_CMD_REQ_DONE_bit_cg[bt].sample(CS_CMD_REQ_DONE.get_mirrored_value() >> bt);
            foreach(CS_ENTROPY_REQ_bit_cg[bt]) this.CS_ENTROPY_REQ_bit_cg[bt].sample(CS_ENTROPY_REQ.get_mirrored_value() >> bt);
            foreach(CS_HW_INST_EXC_bit_cg[bt]) this.CS_HW_INST_EXC_bit_cg[bt].sample(CS_HW_INST_EXC.get_mirrored_value() >> bt);
            foreach(CS_FATAL_ERR_bit_cg[bt]) this.CS_FATAL_ERR_bit_cg[bt].sample(CS_FATAL_ERR.get_mirrored_value() >> bt);
        end
        if (get_coverage(UVM_CVR_FIELD_VALS)) begin
            this.fld_cg.sample( CS_CMD_REQ_DONE.get_mirrored_value()  ,  CS_ENTROPY_REQ.get_mirrored_value()  ,  CS_HW_INST_EXC.get_mirrored_value()  ,  CS_FATAL_ERR.get_mirrored_value()   );
        end
    endfunction

    /*----------------------- CSRNG__INTERRUPT_ENABLE SAMPLE FUNCTIONS -----------------------*/
    function void csrng__INTERRUPT_ENABLE::sample(uvm_reg_data_t  data,
                                                   uvm_reg_data_t  byte_en,
                                                   bit             is_read,
                                                   uvm_reg_map     map);
        m_current = get();
        m_data    = data;
        m_is_read = is_read;
        if (get_coverage(UVM_CVR_REG_BITS)) begin
            foreach(CS_CMD_REQ_DONE_bit_cg[bt]) this.CS_CMD_REQ_DONE_bit_cg[bt].sample(data[0 + bt]);
            foreach(CS_ENTROPY_REQ_bit_cg[bt]) this.CS_ENTROPY_REQ_bit_cg[bt].sample(data[1 + bt]);
            foreach(CS_HW_INST_EXC_bit_cg[bt]) this.CS_HW_INST_EXC_bit_cg[bt].sample(data[2 + bt]);
            foreach(CS_FATAL_ERR_bit_cg[bt]) this.CS_FATAL_ERR_bit_cg[bt].sample(data[3 + bt]);
        end
        if (get_coverage(UVM_CVR_FIELD_VALS)) begin
            this.fld_cg.sample( data[0:0]/*CS_CMD_REQ_DONE*/  ,  data[1:1]/*CS_ENTROPY_REQ*/  ,  data[2:2]/*CS_HW_INST_EXC*/  ,  data[3:3]/*CS_FATAL_ERR*/   );
        end
    endfunction

    function void csrng__INTERRUPT_ENABLE::sample_values();
        if (get_coverage(UVM_CVR_REG_BITS)) begin
            foreach(CS_CMD_REQ_DONE_bit_cg[bt]) this.CS_CMD_REQ_DONE_bit_cg[bt].sample(CS_CMD_REQ_DONE.get_mirrored_value() >> bt);
            foreach(CS_ENTROPY_REQ_bit_cg[bt]) this.CS_ENTROPY_REQ_bit_cg[bt].sample(CS_ENTROPY_REQ.get_mirrored_value() >> bt);
            foreach(CS_HW_INST_EXC_bit_cg[bt]) this.CS_HW_INST_EXC_bit_cg[bt].sample(CS_HW_INST_EXC.get_mirrored_value() >> bt);
            foreach(CS_FATAL_ERR_bit_cg[bt]) this.CS_FATAL_ERR_bit_cg[bt].sample(CS_FATAL_ERR.get_mirrored_value() >> bt);
        end
        if (get_coverage(UVM_CVR_FIELD_VALS)) begin
            this.fld_cg.sample( CS_CMD_REQ_DONE.get_mirrored_value()  ,  CS_ENTROPY_REQ.get_mirrored_value()  ,  CS_HW_INST_EXC.get_mirrored_value()  ,  CS_FATAL_ERR.get_mirrored_value()   );
        end
    endfunction

    /*----------------------- CSRNG__INTERRUPT_TEST SAMPLE FUNCTIONS -----------------------*/
    function void csrng__INTERRUPT_TEST::sample(uvm_reg_data_t  data,
                                                   uvm_reg_data_t  byte_en,
                                                   bit             is_read,
                                                   uvm_reg_map     map);
        m_current = get();
        m_data    = data;
        m_is_read = is_read;
        if (get_coverage(UVM_CVR_REG_BITS)) begin
            foreach(CS_CMD_REQ_DONE_bit_cg[bt]) this.CS_CMD_REQ_DONE_bit_cg[bt].sample(data[0 + bt]);
            foreach(CS_ENTROPY_REQ_bit_cg[bt]) this.CS_ENTROPY_REQ_bit_cg[bt].sample(data[1 + bt]);
            foreach(CS_HW_INST_EXC_bit_cg[bt]) this.CS_HW_INST_EXC_bit_cg[bt].sample(data[2 + bt]);
            foreach(CS_FATAL_ERR_bit_cg[bt]) this.CS_FATAL_ERR_bit_cg[bt].sample(data[3 + bt]);
        end
        if (get_coverage(UVM_CVR_FIELD_VALS)) begin
            this.fld_cg.sample( data[0:0]/*CS_CMD_REQ_DONE*/  ,  data[1:1]/*CS_ENTROPY_REQ*/  ,  data[2:2]/*CS_HW_INST_EXC*/  ,  data[3:3]/*CS_FATAL_ERR*/   );
        end
    endfunction

    function void csrng__INTERRUPT_TEST::sample_values();
        if (get_coverage(UVM_CVR_REG_BITS)) begin
            foreach(CS_CMD_REQ_DONE_bit_cg[bt]) this.CS_CMD_REQ_DONE_bit_cg[bt].sample(CS_CMD_REQ_DONE.get_mirrored_value() >> bt);
            foreach(CS_ENTROPY_REQ_bit_cg[bt]) this.CS_ENTROPY_REQ_bit_cg[bt].sample(CS_ENTROPY_REQ.get_mirrored_value() >> bt);
            foreach(CS_HW_INST_EXC_bit_cg[bt]) this.CS_HW_INST_EXC_bit_cg[bt].sample(CS_HW_INST_EXC.get_mirrored_value() >> bt);
            foreach(CS_FATAL_ERR_bit_cg[bt]) this.CS_FATAL_ERR_bit_cg[bt].sample(CS_FATAL_ERR.get_mirrored_value() >> bt);
        end
        if (get_coverage(UVM_CVR_FIELD_VALS)) begin
            this.fld_cg.sample( CS_CMD_REQ_DONE.get_mirrored_value()  ,  CS_ENTROPY_REQ.get_mirrored_value()  ,  CS_HW_INST_EXC.get_mirrored_value()  ,  CS_FATAL_ERR.get_mirrored_value()   );
        end
    endfunction

    /*----------------------- CSRNG__ALERT_TEST SAMPLE FUNCTIONS -----------------------*/
    function void csrng__ALERT_TEST::sample(uvm_reg_data_t  data,
                                                   uvm_reg_data_t  byte_en,
                                                   bit             is_read,
                                                   uvm_reg_map     map);
        m_current = get();
        m_data    = data;
        m_is_read = is_read;
        if (get_coverage(UVM_CVR_REG_BITS)) begin
            foreach(RECOV_ALERT_bit_cg[bt]) this.RECOV_ALERT_bit_cg[bt].sample(data[0 + bt]);
            foreach(FATAL_ALERT_bit_cg[bt]) this.FATAL_ALERT_bit_cg[bt].sample(data[1 + bt]);
        end
        if (get_coverage(UVM_CVR_FIELD_VALS)) begin
            this.fld_cg.sample( data[0:0]/*RECOV_ALERT*/  ,  data[1:1]/*FATAL_ALERT*/   );
        end
    endfunction

    function void csrng__ALERT_TEST::sample_values();
        if (get_coverage(UVM_CVR_REG_BITS)) begin
            foreach(RECOV_ALERT_bit_cg[bt]) this.RECOV_ALERT_bit_cg[bt].sample(RECOV_ALERT.get_mirrored_value() >> bt);
            foreach(FATAL_ALERT_bit_cg[bt]) this.FATAL_ALERT_bit_cg[bt].sample(FATAL_ALERT.get_mirrored_value() >> bt);
        end
        if (get_coverage(UVM_CVR_FIELD_VALS)) begin
            this.fld_cg.sample( RECOV_ALERT.get_mirrored_value()  ,  FATAL_ALERT.get_mirrored_value()   );
        end
    endfunction

    /*----------------------- CSRNG__REGWEN SAMPLE FUNCTIONS -----------------------*/
    function void csrng__REGWEN::sample(uvm_reg_data_t  data,
                                                   uvm_reg_data_t  byte_en,
                                                   bit             is_read,
                                                   uvm_reg_map     map);
        m_current = get();
        m_data    = data;
        m_is_read = is_read;
        if (get_coverage(UVM_CVR_REG_BITS)) begin
            foreach(REGWEN_bit_cg[bt]) this.REGWEN_bit_cg[bt].sample(data[0 + bt]);
        end
        if (get_coverage(UVM_CVR_FIELD_VALS)) begin
            this.fld_cg.sample( data[0:0]/*REGWEN*/   );
        end
    endfunction

    function void csrng__REGWEN::sample_values();
        if (get_coverage(UVM_CVR_REG_BITS)) begin
            foreach(REGWEN_bit_cg[bt]) this.REGWEN_bit_cg[bt].sample(REGWEN.get_mirrored_value() >> bt);
        end
        if (get_coverage(UVM_CVR_FIELD_VALS)) begin
            this.fld_cg.sample( REGWEN.get_mirrored_value()   );
        end
    endfunction

    /*----------------------- CSRNG__CTRL SAMPLE FUNCTIONS -----------------------*/
    function void csrng__CTRL::sample(uvm_reg_data_t  data,
                                                   uvm_reg_data_t  byte_en,
                                                   bit             is_read,
                                                   uvm_reg_map     map);
        m_current = get();
        m_data    = data;
        m_is_read = is_read;
        if (get_coverage(UVM_CVR_REG_BITS)) begin
            foreach(ENABLE_bit_cg[bt]) this.ENABLE_bit_cg[bt].sample(data[0 + bt]);
            foreach(SW_APP_ENABLE_bit_cg[bt]) this.SW_APP_ENABLE_bit_cg[bt].sample(data[4 + bt]);
            foreach(READ_INT_STATE_bit_cg[bt]) this.READ_INT_STATE_bit_cg[bt].sample(data[8 + bt]);
            foreach(FIPS_FORCE_ENABLE_bit_cg[bt]) this.FIPS_FORCE_ENABLE_bit_cg[bt].sample(data[12 + bt]);
        end
        if (get_coverage(UVM_CVR_FIELD_VALS)) begin
            this.fld_cg.sample( data[3:0]/*ENABLE*/  ,  data[7:4]/*SW_APP_ENABLE*/  ,  data[11:8]/*READ_INT_STATE*/  ,  data[15:12]/*FIPS_FORCE_ENABLE*/   );
        end
    endfunction

    function void csrng__CTRL::sample_values();
        if (get_coverage(UVM_CVR_REG_BITS)) begin
            foreach(ENABLE_bit_cg[bt]) this.ENABLE_bit_cg[bt].sample(ENABLE.get_mirrored_value() >> bt);
            foreach(SW_APP_ENABLE_bit_cg[bt]) this.SW_APP_ENABLE_bit_cg[bt].sample(SW_APP_ENABLE.get_mirrored_value() >> bt);
            foreach(READ_INT_STATE_bit_cg[bt]) this.READ_INT_STATE_bit_cg[bt].sample(READ_INT_STATE.get_mirrored_value() >> bt);
            foreach(FIPS_FORCE_ENABLE_bit_cg[bt]) this.FIPS_FORCE_ENABLE_bit_cg[bt].sample(FIPS_FORCE_ENABLE.get_mirrored_value() >> bt);
        end
        if (get_coverage(UVM_CVR_FIELD_VALS)) begin
            this.fld_cg.sample( ENABLE.get_mirrored_value()  ,  SW_APP_ENABLE.get_mirrored_value()  ,  READ_INT_STATE.get_mirrored_value()  ,  FIPS_FORCE_ENABLE.get_mirrored_value()   );
        end
    endfunction

    /*----------------------- CSRNG__CMD_REQ SAMPLE FUNCTIONS -----------------------*/
    function void csrng__CMD_REQ::sample(uvm_reg_data_t  data,
                                                   uvm_reg_data_t  byte_en,
                                                   bit             is_read,
                                                   uvm_reg_map     map);
        m_current = get();
        m_data    = data;
        m_is_read = is_read;
        if (get_coverage(UVM_CVR_REG_BITS)) begin
            foreach(acmd_bit_cg[bt]) this.acmd_bit_cg[bt].sample(data[0 + bt]);
            foreach(clen_bit_cg[bt]) this.clen_bit_cg[bt].sample(data[4 + bt]);
            foreach(flag0_bit_cg[bt]) this.flag0_bit_cg[bt].sample(data[8 + bt]);
            foreach(glen_bit_cg[bt]) this.glen_bit_cg[bt].sample(data[12 + bt]);
        end
        if (get_coverage(UVM_CVR_FIELD_VALS)) begin
            this.fld_cg.sample( data[3:0]/*acmd*/  ,  data[7:4]/*clen*/  ,  data[11:8]/*flag0*/  ,  data[24:12]/*glen*/   );
        end
    endfunction

    function void csrng__CMD_REQ::sample_values();
        if (get_coverage(UVM_CVR_REG_BITS)) begin
            foreach(acmd_bit_cg[bt]) this.acmd_bit_cg[bt].sample(acmd.get_mirrored_value() >> bt);
            foreach(clen_bit_cg[bt]) this.clen_bit_cg[bt].sample(clen.get_mirrored_value() >> bt);
            foreach(flag0_bit_cg[bt]) this.flag0_bit_cg[bt].sample(flag0.get_mirrored_value() >> bt);
            foreach(glen_bit_cg[bt]) this.glen_bit_cg[bt].sample(glen.get_mirrored_value() >> bt);
        end
        if (get_coverage(UVM_CVR_FIELD_VALS)) begin
            this.fld_cg.sample( acmd.get_mirrored_value()  ,  clen.get_mirrored_value()  ,  flag0.get_mirrored_value()  ,  glen.get_mirrored_value()   );
        end
    endfunction

    /*----------------------- CSRNG__RESEED_INTERVAL SAMPLE FUNCTIONS -----------------------*/
    function void csrng__RESEED_INTERVAL::sample(uvm_reg_data_t  data,
                                                   uvm_reg_data_t  byte_en,
                                                   bit             is_read,
                                                   uvm_reg_map     map);
        m_current = get();
        m_data    = data;
        m_is_read = is_read;
        if (get_coverage(UVM_CVR_REG_BITS)) begin
            foreach(RESEED_INTERVAL_bit_cg[bt]) this.RESEED_INTERVAL_bit_cg[bt].sample(data[0 + bt]);
        end
        if (get_coverage(UVM_CVR_FIELD_VALS)) begin
            this.fld_cg.sample( data[31:0]/*RESEED_INTERVAL*/   );
        end
    endfunction

    function void csrng__RESEED_INTERVAL::sample_values();
        if (get_coverage(UVM_CVR_REG_BITS)) begin
            foreach(RESEED_INTERVAL_bit_cg[bt]) this.RESEED_INTERVAL_bit_cg[bt].sample(RESEED_INTERVAL.get_mirrored_value() >> bt);
        end
        if (get_coverage(UVM_CVR_FIELD_VALS)) begin
            this.fld_cg.sample( RESEED_INTERVAL.get_mirrored_value()   );
        end
    endfunction

    /*----------------------- CSRNG__RESEED_COUNTER SAMPLE FUNCTIONS -----------------------*/
    function void csrng__RESEED_COUNTER::sample(uvm_reg_data_t  data,
                                                   uvm_reg_data_t  byte_en,
                                                   bit             is_read,
                                                   uvm_reg_map     map);
        m_current = get();
        m_data    = data;
        m_is_read = is_read;
        if (get_coverage(UVM_CVR_REG_BITS)) begin
            foreach(RESEED_COUNTER_bit_cg[bt]) this.RESEED_COUNTER_bit_cg[bt].sample(data[0 + bt]);
        end
        if (get_coverage(UVM_CVR_FIELD_VALS)) begin
            this.fld_cg.sample( data[31:0]/*RESEED_COUNTER*/   );
        end
    endfunction

    function void csrng__RESEED_COUNTER::sample_values();
        if (get_coverage(UVM_CVR_REG_BITS)) begin
            foreach(RESEED_COUNTER_bit_cg[bt]) this.RESEED_COUNTER_bit_cg[bt].sample(RESEED_COUNTER.get_mirrored_value() >> bt);
        end
        if (get_coverage(UVM_CVR_FIELD_VALS)) begin
            this.fld_cg.sample( RESEED_COUNTER.get_mirrored_value()   );
        end
    endfunction

    /*----------------------- CSRNG__SW_CMD_STS SAMPLE FUNCTIONS -----------------------*/
    function void csrng__SW_CMD_STS::sample(uvm_reg_data_t  data,
                                                   uvm_reg_data_t  byte_en,
                                                   bit             is_read,
                                                   uvm_reg_map     map);
        m_current = get();
        m_data    = data;
        m_is_read = is_read;
        if (get_coverage(UVM_CVR_REG_BITS)) begin
            foreach(CMD_RDY_bit_cg[bt]) this.CMD_RDY_bit_cg[bt].sample(data[1 + bt]);
            foreach(CMD_ACK_bit_cg[bt]) this.CMD_ACK_bit_cg[bt].sample(data[2 + bt]);
            foreach(CMD_STS_bit_cg[bt]) this.CMD_STS_bit_cg[bt].sample(data[3 + bt]);
        end
        if (get_coverage(UVM_CVR_FIELD_VALS)) begin
            this.fld_cg.sample( data[1:1]/*CMD_RDY*/  ,  data[2:2]/*CMD_ACK*/  ,  data[5:3]/*CMD_STS*/   );
        end
    endfunction

    function void csrng__SW_CMD_STS::sample_values();
        if (get_coverage(UVM_CVR_REG_BITS)) begin
            foreach(CMD_RDY_bit_cg[bt]) this.CMD_RDY_bit_cg[bt].sample(CMD_RDY.get_mirrored_value() >> bt);
            foreach(CMD_ACK_bit_cg[bt]) this.CMD_ACK_bit_cg[bt].sample(CMD_ACK.get_mirrored_value() >> bt);
            foreach(CMD_STS_bit_cg[bt]) this.CMD_STS_bit_cg[bt].sample(CMD_STS.get_mirrored_value() >> bt);
        end
        if (get_coverage(UVM_CVR_FIELD_VALS)) begin
            this.fld_cg.sample( CMD_RDY.get_mirrored_value()  ,  CMD_ACK.get_mirrored_value()  ,  CMD_STS.get_mirrored_value()   );
        end
    endfunction

    /*----------------------- CSRNG__GENBITS_VLD SAMPLE FUNCTIONS -----------------------*/
    function void csrng__GENBITS_VLD::sample(uvm_reg_data_t  data,
                                                   uvm_reg_data_t  byte_en,
                                                   bit             is_read,
                                                   uvm_reg_map     map);
        m_current = get();
        m_data    = data;
        m_is_read = is_read;
        if (get_coverage(UVM_CVR_REG_BITS)) begin
            foreach(GENBITS_VLD_bit_cg[bt]) this.GENBITS_VLD_bit_cg[bt].sample(data[0 + bt]);
            foreach(GENBITS_FIPS_bit_cg[bt]) this.GENBITS_FIPS_bit_cg[bt].sample(data[1 + bt]);
        end
        if (get_coverage(UVM_CVR_FIELD_VALS)) begin
            this.fld_cg.sample( data[0:0]/*GENBITS_VLD*/  ,  data[1:1]/*GENBITS_FIPS*/   );
        end
    endfunction

    function void csrng__GENBITS_VLD::sample_values();
        if (get_coverage(UVM_CVR_REG_BITS)) begin
            foreach(GENBITS_VLD_bit_cg[bt]) this.GENBITS_VLD_bit_cg[bt].sample(GENBITS_VLD.get_mirrored_value() >> bt);
            foreach(GENBITS_FIPS_bit_cg[bt]) this.GENBITS_FIPS_bit_cg[bt].sample(GENBITS_FIPS.get_mirrored_value() >> bt);
        end
        if (get_coverage(UVM_CVR_FIELD_VALS)) begin
            this.fld_cg.sample( GENBITS_VLD.get_mirrored_value()  ,  GENBITS_FIPS.get_mirrored_value()   );
        end
    endfunction

    /*----------------------- CSRNG__GENBITS SAMPLE FUNCTIONS -----------------------*/
    function void csrng__GENBITS::sample(uvm_reg_data_t  data,
                                                   uvm_reg_data_t  byte_en,
                                                   bit             is_read,
                                                   uvm_reg_map     map);
        m_current = get();
        m_data    = data;
        m_is_read = is_read;
        if (get_coverage(UVM_CVR_REG_BITS)) begin
            foreach(GENBITS_bit_cg[bt]) this.GENBITS_bit_cg[bt].sample(data[0 + bt]);
        end
        if (get_coverage(UVM_CVR_FIELD_VALS)) begin
            this.fld_cg.sample( data[31:0]/*GENBITS*/   );
        end
    endfunction

    function void csrng__GENBITS::sample_values();
        if (get_coverage(UVM_CVR_REG_BITS)) begin
            foreach(GENBITS_bit_cg[bt]) this.GENBITS_bit_cg[bt].sample(GENBITS.get_mirrored_value() >> bt);
        end
        if (get_coverage(UVM_CVR_FIELD_VALS)) begin
            this.fld_cg.sample( GENBITS.get_mirrored_value()   );
        end
    endfunction

    /*----------------------- CSRNG__INT_STATE_READ_ENABLE SAMPLE FUNCTIONS -----------------------*/
    function void csrng__INT_STATE_READ_ENABLE::sample(uvm_reg_data_t  data,
                                                   uvm_reg_data_t  byte_en,
                                                   bit             is_read,
                                                   uvm_reg_map     map);
        m_current = get();
        m_data    = data;
        m_is_read = is_read;
        if (get_coverage(UVM_CVR_REG_BITS)) begin
            foreach(INT_STATE_READ_ENABLE_bit_cg[bt]) this.INT_STATE_READ_ENABLE_bit_cg[bt].sample(data[0 + bt]);
        end
        if (get_coverage(UVM_CVR_FIELD_VALS)) begin
            this.fld_cg.sample( data[2:0]/*INT_STATE_READ_ENABLE*/   );
        end
    endfunction

    function void csrng__INT_STATE_READ_ENABLE::sample_values();
        if (get_coverage(UVM_CVR_REG_BITS)) begin
            foreach(INT_STATE_READ_ENABLE_bit_cg[bt]) this.INT_STATE_READ_ENABLE_bit_cg[bt].sample(INT_STATE_READ_ENABLE.get_mirrored_value() >> bt);
        end
        if (get_coverage(UVM_CVR_FIELD_VALS)) begin
            this.fld_cg.sample( INT_STATE_READ_ENABLE.get_mirrored_value()   );
        end
    endfunction

    /*----------------------- CSRNG__INT_STATE_READ_ENABLE_REGWEN SAMPLE FUNCTIONS -----------------------*/
    function void csrng__INT_STATE_READ_ENABLE_REGWEN::sample(uvm_reg_data_t  data,
                                                   uvm_reg_data_t  byte_en,
                                                   bit             is_read,
                                                   uvm_reg_map     map);
        m_current = get();
        m_data    = data;
        m_is_read = is_read;
        if (get_coverage(UVM_CVR_REG_BITS)) begin
            foreach(INT_STATE_READ_ENABLE_REGWEN_bit_cg[bt]) this.INT_STATE_READ_ENABLE_REGWEN_bit_cg[bt].sample(data[0 + bt]);
        end
        if (get_coverage(UVM_CVR_FIELD_VALS)) begin
            this.fld_cg.sample( data[0:0]/*INT_STATE_READ_ENABLE_REGWEN*/   );
        end
    endfunction

    function void csrng__INT_STATE_READ_ENABLE_REGWEN::sample_values();
        if (get_coverage(UVM_CVR_REG_BITS)) begin
            foreach(INT_STATE_READ_ENABLE_REGWEN_bit_cg[bt]) this.INT_STATE_READ_ENABLE_REGWEN_bit_cg[bt].sample(INT_STATE_READ_ENABLE_REGWEN.get_mirrored_value() >> bt);
        end
        if (get_coverage(UVM_CVR_FIELD_VALS)) begin
            this.fld_cg.sample( INT_STATE_READ_ENABLE_REGWEN.get_mirrored_value()   );
        end
    endfunction

    /*----------------------- CSRNG__INT_STATE_NUM SAMPLE FUNCTIONS -----------------------*/
    function void csrng__INT_STATE_NUM::sample(uvm_reg_data_t  data,
                                                   uvm_reg_data_t  byte_en,
                                                   bit             is_read,
                                                   uvm_reg_map     map);
        m_current = get();
        m_data    = data;
        m_is_read = is_read;
        if (get_coverage(UVM_CVR_REG_BITS)) begin
            foreach(INT_STATE_NUM_bit_cg[bt]) this.INT_STATE_NUM_bit_cg[bt].sample(data[0 + bt]);
        end
        if (get_coverage(UVM_CVR_FIELD_VALS)) begin
            this.fld_cg.sample( data[3:0]/*INT_STATE_NUM*/   );
        end
    endfunction

    function void csrng__INT_STATE_NUM::sample_values();
        if (get_coverage(UVM_CVR_REG_BITS)) begin
            foreach(INT_STATE_NUM_bit_cg[bt]) this.INT_STATE_NUM_bit_cg[bt].sample(INT_STATE_NUM.get_mirrored_value() >> bt);
        end
        if (get_coverage(UVM_CVR_FIELD_VALS)) begin
            this.fld_cg.sample( INT_STATE_NUM.get_mirrored_value()   );
        end
    endfunction

    /*----------------------- CSRNG__INT_STATE_VAL SAMPLE FUNCTIONS -----------------------*/
    function void csrng__INT_STATE_VAL::sample(uvm_reg_data_t  data,
                                                   uvm_reg_data_t  byte_en,
                                                   bit             is_read,
                                                   uvm_reg_map     map);
        m_current = get();
        m_data    = data;
        m_is_read = is_read;
        if (get_coverage(UVM_CVR_REG_BITS)) begin
            foreach(INT_STATE_VAL_bit_cg[bt]) this.INT_STATE_VAL_bit_cg[bt].sample(data[0 + bt]);
        end
        if (get_coverage(UVM_CVR_FIELD_VALS)) begin
            this.fld_cg.sample( data[31:0]/*INT_STATE_VAL*/   );
        end
    endfunction

    function void csrng__INT_STATE_VAL::sample_values();
        if (get_coverage(UVM_CVR_REG_BITS)) begin
            foreach(INT_STATE_VAL_bit_cg[bt]) this.INT_STATE_VAL_bit_cg[bt].sample(INT_STATE_VAL.get_mirrored_value() >> bt);
        end
        if (get_coverage(UVM_CVR_FIELD_VALS)) begin
            this.fld_cg.sample( INT_STATE_VAL.get_mirrored_value()   );
        end
    endfunction

    /*----------------------- CSRNG__FIPS_FORCE SAMPLE FUNCTIONS -----------------------*/
    function void csrng__FIPS_FORCE::sample(uvm_reg_data_t  data,
                                                   uvm_reg_data_t  byte_en,
                                                   bit             is_read,
                                                   uvm_reg_map     map);
        m_current = get();
        m_data    = data;
        m_is_read = is_read;
        if (get_coverage(UVM_CVR_REG_BITS)) begin
            foreach(FIPS_FORCE_bit_cg[bt]) this.FIPS_FORCE_bit_cg[bt].sample(data[0 + bt]);
        end
        if (get_coverage(UVM_CVR_FIELD_VALS)) begin
            this.fld_cg.sample( data[2:0]/*FIPS_FORCE*/   );
        end
    endfunction

    function void csrng__FIPS_FORCE::sample_values();
        if (get_coverage(UVM_CVR_REG_BITS)) begin
            foreach(FIPS_FORCE_bit_cg[bt]) this.FIPS_FORCE_bit_cg[bt].sample(FIPS_FORCE.get_mirrored_value() >> bt);
        end
        if (get_coverage(UVM_CVR_FIELD_VALS)) begin
            this.fld_cg.sample( FIPS_FORCE.get_mirrored_value()   );
        end
    endfunction

    /*----------------------- CSRNG__HW_EXC_STS SAMPLE FUNCTIONS -----------------------*/
    function void csrng__HW_EXC_STS::sample(uvm_reg_data_t  data,
                                                   uvm_reg_data_t  byte_en,
                                                   bit             is_read,
                                                   uvm_reg_map     map);
        m_current = get();
        m_data    = data;
        m_is_read = is_read;
        if (get_coverage(UVM_CVR_REG_BITS)) begin
            foreach(HW_EXC_STS_bit_cg[bt]) this.HW_EXC_STS_bit_cg[bt].sample(data[0 + bt]);
        end
        if (get_coverage(UVM_CVR_FIELD_VALS)) begin
            this.fld_cg.sample( data[15:0]/*HW_EXC_STS*/   );
        end
    endfunction

    function void csrng__HW_EXC_STS::sample_values();
        if (get_coverage(UVM_CVR_REG_BITS)) begin
            foreach(HW_EXC_STS_bit_cg[bt]) this.HW_EXC_STS_bit_cg[bt].sample(HW_EXC_STS.get_mirrored_value() >> bt);
        end
        if (get_coverage(UVM_CVR_FIELD_VALS)) begin
            this.fld_cg.sample( HW_EXC_STS.get_mirrored_value()   );
        end
    endfunction

    /*----------------------- CSRNG__RECOV_ALERT_STS SAMPLE FUNCTIONS -----------------------*/
    function void csrng__RECOV_ALERT_STS::sample(uvm_reg_data_t  data,
                                                   uvm_reg_data_t  byte_en,
                                                   bit             is_read,
                                                   uvm_reg_map     map);
        m_current = get();
        m_data    = data;
        m_is_read = is_read;
        if (get_coverage(UVM_CVR_REG_BITS)) begin
            foreach(ENABLE_FIELD_ALERT_bit_cg[bt]) this.ENABLE_FIELD_ALERT_bit_cg[bt].sample(data[0 + bt]);
            foreach(SW_APP_ENABLE_FIELD_ALERT_bit_cg[bt]) this.SW_APP_ENABLE_FIELD_ALERT_bit_cg[bt].sample(data[1 + bt]);
            foreach(READ_INT_STATE_FIELD_ALERT_bit_cg[bt]) this.READ_INT_STATE_FIELD_ALERT_bit_cg[bt].sample(data[2 + bt]);
            foreach(FIPS_FORCE_ENABLE_FIELD_ALERT_bit_cg[bt]) this.FIPS_FORCE_ENABLE_FIELD_ALERT_bit_cg[bt].sample(data[3 + bt]);
            foreach(ACMD_FLAG0_FIELD_ALERT_bit_cg[bt]) this.ACMD_FLAG0_FIELD_ALERT_bit_cg[bt].sample(data[4 + bt]);
            foreach(CS_BUS_CMP_ALERT_bit_cg[bt]) this.CS_BUS_CMP_ALERT_bit_cg[bt].sample(data[12 + bt]);
            foreach(CMD_STAGE_INVALID_ACMD_ALERT_bit_cg[bt]) this.CMD_STAGE_INVALID_ACMD_ALERT_bit_cg[bt].sample(data[13 + bt]);
            foreach(CMD_STAGE_INVALID_CMD_SEQ_ALERT_bit_cg[bt]) this.CMD_STAGE_INVALID_CMD_SEQ_ALERT_bit_cg[bt].sample(data[14 + bt]);
            foreach(CMD_STAGE_RESEED_CNT_ALERT_bit_cg[bt]) this.CMD_STAGE_RESEED_CNT_ALERT_bit_cg[bt].sample(data[15 + bt]);
        end
        if (get_coverage(UVM_CVR_FIELD_VALS)) begin
            this.fld_cg.sample( data[0:0]/*ENABLE_FIELD_ALERT*/  ,  data[1:1]/*SW_APP_ENABLE_FIELD_ALERT*/  ,  data[2:2]/*READ_INT_STATE_FIELD_ALERT*/  ,  data[3:3]/*FIPS_FORCE_ENABLE_FIELD_ALERT*/  ,  data[4:4]/*ACMD_FLAG0_FIELD_ALERT*/  ,  data[12:12]/*CS_BUS_CMP_ALERT*/  ,  data[13:13]/*CMD_STAGE_INVALID_ACMD_ALERT*/  ,  data[14:14]/*CMD_STAGE_INVALID_CMD_SEQ_ALERT*/  ,  data[15:15]/*CMD_STAGE_RESEED_CNT_ALERT*/   );
        end
    endfunction

    function void csrng__RECOV_ALERT_STS::sample_values();
        if (get_coverage(UVM_CVR_REG_BITS)) begin
            foreach(ENABLE_FIELD_ALERT_bit_cg[bt]) this.ENABLE_FIELD_ALERT_bit_cg[bt].sample(ENABLE_FIELD_ALERT.get_mirrored_value() >> bt);
            foreach(SW_APP_ENABLE_FIELD_ALERT_bit_cg[bt]) this.SW_APP_ENABLE_FIELD_ALERT_bit_cg[bt].sample(SW_APP_ENABLE_FIELD_ALERT.get_mirrored_value() >> bt);
            foreach(READ_INT_STATE_FIELD_ALERT_bit_cg[bt]) this.READ_INT_STATE_FIELD_ALERT_bit_cg[bt].sample(READ_INT_STATE_FIELD_ALERT.get_mirrored_value() >> bt);
            foreach(FIPS_FORCE_ENABLE_FIELD_ALERT_bit_cg[bt]) this.FIPS_FORCE_ENABLE_FIELD_ALERT_bit_cg[bt].sample(FIPS_FORCE_ENABLE_FIELD_ALERT.get_mirrored_value() >> bt);
            foreach(ACMD_FLAG0_FIELD_ALERT_bit_cg[bt]) this.ACMD_FLAG0_FIELD_ALERT_bit_cg[bt].sample(ACMD_FLAG0_FIELD_ALERT.get_mirrored_value() >> bt);
            foreach(CS_BUS_CMP_ALERT_bit_cg[bt]) this.CS_BUS_CMP_ALERT_bit_cg[bt].sample(CS_BUS_CMP_ALERT.get_mirrored_value() >> bt);
            foreach(CMD_STAGE_INVALID_ACMD_ALERT_bit_cg[bt]) this.CMD_STAGE_INVALID_ACMD_ALERT_bit_cg[bt].sample(CMD_STAGE_INVALID_ACMD_ALERT.get_mirrored_value() >> bt);
            foreach(CMD_STAGE_INVALID_CMD_SEQ_ALERT_bit_cg[bt]) this.CMD_STAGE_INVALID_CMD_SEQ_ALERT_bit_cg[bt].sample(CMD_STAGE_INVALID_CMD_SEQ_ALERT.get_mirrored_value() >> bt);
            foreach(CMD_STAGE_RESEED_CNT_ALERT_bit_cg[bt]) this.CMD_STAGE_RESEED_CNT_ALERT_bit_cg[bt].sample(CMD_STAGE_RESEED_CNT_ALERT.get_mirrored_value() >> bt);
        end
        if (get_coverage(UVM_CVR_FIELD_VALS)) begin
            this.fld_cg.sample( ENABLE_FIELD_ALERT.get_mirrored_value()  ,  SW_APP_ENABLE_FIELD_ALERT.get_mirrored_value()  ,  READ_INT_STATE_FIELD_ALERT.get_mirrored_value()  ,  FIPS_FORCE_ENABLE_FIELD_ALERT.get_mirrored_value()  ,  ACMD_FLAG0_FIELD_ALERT.get_mirrored_value()  ,  CS_BUS_CMP_ALERT.get_mirrored_value()  ,  CMD_STAGE_INVALID_ACMD_ALERT.get_mirrored_value()  ,  CMD_STAGE_INVALID_CMD_SEQ_ALERT.get_mirrored_value()  ,  CMD_STAGE_RESEED_CNT_ALERT.get_mirrored_value()   );
        end
    endfunction

    /*----------------------- CSRNG__ERR_CODE SAMPLE FUNCTIONS -----------------------*/
    function void csrng__ERR_CODE::sample(uvm_reg_data_t  data,
                                                   uvm_reg_data_t  byte_en,
                                                   bit             is_read,
                                                   uvm_reg_map     map);
        m_current = get();
        m_data    = data;
        m_is_read = is_read;
        if (get_coverage(UVM_CVR_REG_BITS)) begin
            foreach(SFIFO_CMD_ERR_bit_cg[bt]) this.SFIFO_CMD_ERR_bit_cg[bt].sample(data[0 + bt]);
            foreach(SFIFO_GENBITS_ERR_bit_cg[bt]) this.SFIFO_GENBITS_ERR_bit_cg[bt].sample(data[1 + bt]);
            foreach(SFIFO_CMDREQ_ERR_bit_cg[bt]) this.SFIFO_CMDREQ_ERR_bit_cg[bt].sample(data[2 + bt]);
            foreach(SFIFO_RCSTAGE_ERR_bit_cg[bt]) this.SFIFO_RCSTAGE_ERR_bit_cg[bt].sample(data[3 + bt]);
            foreach(SFIFO_KEYVRC_ERR_bit_cg[bt]) this.SFIFO_KEYVRC_ERR_bit_cg[bt].sample(data[4 + bt]);
            foreach(SFIFO_UPDREQ_ERR_bit_cg[bt]) this.SFIFO_UPDREQ_ERR_bit_cg[bt].sample(data[5 + bt]);
            foreach(SFIFO_BENCREQ_ERR_bit_cg[bt]) this.SFIFO_BENCREQ_ERR_bit_cg[bt].sample(data[6 + bt]);
            foreach(SFIFO_BENCACK_ERR_bit_cg[bt]) this.SFIFO_BENCACK_ERR_bit_cg[bt].sample(data[7 + bt]);
            foreach(SFIFO_PDATA_ERR_bit_cg[bt]) this.SFIFO_PDATA_ERR_bit_cg[bt].sample(data[8 + bt]);
            foreach(SFIFO_FINAL_ERR_bit_cg[bt]) this.SFIFO_FINAL_ERR_bit_cg[bt].sample(data[9 + bt]);
            foreach(SFIFO_GBENCACK_ERR_bit_cg[bt]) this.SFIFO_GBENCACK_ERR_bit_cg[bt].sample(data[10 + bt]);
            foreach(SFIFO_GRCSTAGE_ERR_bit_cg[bt]) this.SFIFO_GRCSTAGE_ERR_bit_cg[bt].sample(data[11 + bt]);
            foreach(SFIFO_GGENREQ_ERR_bit_cg[bt]) this.SFIFO_GGENREQ_ERR_bit_cg[bt].sample(data[12 + bt]);
            foreach(SFIFO_GADSTAGE_ERR_bit_cg[bt]) this.SFIFO_GADSTAGE_ERR_bit_cg[bt].sample(data[13 + bt]);
            foreach(SFIFO_GGENBITS_ERR_bit_cg[bt]) this.SFIFO_GGENBITS_ERR_bit_cg[bt].sample(data[14 + bt]);
            foreach(SFIFO_BLKENC_ERR_bit_cg[bt]) this.SFIFO_BLKENC_ERR_bit_cg[bt].sample(data[15 + bt]);
            foreach(CMD_STAGE_SM_ERR_bit_cg[bt]) this.CMD_STAGE_SM_ERR_bit_cg[bt].sample(data[20 + bt]);
            foreach(MAIN_SM_ERR_bit_cg[bt]) this.MAIN_SM_ERR_bit_cg[bt].sample(data[21 + bt]);
            foreach(DRBG_GEN_SM_ERR_bit_cg[bt]) this.DRBG_GEN_SM_ERR_bit_cg[bt].sample(data[22 + bt]);
            foreach(DRBG_UPDBE_SM_ERR_bit_cg[bt]) this.DRBG_UPDBE_SM_ERR_bit_cg[bt].sample(data[23 + bt]);
            foreach(DRBG_UPDOB_SM_ERR_bit_cg[bt]) this.DRBG_UPDOB_SM_ERR_bit_cg[bt].sample(data[24 + bt]);
            foreach(AES_CIPHER_SM_ERR_bit_cg[bt]) this.AES_CIPHER_SM_ERR_bit_cg[bt].sample(data[25 + bt]);
            foreach(CMD_GEN_CNT_ERR_bit_cg[bt]) this.CMD_GEN_CNT_ERR_bit_cg[bt].sample(data[26 + bt]);
            foreach(FIFO_WRITE_ERR_bit_cg[bt]) this.FIFO_WRITE_ERR_bit_cg[bt].sample(data[28 + bt]);
            foreach(FIFO_READ_ERR_bit_cg[bt]) this.FIFO_READ_ERR_bit_cg[bt].sample(data[29 + bt]);
            foreach(FIFO_STATE_ERR_bit_cg[bt]) this.FIFO_STATE_ERR_bit_cg[bt].sample(data[30 + bt]);
        end
        if (get_coverage(UVM_CVR_FIELD_VALS)) begin
            this.fld_cg.sample( data[0:0]/*SFIFO_CMD_ERR*/  ,  data[1:1]/*SFIFO_GENBITS_ERR*/  ,  data[2:2]/*SFIFO_CMDREQ_ERR*/  ,  data[3:3]/*SFIFO_RCSTAGE_ERR*/  ,  data[4:4]/*SFIFO_KEYVRC_ERR*/  ,  data[5:5]/*SFIFO_UPDREQ_ERR*/  ,  data[6:6]/*SFIFO_BENCREQ_ERR*/  ,  data[7:7]/*SFIFO_BENCACK_ERR*/  ,  data[8:8]/*SFIFO_PDATA_ERR*/  ,  data[9:9]/*SFIFO_FINAL_ERR*/  ,  data[10:10]/*SFIFO_GBENCACK_ERR*/  ,  data[11:11]/*SFIFO_GRCSTAGE_ERR*/  ,  data[12:12]/*SFIFO_GGENREQ_ERR*/  ,  data[13:13]/*SFIFO_GADSTAGE_ERR*/  ,  data[14:14]/*SFIFO_GGENBITS_ERR*/  ,  data[15:15]/*SFIFO_BLKENC_ERR*/  ,  data[20:20]/*CMD_STAGE_SM_ERR*/  ,  data[21:21]/*MAIN_SM_ERR*/  ,  data[22:22]/*DRBG_GEN_SM_ERR*/  ,  data[23:23]/*DRBG_UPDBE_SM_ERR*/  ,  data[24:24]/*DRBG_UPDOB_SM_ERR*/  ,  data[25:25]/*AES_CIPHER_SM_ERR*/  ,  data[26:26]/*CMD_GEN_CNT_ERR*/  ,  data[28:28]/*FIFO_WRITE_ERR*/  ,  data[29:29]/*FIFO_READ_ERR*/  ,  data[30:30]/*FIFO_STATE_ERR*/   );
        end
    endfunction

    function void csrng__ERR_CODE::sample_values();
        if (get_coverage(UVM_CVR_REG_BITS)) begin
            foreach(SFIFO_CMD_ERR_bit_cg[bt]) this.SFIFO_CMD_ERR_bit_cg[bt].sample(SFIFO_CMD_ERR.get_mirrored_value() >> bt);
            foreach(SFIFO_GENBITS_ERR_bit_cg[bt]) this.SFIFO_GENBITS_ERR_bit_cg[bt].sample(SFIFO_GENBITS_ERR.get_mirrored_value() >> bt);
            foreach(SFIFO_CMDREQ_ERR_bit_cg[bt]) this.SFIFO_CMDREQ_ERR_bit_cg[bt].sample(SFIFO_CMDREQ_ERR.get_mirrored_value() >> bt);
            foreach(SFIFO_RCSTAGE_ERR_bit_cg[bt]) this.SFIFO_RCSTAGE_ERR_bit_cg[bt].sample(SFIFO_RCSTAGE_ERR.get_mirrored_value() >> bt);
            foreach(SFIFO_KEYVRC_ERR_bit_cg[bt]) this.SFIFO_KEYVRC_ERR_bit_cg[bt].sample(SFIFO_KEYVRC_ERR.get_mirrored_value() >> bt);
            foreach(SFIFO_UPDREQ_ERR_bit_cg[bt]) this.SFIFO_UPDREQ_ERR_bit_cg[bt].sample(SFIFO_UPDREQ_ERR.get_mirrored_value() >> bt);
            foreach(SFIFO_BENCREQ_ERR_bit_cg[bt]) this.SFIFO_BENCREQ_ERR_bit_cg[bt].sample(SFIFO_BENCREQ_ERR.get_mirrored_value() >> bt);
            foreach(SFIFO_BENCACK_ERR_bit_cg[bt]) this.SFIFO_BENCACK_ERR_bit_cg[bt].sample(SFIFO_BENCACK_ERR.get_mirrored_value() >> bt);
            foreach(SFIFO_PDATA_ERR_bit_cg[bt]) this.SFIFO_PDATA_ERR_bit_cg[bt].sample(SFIFO_PDATA_ERR.get_mirrored_value() >> bt);
            foreach(SFIFO_FINAL_ERR_bit_cg[bt]) this.SFIFO_FINAL_ERR_bit_cg[bt].sample(SFIFO_FINAL_ERR.get_mirrored_value() >> bt);
            foreach(SFIFO_GBENCACK_ERR_bit_cg[bt]) this.SFIFO_GBENCACK_ERR_bit_cg[bt].sample(SFIFO_GBENCACK_ERR.get_mirrored_value() >> bt);
            foreach(SFIFO_GRCSTAGE_ERR_bit_cg[bt]) this.SFIFO_GRCSTAGE_ERR_bit_cg[bt].sample(SFIFO_GRCSTAGE_ERR.get_mirrored_value() >> bt);
            foreach(SFIFO_GGENREQ_ERR_bit_cg[bt]) this.SFIFO_GGENREQ_ERR_bit_cg[bt].sample(SFIFO_GGENREQ_ERR.get_mirrored_value() >> bt);
            foreach(SFIFO_GADSTAGE_ERR_bit_cg[bt]) this.SFIFO_GADSTAGE_ERR_bit_cg[bt].sample(SFIFO_GADSTAGE_ERR.get_mirrored_value() >> bt);
            foreach(SFIFO_GGENBITS_ERR_bit_cg[bt]) this.SFIFO_GGENBITS_ERR_bit_cg[bt].sample(SFIFO_GGENBITS_ERR.get_mirrored_value() >> bt);
            foreach(SFIFO_BLKENC_ERR_bit_cg[bt]) this.SFIFO_BLKENC_ERR_bit_cg[bt].sample(SFIFO_BLKENC_ERR.get_mirrored_value() >> bt);
            foreach(CMD_STAGE_SM_ERR_bit_cg[bt]) this.CMD_STAGE_SM_ERR_bit_cg[bt].sample(CMD_STAGE_SM_ERR.get_mirrored_value() >> bt);
            foreach(MAIN_SM_ERR_bit_cg[bt]) this.MAIN_SM_ERR_bit_cg[bt].sample(MAIN_SM_ERR.get_mirrored_value() >> bt);
            foreach(DRBG_GEN_SM_ERR_bit_cg[bt]) this.DRBG_GEN_SM_ERR_bit_cg[bt].sample(DRBG_GEN_SM_ERR.get_mirrored_value() >> bt);
            foreach(DRBG_UPDBE_SM_ERR_bit_cg[bt]) this.DRBG_UPDBE_SM_ERR_bit_cg[bt].sample(DRBG_UPDBE_SM_ERR.get_mirrored_value() >> bt);
            foreach(DRBG_UPDOB_SM_ERR_bit_cg[bt]) this.DRBG_UPDOB_SM_ERR_bit_cg[bt].sample(DRBG_UPDOB_SM_ERR.get_mirrored_value() >> bt);
            foreach(AES_CIPHER_SM_ERR_bit_cg[bt]) this.AES_CIPHER_SM_ERR_bit_cg[bt].sample(AES_CIPHER_SM_ERR.get_mirrored_value() >> bt);
            foreach(CMD_GEN_CNT_ERR_bit_cg[bt]) this.CMD_GEN_CNT_ERR_bit_cg[bt].sample(CMD_GEN_CNT_ERR.get_mirrored_value() >> bt);
            foreach(FIFO_WRITE_ERR_bit_cg[bt]) this.FIFO_WRITE_ERR_bit_cg[bt].sample(FIFO_WRITE_ERR.get_mirrored_value() >> bt);
            foreach(FIFO_READ_ERR_bit_cg[bt]) this.FIFO_READ_ERR_bit_cg[bt].sample(FIFO_READ_ERR.get_mirrored_value() >> bt);
            foreach(FIFO_STATE_ERR_bit_cg[bt]) this.FIFO_STATE_ERR_bit_cg[bt].sample(FIFO_STATE_ERR.get_mirrored_value() >> bt);
        end
        if (get_coverage(UVM_CVR_FIELD_VALS)) begin
            this.fld_cg.sample( SFIFO_CMD_ERR.get_mirrored_value()  ,  SFIFO_GENBITS_ERR.get_mirrored_value()  ,  SFIFO_CMDREQ_ERR.get_mirrored_value()  ,  SFIFO_RCSTAGE_ERR.get_mirrored_value()  ,  SFIFO_KEYVRC_ERR.get_mirrored_value()  ,  SFIFO_UPDREQ_ERR.get_mirrored_value()  ,  SFIFO_BENCREQ_ERR.get_mirrored_value()  ,  SFIFO_BENCACK_ERR.get_mirrored_value()  ,  SFIFO_PDATA_ERR.get_mirrored_value()  ,  SFIFO_FINAL_ERR.get_mirrored_value()  ,  SFIFO_GBENCACK_ERR.get_mirrored_value()  ,  SFIFO_GRCSTAGE_ERR.get_mirrored_value()  ,  SFIFO_GGENREQ_ERR.get_mirrored_value()  ,  SFIFO_GADSTAGE_ERR.get_mirrored_value()  ,  SFIFO_GGENBITS_ERR.get_mirrored_value()  ,  SFIFO_BLKENC_ERR.get_mirrored_value()  ,  CMD_STAGE_SM_ERR.get_mirrored_value()  ,  MAIN_SM_ERR.get_mirrored_value()  ,  DRBG_GEN_SM_ERR.get_mirrored_value()  ,  DRBG_UPDBE_SM_ERR.get_mirrored_value()  ,  DRBG_UPDOB_SM_ERR.get_mirrored_value()  ,  AES_CIPHER_SM_ERR.get_mirrored_value()  ,  CMD_GEN_CNT_ERR.get_mirrored_value()  ,  FIFO_WRITE_ERR.get_mirrored_value()  ,  FIFO_READ_ERR.get_mirrored_value()  ,  FIFO_STATE_ERR.get_mirrored_value()   );
        end
    endfunction

    /*----------------------- CSRNG__ERR_CODE_TEST SAMPLE FUNCTIONS -----------------------*/
    function void csrng__ERR_CODE_TEST::sample(uvm_reg_data_t  data,
                                                   uvm_reg_data_t  byte_en,
                                                   bit             is_read,
                                                   uvm_reg_map     map);
        m_current = get();
        m_data    = data;
        m_is_read = is_read;
        if (get_coverage(UVM_CVR_REG_BITS)) begin
            foreach(ERR_CODE_TEST_bit_cg[bt]) this.ERR_CODE_TEST_bit_cg[bt].sample(data[0 + bt]);
        end
        if (get_coverage(UVM_CVR_FIELD_VALS)) begin
            this.fld_cg.sample( data[4:0]/*ERR_CODE_TEST*/   );
        end
    endfunction

    function void csrng__ERR_CODE_TEST::sample_values();
        if (get_coverage(UVM_CVR_REG_BITS)) begin
            foreach(ERR_CODE_TEST_bit_cg[bt]) this.ERR_CODE_TEST_bit_cg[bt].sample(ERR_CODE_TEST.get_mirrored_value() >> bt);
        end
        if (get_coverage(UVM_CVR_FIELD_VALS)) begin
            this.fld_cg.sample( ERR_CODE_TEST.get_mirrored_value()   );
        end
    endfunction

    /*----------------------- CSRNG__MAIN_SM_STATE SAMPLE FUNCTIONS -----------------------*/
    function void csrng__MAIN_SM_STATE::sample(uvm_reg_data_t  data,
                                                   uvm_reg_data_t  byte_en,
                                                   bit             is_read,
                                                   uvm_reg_map     map);
        m_current = get();
        m_data    = data;
        m_is_read = is_read;
        if (get_coverage(UVM_CVR_REG_BITS)) begin
            foreach(MAIN_SM_STATE_bit_cg[bt]) this.MAIN_SM_STATE_bit_cg[bt].sample(data[0 + bt]);
        end
        if (get_coverage(UVM_CVR_FIELD_VALS)) begin
            this.fld_cg.sample( data[7:0]/*MAIN_SM_STATE*/   );
        end
    endfunction

    function void csrng__MAIN_SM_STATE::sample_values();
        if (get_coverage(UVM_CVR_REG_BITS)) begin
            foreach(MAIN_SM_STATE_bit_cg[bt]) this.MAIN_SM_STATE_bit_cg[bt].sample(MAIN_SM_STATE.get_mirrored_value() >> bt);
        end
        if (get_coverage(UVM_CVR_FIELD_VALS)) begin
            this.fld_cg.sample( MAIN_SM_STATE.get_mirrored_value()   );
        end
    endfunction

`endif