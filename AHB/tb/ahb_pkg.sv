/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  NAME      :- Pradip Prajapati
//  FILE_NAME :- ahb_pkg.sv
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * The ahb_pkg contains all the transaction, configuration, agnets, environment,
 * sequences and test class files.
 *
 */

`include "srams_if.sv"

`include "ahb_defines.sv"
`include "ahb_inf.sv"

package ahb_pkg;

  /** importing uvm package */
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  `include "sram_transaction.sv"
  `include "srams_mon.sv"

  `include "ahb_defines.sv"
  `include "ahb_base_transaction.sv"
  
  /** master files */
  `include "ahb_master_pkg.sv"
  
  /** slave files */
  `include "ahb_slave_pkg.sv"
   
  /** uvc file */
  `include "ahb_uvc_configuration.sv"
  `include "ahb_uvc.sv"

  /** sequence package contains all the sequences */
  `include "ahb_seq_pkg.sv" 

  /** coverage collector and scoreboard */
  `include "ahb_coverage_collector.sv"
  `include "ahb_scoreboard.sv"

  /** environment and environment configuration class */
  `include "ahb_environment_configuration.sv"
  `include "ahb_environment.sv"
  `include "ahb_system_config.sv"

  /** test pacakge contains all the tests */
  //`include "ahb_test_pkg.sv"

endpackage : ahb_pkg

