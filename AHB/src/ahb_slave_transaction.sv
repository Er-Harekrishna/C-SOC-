/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  NAME      :- Pradip Prajapati
//  FILE_NAME :- ahb_slv_trans.svh
//  EDITED_BY :- Rajvi Padaria
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

class ahb_slv_trans extends ahb_base_trans;
   
  //slave output signals
   
  rand hresp_enum             hresp_type;
  rand bit                    HREADYOUT;
  bit [(`DATA_WIDTH-1):0]     HWDATA;
  bit [(`DATA_WIDTH-1):0]     HRDATA;
  htrans_enum                 htrans_type;

  rand int                    wait_cycles;
  rand int                    wait_delay;

  rand bit                    x_invalid_signal;
  /** CALLBACK VARIABLE*/
  rand bit                    error_cycle;

  constraint eror_cycle{soft error_cycle==0;}
  constraint x_invalid_signall{soft x_invalid_signal==0;}
   
  //factory registration
  
  `uvm_object_param_utils_begin(ahb_slv_trans)
      
    `uvm_field_int (HWDATA,UVM_ALL_ON)
    `uvm_field_int (HRDATA,UVM_ALL_ON)
    `uvm_field_enum(hresp_enum,hresp_type,UVM_ALL_ON)
    `uvm_field_enum(htrans_enum,htrans_type,UVM_ALL_ON)
    `uvm_field_int (HREADYOUT,UVM_ALL_ON)
    
  `uvm_object_utils_end

  extern function void print();
  extern function new(string name="ahb_trans");
 
endclass : ahb_slv_trans

//new method

function ahb_slv_trans::new(string name="ahb_trans");

  super.new(name);

endfunction : new

//print method

function void ahb_slv_trans::print();

  $display("------------------------------------------------------------------");
  $display("NAME           TYPE        SUB-TYPE     SIZE          VALUE");
  $display("------------------------------------------------------------------");      
  $display("HWRITE       integral      hex           1          %h",HWRITE );
  $display("HADDR        integral      hex          %0d         %h",`ADDR_WIDTH,HADDR );
  $display("HWDATA       integral      hex          %0d         %h",`DATA_WIDTH,HWDATA );
  $display("hburst_type  hburst_enum   enum          3          %p",hburst_type);
  $display("hsize_type   hsize_enum    enum          3          %p",hsize_type);
  $display("htrans_type  htrans_enum   enum          1          %p",htrans_type);
  $display("HRDATA       integral      hex          %h          %0h",`DATA_WIDTH,HRDATA );
  $display("hresp_type   hresp_enum    enum          1          %p",hresp_type);
  $display("HREADYOUT    integral      hex           1          %h",HREADYOUT );
  $display("-------------------------------------------------------------------");
 
endfunction : print

