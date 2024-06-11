//////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  FILE_NAME :- ahb_top.sv
//  NAME      :- Pradip Prajapati
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Abstract:
 * Top-level testbench.
 * It instantites the interface.  Clock generation
 * is also  done in the same file.  It includes each test file and initiates
 * the test by calling run_test().
 */

`include "ahb_defines.sv"
`include "ahb_dut.v"
`include "ahb_dut_wrapper.sv"

module ahb_top;

  /** Parameter defines the clock frequency */
  parameter simulation_cycle = `TIME_PERIOD;

  /** Signal to generate the clock */
  bit SystemClock;

  /** Import UVM Package */
  import uvm_pkg::*;

  /** Import the AHB VIP */
  import ahb_pkg::*;

  /** VIP Interface instance representing the AHB system */
  ahb_inf inf();

  assign inf.hclk = SystemClock;
  
  /** dut connection */
  // -----------------------------------------------------------------------------
  ahb_dut_wrapper DUT(inf);

  /** Testbench 'System' Clock Generator */
  initial begin
    SystemClock = 0 ;
    forever begin
      #(simulation_cycle/2)
        SystemClock = ~SystemClock ;
    end
  end

  /** Provide initial reset*/
  initial begin

    inf.reset(0,5);

  end
 
  initial begin
    /**
     * Provide the AHB interface to the AHB System ENV.
    */
    uvm_config_db #(virtual ahb_inf)::set(null,"*","inf",inf);
    uvm_config_db #(virtual ahb_mas_inf)::set(null,"*ahb_uvc_h[0]*","mas_vif",inf.mas_if[0]);
    uvm_config_db #(virtual ahb_slv_inf)::set(null,"*ahb_uvc_h[1]*","slv_vif",inf.slv_if[0]);

    /** Start the UVM tests */
    run_test();
  end

endmodule : ahb_top
