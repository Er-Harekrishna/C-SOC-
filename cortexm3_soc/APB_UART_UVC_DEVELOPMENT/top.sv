`timescale 1ns/1ns
//`include "uvm_pkg.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;
`include "uart_interrupt.sv"
`include "io_generic_fifo.sv"
`include "uart_tx.sv"
`include "uart_rx.sv"
`include "apb_uart.sv"
`include "assertion.sv"
`include "apb_uart_intf.sv"
`include "apb_uart_tx.sv"
`include "apb_uart_seq_lib.sv"
`include "apb_uart_sqr.sv"
`include "apb_uart_drv.sv"
`include "apb_uart_mon.sv"
`include "apb_uart_cov.sv"
`include "apb_uart_sbd.sv"
`include "apb_uart_agent.sv"
`include "apb_uart_env.sv"
`include "apb_uart_test_lib.sv"
parameter TX_FIFO_DEPTH = 16; // in bytes
parameter RX_FIFO_DEPTH = 16; // in bytes
module top;  
reg pclk, preset;
apb_uart_intf pif(pclk,preset);
wire connect;
initial begin
pclk = 0;
forever #5 pclk = ~ pclk;
end

initial begin
preset = 0; 
repeat (2) @(posedge pclk);
preset = 1;
end

apb_uart_sv #(12) dut(
              .CLK(pif.pclk),
              .RSTN(pif.preset),
              .PADDR(pif.paddr),
              .PWRITE(pif.pwrite),
              .PWDATA(pif.pwdata),
              .PRDATA(pif.prdata),
              .PSEL(pif.pselx),
              .PSLVERR(pif.pslverr),
              .PENABLE(pif.penable),
              .PREADY(pif.pready),
              .rx_i(connect),
              .tx_o(connect),
              .event_o(pif.event_o)
           );

bit clk;
bit rstn;
bit [2:0]       register_adr;
bit [9:0][7:0]  regs_q, regs_n;
bit [1:0]       trigger_level_n, trigger_level_q;
// receive buffer register, read only
bit [7:0]       rx_data;
// parity error
bit             parity_error;
bit [3:0]       IIR_o;
bit [3:0]       clr_int;
/* verilator lint_off UNOPTFLAT */
// tx flow control
bit             tx_ready;
/* lint_on */
// rx flow control
bit  apb_rx_ready;
bit  rx_valid;
bit  tx_fifo_clr_n;
bit  tx_fifo_clr_q;
bit  rx_fifo_clr_n; 
bit  rx_fifo_clr_q;
bit  fifo_tx_valid;
bit  tx_valid;
bit  fifo_rx_valid;
bit  fifo_rx_ready;
bit  rx_ready;
bit  [7:0] fifo_tx_data;
bit  [8:0] fifo_rx_data;
bit  [7:0] tx_data;
bit  [$clog2(TX_FIFO_DEPTH):0] tx_elements;
bit  [$clog2(RX_FIFO_DEPTH):0] rx_elements;

assign clk = dut.CLK;
assign rstn = dut.RSTN;
assign register_adr = dut.register_adr;
assign regs_q =  dut.regs_q;
assign regs_n =  dut.regs_n;
assign trigger_level_n = dut.trigger_level_n;
assign trigger_level_q = dut.trigger_level_q;
assign rx_data =  dut.rx_data;
assign parity_error =  dut.parity_error;
assign IIR_o =  dut.IIR_o;
assign clr_int = dut.clr_int;
assign tx_ready = dut.tx_ready;
assign apb_rx_ready = dut.apb_rx_ready;
assign rx_valid = dut.rx_valid;
assign tx_fifo_clr_n = dut.tx_fifo_clr_n;
assign tx_fifo_clr_q = dut.tx_fifo_clr_q;
assign fifo_tx_valid = dut.fifo_tx_valid;
assign tx_valid = dut.tx_valid;
assign fifo_rx_valid = dut.fifo_rx_valid;
assign fifo_rx_ready = dut.fifo_rx_ready;
assign rx_ready = dut.rx_ready;
assign fifo_tx_data = dut.fifo_tx_data;
assign fifo_rx_data = dut.fifo_rx_data;
assign tx_data = dut.tx_data;
assign tx_elements = dut.tx_elements;
assign rx_elements = dut.rx_elements;

//   bind dut assertion apb_uart_assertion(
//    .clk(pclk),
//    .resetn(presetn),
//    .wdata(pwdata),
//    .addr(paddr),
//    .selx(pselx),
//    .enable(penable),
//    .write(pwrite),
//    .rdata(prdata),
//    .ready(pready),
//    .slverr(pslverr)
//  ); 

initial begin
   uvm_config_db#(virtual apb_uart_intf)::set(null,"*","vif",pif);
end
  initial begin
//   run_test("apb_uart_wr_test");
//   run_test("apb_uart_rd_test");
//   run_test("apb_uart_wr_rd_spec_test3");
//     run_test("apb_uart_wr_rd_spec_test4");
//   run_test("apb_uart_wr_rd_spec_test5");
//   run_test("apb_uart_wr_rd_spec_test6");
//   run_test("apb_uart_wr_rd_spec_test7");
//   run_test("apb_uart_wr_rd_spec_test8");
//   run_test("apb_uart_wr_rd_spec_test9");
//   run_test("apb_uart_wr_rd_spec_test10");
//   run_test("apb_uart_wr_rd_spec_test11");
//   run_test("apb_uart_wr_rd_spec_test12");
//   run_test("apb_uart_wr_rd_spec_test13");
     run_test("apb_uart_wr_rd_spec_test14");
//     run_test("apb_uart_wr_rd_spec_test15");
//   run_test("apb_uart_regression_test");
   //run_test("apb_uart_n_wr_n_rd_test");
   //run_test("apb_uart_wr_error_test");
   //run_test("apb_uart_rd_error_test");
    //run_test("apb_uart_rd_error_test");
    //run_test("apb_uart_rd_error_test");

  end

//reg clk_baud;
//assign clk_baud = pclk;
////BAUD_RATE_CLOCK _GENERATOR
////FREQUENCY_DIVIDER_CIRCUIT
//initial begin
//$value$plusargs("freq=%f",freq);
////frequency is 16MHZ 
//tp=100/freq;
//clk=0;
//$display("tp=%f",tp);
//forever begin 
//  #(tp/2)  clk=0;
//  #(tp/2)  clk=1;
//end
//end
//7.7.11 Programming Baud Generator
//The ACE contains a programmable baud generator that takes a clock input in the range between dc and 16 MHz
//and divides it by a divisor in the range between 1 and (216−1).The output frequency of the baud generator is
//sixteen times (16 x) the baud rate. The formula for the divisor is:
//divisor = XIN frequency input ÷ (desired baud rate x 16) 


// initial begin
//  $dump_file("test.vcd");
//  $dumpvars;
//end
//initial begin
//#3000;
//end
//$finish;
endmodule



