//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  NAME      :- Pradip Prajapati
//  FILE_NAME :- ahb_seq_pkg.sv
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////


/**
 * Abstract:
 * ahb_seq_pkg includes all the master and slave sequences.
 */

`include "ahb_base_master_sequence.sv"
`include "ahb_base_slave_sequence.sv"
`include "ahb_master_sanity_sequence.sv"
`include "ahb_master_rst_sequence.sv"
`include "ahb_master_b2b_sequence.sv"
`include "ahb_master_incr_sequence.sv"
`include "ahb_master_increment_burst_sequence.sv"
`include "ahb_master_wrap_sequence.sv"
`include "ahb_master_min_max_addr_data_sequence.sv"
`include "ahb_master_waited_busy_seq_sequence.sv"
`include "ahb_master_waited_trans_change_sequence.sv"
`include "ahb_master_waited_max_busy_sequence.sv"
`include "ahb_master_random_sequence.sv"
`include "ahb_master_error_sequence.sv"
`include "ahb_slave_okay_response_sequence.sv"
`include "ahb_slave_mem_response_sequence.sv"
`include "ahb_slave_mem_response_max_wait_sequence.sv"
`include "ahb_slave_mem_response_min_wait_sequence.sv"
`include "ahb_slave_random_response_sequence.sv"
