//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  NAME      :- Pradip Prajapati
//  FILE_NAME :- AHB_slave_pkg.sv
//  EDITED_BY :- Pradip_Prajapati
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

//package ahb_slave_pkg;

  `include "ahb_base_test.sv"
  `include "report_catcher.sv"
  `include "ahb_master_sanity_test.sv" 
  `include "ahb_master_rst_test.sv" 
  `include "ahb_master_incr_test.sv" 
  `include "ahb_master_wrap_test.sv" 
  `include "ahb_master_b2b_test.sv"
  `include "ahb_master_error_test.sv"
  `include "ahb_master_waited_trans_change_test.sv"
  `include "ahb_master_waited_busy_test.sv"
  `include "ahb_master_increment_burst_test.sv"
  `include "ahb_master_min_max_addr_data_test.sv"
  `include "ahb_master_random_test.sv"
  `include "ahb_master_waited_max_busy_test.sv"
 
//endpackage : ahb_slave_pkg
