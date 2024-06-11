////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  NAME      :- Pradip Prajapati
//  FILE_NAME :- ahb_defines.svh
//  EDITED_BY :- Rajvi Padaria
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////

typedef enum bit                       {SLAVE,MASTER}                                        uvm_master_slave_enum;
typedef enum bit                       {ENABLE,DISABLE}                                      uvm_checker_enable_disable_enum;
typedef enum bit [(`HBURST_WIDTH-1):0] {SINGLE,INCR,WRAP4,INCR4,WRAP8,INCR8,WRAP16,INCR16}   hburst_enum;
typedef enum bit [2:0]                 {BYTE,HALFWORD,WORD,DOUBLEWORD,WORDLINE_4,WORDLINE_8,WORDLINE_16,WORDLINE_32} hsize_enum;
typedef enum bit                       {OKAY,ERROR}                                          hresp_enum;
typedef enum bit [1:0]                 {IDLE,BUSY,NONSEQ,SEQ}                                htrans_enum;
