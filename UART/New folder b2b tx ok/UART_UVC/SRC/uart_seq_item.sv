/////////////////////////////////////////////////////////////////////////
// Company        : SCALEDGE 
// Engineer       : SIDDHARTH 
// Create Date    : 10-10-202i3
// File Name   	  : uart_seq_iem.sv
// Class Name 	  : uart_seq_item
// Project Name	  : UART_UVC 
// Description	  : 
//////////////////////////////////////////////////////////////////////////

//--------------------------------------------------------------------------
// class  : uart_seq_item 
//--------------------------------------------------------------------------

class uart_seq_item extends uvm_sequence_item;


     // tx and rx_shifter is collect data from monitor and transmited in scoreboard
   rand bit [`THR_SIZE-1:0] parity_data;
   bit START,STOP,PARITY_ERROR;
   bit TX_START,TX_STOP,RX_START,RX_STOP;
   write_read  kind_e;
   bit wr;
   static bit tx_shift;
   bit rx_shift;
   static bit tx_valid;
   bit [`THR_SIZE-1:0] tx_shifter;
   rand bit [`THR_SIZE-1:0] tx_fifo;
   bit [`RBR_SIZE-1:0] rx_shifter;
   bit tx_gated_clk;
   bit rx_gated_clk;
   state RX_STATE;
   static state TX_STATE;
   bit CTS,RTS;
   static bit [`NO_OF_WR_TRANS-1:0]seq_count;  
`uvm_object_utils_begin(uart_seq_item)
  `uvm_field_enum(write_read,kind_e,UVM_ALL_ON)
  `uvm_field_enum(state,TX_STATE,UVM_ALL_ON)
  `uvm_field_enum(state,RX_STATE,UVM_ALL_ON)
  `uvm_field_int(tx_shifter,UVM_ALL_ON|UVM_DEC)
  `uvm_field_int(tx_fifo,UVM_ALL_ON|UVM_DEC)
  `uvm_field_int(tx_fifo,UVM_ALL_ON|UVM_BIN)
  `uvm_field_int(parity_data,UVM_ALL_ON|UVM_DEC)
  `uvm_field_int(rx_shifter,UVM_ALL_ON|UVM_BIN)
  `uvm_field_int(rx_shifter,UVM_ALL_ON|UVM_DEC)
  `uvm_field_int(TX_START,UVM_ALL_ON|UVM_DEC)
  `uvm_field_int(TX_STOP,UVM_ALL_ON|UVM_DEC)
  `uvm_field_int(RX_START,UVM_ALL_ON|UVM_DEC)
  `uvm_field_int(tx_shift,UVM_ALL_ON|UVM_DEC)
  `uvm_field_int(rx_shift,UVM_ALL_ON|UVM_DEC)
  `uvm_field_int(tx_valid,UVM_ALL_ON|UVM_DEC)
  `uvm_field_int(tx_gated_clk,UVM_ALL_ON|UVM_DEC)
  `uvm_field_int(rx_gated_clk,UVM_ALL_ON|UVM_DEC)
`uvm_object_utils_end

    constraint parity { parity_data == tx_fifo;}

  function new(string name = "uart_config");
    super.new(name);
  endfunction //new 
  endclass:uart_seq_item
