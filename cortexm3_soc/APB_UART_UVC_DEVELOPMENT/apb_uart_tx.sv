`define ADDR_WIDTH 12
//`define ADDR_WIDTH $clog2(TB_MEM_DEPTH)
`define DATA_WIDTH 32
`define RBR  3'h0  //RECIEVER BUFFER 
`define THR  3'h0  //TRANSMITTER HOLDING REGISTER
`define DLL  3'h0  //DIVISOR LATCH(LSB)
`define IER  3'h1  //INTERUUPT ENABLE REGISTER
`define DLM  3'h1  //DIVISOR LATCH(LSB)
`define IIR  3'h2  //INTERUPT IDENTIFICATION REGISTER
`define FCR  3'h2  //FIFO CONTROL REGISTER
`define LCR  3'h3  //LINE CONTROL REGISTER
`define MCR  3'h4  //MODEM CONTROL REGISTER
`define LSR  3'h5  //LINE STATUS REGISTER
`define MSR  3'h6  //MODEM STATUS REGISTER
`define SCR  3'h7  //SCRATCH REGISTER

class apb_uart_tx extends uvm_sequence_item;   
  rand bit [`ADDR_WIDTH-1:0] paddr;
  rand bit pwrite;
  rand bit [`DATA_WIDTH-1:0] pwdata;
  bit pselx;
  bit penable;
  bit pslverr;
  bit pready;
  bit prdata;
  bit preset;
  rand logic rx;

  function new(string name=" ");
  super.new(name);
  endfunction
  `uvm_object_utils_begin(apb_uart_tx)
  `uvm_field_int(paddr,UVM_ALL_ON);
  `uvm_field_int(pwrite,UVM_ALL_ON);
  `uvm_field_int(pwdata,UVM_ALL_ON);
  `uvm_field_int(pselx,UVM_ALL_ON);
  `uvm_field_int(penable,UVM_ALL_ON);
  `uvm_field_int(rx,UVM_ALL_ON);
  `uvm_object_utils_end

  constraint paddr_c{
  paddr>=0;
  soft paddr<=255;
  }
  constraint rx_c{
  rx inside {[0:1]};
  }

  endclass

