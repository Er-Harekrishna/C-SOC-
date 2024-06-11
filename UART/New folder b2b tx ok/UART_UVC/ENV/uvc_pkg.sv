///////////////////////////////////////////////
// File:          uvc_pkg.sv
// Version:       v1
// Developer:     Mayank
// Project Name:  APB3 Protocol
// Discription:   APB package file 
/////////////////////////////////////////////////

//
// Package Discription:
//


//`include "apb_defines.sv"
//`include "apb_inf.sv"
//`include "uart_interface.sv"
package uvc_pkg;
   //header files
   import uvm_pkg::*;
   `include "uvm_macros.svh"
   
   //Global defines file
   `include "apb_defines.sv"

   //Agent configuration file
   //`include "apb_master_config.sv"
    `include "uart_reg_config.sv"
  
   //Master and slave transaction files  
    
    `include "uart_seq_item.sv"
   //`include "apb_master_trans.sv"

   //master and  slave sequencer files
  // `include "apb_master_sequencer.sv"
    `include "uart_sequencer.sv"

   //Master files
  // `include "apb_master_driver.sv"
  // `include "apb_master_monitor.sv"
  // `include "apb_master_agent.sv"
  // `include "apb_master_uvc.sv"



    `include "uart_agent_config.sv"
    `include "uart_tx_monitor.sv"
    `include "uart_rx_monitor.sv"
    `include "uart_driver.sv"
    `include "uart_tx_agent.sv"
    `include "uart_rx_agent.sv"


   //Environment and Testcases seuqences
  // `include "apb_uart_scoreboard.sv"
   `include "uart_uvc_env.sv"
   // `include "apb_env_config.sv"
   // `include "apb_env.sv"
     `include "uart_reg_config_seqs.sv"
    //`include "dut_reg_config_seq.sv"
    `include "uart_slave_base_seqs.sv"
    `include "apb_uart_tx_write_with_cmd_seqs.sv"
    `include "apb_uart_rx_read_with_cmd_seqs.sv"
    `include "apb_uart_tx_rx_write_read_with_cmd_seqs.sv"
    `include "apb_uart_tx_write_tx_fifo_clear_seqs.sv"
    `include "apb_uart_tx_write_seqs.sv"


   //Testcases   
   `include "apb_base_test.sv"
    `include "apb_uart_tx_write_test.sv"
    `include "apb_uart_tx_write_with_cmd_test.sv"
    `include "apb_uart_rx_read_with_cmd_test.sv"
    `include "apb_uart_tx_write_tx_fifo_clear_test.sv"
    `include "apb_uart_tx_rx_write_read_with_cmd_test.sv"
    
   // `include "apb_read_test.sv"


endpackage : uvc_pkg
