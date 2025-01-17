/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  NAME      :- Pradip Prajapati
//  FILE_NAME :- ahb_mas_trans.sv
//  EDITED_BY :- Rajvi Padaria
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

class sram_transaction extends uvm_sequence_item;
  
  `uvm_object_utils(sram_transaction)
 
  bit[9:0]  SRAMADATA;
  bit[31:0] SRAMWDATA;
  bit[31:0] SRAMRDATA;
  bit       SRAMWREN;

  function new(string name = "sram_transaction");
    super.new(name);
  endfunction

endclass
