/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  NAME      :- Pradip Prajapati
//  FILE_NAME :- ahb_base_test.sv
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Abstract:
 * This file creates test 'ahb_base_test', which is extended from the
 * uvm_test class.
 *
 * In the build phase of the test we will set the necessary test related
 * information:
 *  - System config for configuration whole envionment
 *  - Create environment
 *
 */

`ifndef SRAM_RESET_TEST
`define SRAM_RESET_TEST

class sram_reset_test extends ahb_base_test;

  /** factory registration */
  `uvm_component_utils(sram_reset_test)

  /** class constructor */
  extern function new(string name = "sram_reset_test", uvm_component parent = null);

  /** run phase */
  extern task run_phase(uvm_phase phase);

endclass : ahb_base_test

//*****************************************************************************
//methods
//*****************************************************************************

/** class constructor */
function ahb_base_test::new(string name = "sram_reset_test", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

task ahb_base_test::run_phase(uvm_phase phase);

  phase.raise_objection(this);

    wait(cortexm3_soc_tb.cortexm3_soc_i0.cmsdk_fpga_sram_A.BRAM0['h3fc][1:0]===2'b11);
 
  phase.drop_objection(this);

endtask : run_phase


`endif  //SRAM_RESET_TEST
