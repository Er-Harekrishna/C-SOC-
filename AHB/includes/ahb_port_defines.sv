////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  NAME      :- Pradip Prajapati
//  FILE_NAME :- ahb_defines.svh
//  EDITED_BY :- Rajvi Padaria
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////

`ifndef AHB_PORT_DEFINES
`define AHB_PORT_DEFINES

`ifdef AHB_USER_DEFINES
  `include "ahb_user_defines.sv"
`else
  `define ADDR_WIDTH    32  //must not be changed
  `define DATA_WIDTH    32  //configurable
`endif

`define HBURST_WIDTH  3
`define HRESP_WIDTH   1
`define HMASTER_WIDTH 4

`ifdef AHB_5
 `ifdef AHB_STROBE_PROPERTY
  `define HBSTRB_WIDTH  4
 `endif
`endif

`define HSIZE_WIDTH   3
`define HTRANS_WIDTH  2
`define HSEL_WIDTH    1
`define HPROT_WIDTH   4

`ifdef AHB_5
 `ifdef AHB_EXCLUSIVE_TR_PROPERTY 
  `define HMASTER_WIDTH 4
 `endif
`endif

`endif
