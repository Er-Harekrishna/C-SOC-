/////////////////////////////////////////////////////////////////////////
// Company        : SCALEDGE 
// Engineer       : SIDDHARTH 
// Create Date    : 10-10-2023
// File Name   	  : uart_interface.sv
// Class Name 	  : uart_interface
// Project Name	  : UART_UVC 
// Description	  : 
//////////////////////////////////////////////////////////////////////////

/*
interface uart_interface(input logic clk,rstn);


    logic txd;    // Transmit Data
    logic rxd;    // Receive Data
    logic take_data; // for debugging purpose 
    int count;  // calculate the number of clock cycle for assertions
     // for state machine assertion
     // for state machine assertion

 // driveing clocking block  
  clocking uart_drv_cb@(posedge clk);
      default input #1 output #1;       
      output txd;
  endclocking
   
  // monitor clocking block
  clocking uart_mon_cb@(posedge clk);
      default input #1 output #1;
      input  rxd;
  endclocking

 
endinterface
*/
interface uart_interface(input logic clk,rstn);


    logic txd;    // Transmit Data
    logic rxd;    // Receive Data
    logic take_data; // for debugging purpose
    int count; // for assertion
    int tx_count,rx_count;
    logic tx_shift; 
    logic rx_shift;

    int tx_frame_count;
    logic [`THR_SIZE-1:0] rx_shifter = 'b1;
    logic [`THR_SIZE-1:0] tx_shifter = 'b1;
    logic [`THR_SIZE:0]tx_parity;
    logic tx_valid;

    // state machine for rx and tx which will change acording configuration
    state RX_STATE;
    state TX_STATE;
    
    // baudrate enable and disable pins
    logic tx_gated_clk;
    logic rx_gated_clk;


  // driveing clocking block  
  clocking uart_drv_cb@(posedge clk);
  default input #1 output #1;   
      input clk;
      output txd;
      output tx_gated_clk;
      output rx_gated_clk;
  endclocking
   
  // monitor clocking block
  clocking uart_mon_cb@(posedge clk);
  default input #1 output #1;   
      input  txd;
      input  rstn;
      input  rxd;

  endclocking

endinterface

