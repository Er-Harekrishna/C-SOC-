/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  NAME      :- Pradip Prajapati
//  FILE_NAME :- ahb_mas_trans.svh
//  EDITED_BY :- Rajvi Padaria
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

class ahb_base_trans extends uvm_sequence_item;

   //master output signals
  bit [(`ADDR_WIDTH-1):0]     HADDR;
  bit                         HWRITE;
   
  //enum for HBURST AND HSIZE types
  hburst_enum                 hburst_type;
  hsize_enum                  hsize_type;

  //slave output signals
  bit [(`DATA_WIDTH-1):0]     HRDATA;
  bit                         addr_phase; 

  //factory registration
  `uvm_object_param_utils_begin(ahb_base_trans)
      
    `uvm_field_int(HADDR, UVM_ALL_ON)
    `uvm_field_int(HWRITE,UVM_ALL_ON)
    `uvm_field_int(HRDATA,UVM_ALL_ON)
    `uvm_field_enum(hburst_enum,hburst_type,UVM_ALL_ON)
    `uvm_field_enum(hsize_enum,hsize_type,UVM_ALL_ON)
  
  `uvm_object_utils_end

  //constructor

  function new(string name="ahb_base_trans");

    super.new(name);

  endfunction : new

endclass : ahb_base_trans
