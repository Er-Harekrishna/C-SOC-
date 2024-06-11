/////////////////////////////////////////////////////////////////////////
// Company        : SCALEDGE 
// Engineer       : JAYDEEP 
// Create Date    : 10-10-2023
// File Name   	  : uart_top.sv
// Class Name 	  : uart_top
// Project Name	  : UART_UVC 
// Description	  : 
//////////////////////////////////////////////////////////////////////////



`timescale 10ns/1ps
`include "apb_defines.sv"
`include "uvm_macros.svh"

import uvm_pkg::*;
`include "uart_interface.sv"
//package uvc_pkg;
   //header files
   import uvm_pkg::*;
   `include "uvm_macros.svh"
   
   //Global defines file
   `include "apb_defines.sv"

   //Agent configuration file
   //`include "apb_master_config.sv"
    `include "uart_reg_config.sv"
  `include "apb_env_config.sv"
 
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
   `include "uart_scoreboard.sv"
     `include "uart_uvc_env.sv"
    `include "uvc_env_top.sv"
      
   
   // `include "apb_env.sv"
     `include "uart_reg_config_seqs.sv"
   // `include "dut_reg_config_seq.sv"
    `include "uart_slave_write_seqs.sv"
    `include "uart_slave_read_seqs.sv"
    //`include "apb_uart_tx_write_with_cmd_seqs.sv"
    //`include "apb_uart_rx_read_with_cmd_seqs.sv"
    //`include "apb_uart_tx_rx_write_read_with_cmd_seqs.sv"
    //`include "apb_uart_tx_write_tx_fifo_clear_seqs.sv"
    //`include "apb_uart_tx_write_seqs.sv"


   //Testcases   
   `include "uart_base_test.sv"
  //  `include "apb_uart_tx_write_test.sv"
   // `include "apb_uart_tx_write_with_cmd_test.sv"
    `include "apb_uart_rx_read_with_cmd_test.sv"
  //  `include "apb_uart_tx_write_tx_fifo_clear_test.sv"
    `include "uart_tx_rx_write_read_with_cmd_test.sv"

 //import uvc_pkg::*;
//`include "uart_reg_config.sv"

module uart_top;
 bit PCLK; 
   //PCLK and Active low RESET   
      //clock generation
   initial begin
      forever begin
         PCLK = 1'b0;
         #((1/((1e-8)*(`APB_CLK_FREQ)))/2.0);
         PCLK = 1'b1;
         #((1/((1e-8)*(`APB_CLK_FREQ)))/2.0);
      end //forever
   end //initial


  
   //Interface instance
   //apb_inf inf(PCLK,PRESETn);
   uart_interface  uinf_master(PCLK,PRESETn);
   uart_interface  uinf_slave(PCLK,PRESETn);
   
   // reg config and baud_clk class instances
   uart_reg_config reg_cfg;  
    

   always @(*) uinf_master.rxd = uinf_slave.txd;
   always @(*) uinf_slave.rxd = uinf_master.txd;
    //connect apb interface to uart rtl
   // apb_uart_sv DUT(.tx_o(uinf.rxd),.rx_i(uinf.txd),.CLK(PCLK),.RSTN(PRESETn),.PSEL(inf.PSEL),.PWRITE(inf.PWRITE),.PENABLE(inf.PENABLE),.PADDR(inf.PADDR),.PWDATA(inf.PWDATA),.PRDATA(inf.PRDATA),.PREADY(inf.PREADY),.PSLVERR(inf.PSLVERR));

        

   initial begin
      //Setting the apb and uart interface
      // uvm_config_db#(virtual apb_inf)::set(null,"*","vif",inf);
       uvm_config_db#(virtual uart_interface)::set(null,"*","mas_vif",uinf_master); 
       uvm_config_db#(virtual uart_interface)::set(null,"*","slv_vif",uinf_slave); 
       // acording baud_rate to generate shift pulse create baud_clk
            // call the test class
       run_test("uart_tx_rx_write_read_with_cmd_test");

   end // initial
endmodule


