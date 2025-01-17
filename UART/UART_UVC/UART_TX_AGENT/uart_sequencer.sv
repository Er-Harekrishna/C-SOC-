
/////////////////////////////////////////////////////////////////////////
// Company        : SCALEDGE 
// Engineer       : SIDDHARTH 
// Create Date    : 10-10-202i3
// File Name   	  : uart_sequencer.sv
// Class Name 	  : uart_sequencer
// Project Name	  : UART_UVC 
// Description	  : 
//////////////////////////////////////////////////////////////////////////


class uart_sequencer extends uvm_sequencer#(uart_seq_item);
   // UVM Factory Registration Macro
   //   
    uart_seq_item seq_item_h;
   `uvm_component_utils(uart_sequencer);

    uvm_blocking_get_port #(uart_seq_item) get_port;

   //------------------------------------------
   // Methods
   //------------------------------------------

   // Standard UVM Methods: 
   //
   function new(string name = "uart_sequencer",uvm_component parent);
      super.new(name,parent);
      //get_port = new("get_port",this);
      get_port = new("get_port",this);
      seq_item_h = new();
   endfunction : new




endclass : uart_sequencer

