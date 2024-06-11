`define ADDR_WIDTH 12
//`define ADDR_WIDTH $clog2(TB_MEM_DEPTH)
`define DATA_WIDTH 32
`define MEM_WIDTH 8
`define MEM_DEPTH 256
`define RBR  3'h0  //RECIEVER BUFFER REGISTER 
`define THR  3'h0  //TRANSMITTER HOLDING REGISTER
`define DLL  3'h0  //DIVISOR LATCH(LSB)
`define IER  3'h1  //INTERUUPT ENABLE REGISTER
`define DLM  3'h1  //DIVISOR LATCH(MSB)
`define IIR  3'h2  //INTERUPT IDENTIFICATION REGISTER
`define FCR  3'h2  //FIFO CONTROL REGISTER
`define LCR  3'h3  //LINE CONTROL REGISTER
`define MCR  3'h4  //MODEM CONTROL REGISTER
`define LSR  3'h5  //LINE STATUS REGISTER
`define MSR  3'h6  //MODEM STATUS REGISTER
`define SCR  3'h7  //SCRATCH REGISTER

interface apb_uart_intf(input logic pclk,input logic preset);  
//  logic pclk;
//  logic preset;
  logic pwrite;
  logic [`DATA_WIDTH-1:0]pwdata;
  logic [`ADDR_WIDTH-1:0]paddr;
  logic [`DATA_WIDTH-1:0]prdata;
  logic pselx;
  logic pslverr;
  logic penable;
  logic pready;
  logic rx_i;
  logic tx_o;
  logic event_o;
//clocking block jut get started
//clocking mast_cb@(posedge pclk);
//default input #1 output #0;
// input pclk;
// input preset;
// output paddr;
// output pwrite;
// output pwdata;
// input prdata;
// output pselx;
// input pslverr;
// output penable;
// input pready;
// output pstrb;
//endclocking
endinterface
