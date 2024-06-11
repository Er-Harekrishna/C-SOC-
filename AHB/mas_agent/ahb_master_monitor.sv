/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  NAME      :- Pradip Prajapati
//  FILE_NAME :- AHB_master_monitor.sv
//  EDITED_BY :- Pradip Prajapati
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

`ifndef AHB_MASTER_MONITOR
`define AHB_MASTER_MONITOR

`define MAS_MON_CB mas_vif.ahb_mas_mon_cb

class ahb_mas_mon extends uvm_monitor;

  //factory registration
  `uvm_component_param_utils(ahb_mas_mon)

  //analysis port declration
  uvm_analysis_port #(ahb_mas_trans) mas_ap_mon;
  uvm_analysis_port #(ahb_mas_trans) mas_ap_ch;
  uvm_analysis_port #(ahb_mas_trans) mas_mon_cc;

  //virtual interface
  virtual ahb_mas_inf mas_vif;

  bit lock;
 
  ahb_mas_trans trans_h;

  extern function new(string name="ahb_mas_mon",uvm_component parent=null);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
  extern task addr_phase();
  extern task data_phase();
  extern task reset();
  
endclass : ahb_mas_mon

//*****************************************************************************
//methods
//*****************************************************************************

//new function

function ahb_mas_mon::new(string name="ahb_mas_mon",uvm_component parent=null);

  super.new(name,parent);
  mas_ap_mon = new("mas_ap_mon",this);
  mas_ap_ch  = new("mas_ap_ch",this);
  mas_mon_cc  = new("mas_mon_cc",this);

endfunction : new

//build phase

function void ahb_mas_mon::build_phase(uvm_phase phase);

  trans_h = ahb_mas_trans::type_id::create("trans_h");

endfunction : build_phase

//run_phase

task ahb_mas_mon::run_phase(uvm_phase phase);

  forever begin

    fork

      forever begin
     
        @(`MAS_MON_CB);

        fork

          addr_phase();
          data_phase();
       
        join_any

      end

      begin wait(!mas_vif.hresetn); end

    join_any

    disable fork;

    if(!mas_vif.hresetn)

      reset();

  end

endtask:run_phase

//reset

task ahb_mas_mon::reset();

  `uvm_info("RESET","THIS IS MASTER MONITOR RESET",UVM_MEDIUM)
  @(posedge mas_vif.hresetn);
  @(`MAS_MON_CB);
  @(`MAS_MON_CB);

endtask : reset

//addr_phase

task ahb_mas_mon::addr_phase();
 	
  ahb_mas_trans chk_req;
 
  if(`MAS_MON_CB.HREADY && `MAS_MON_CB.HSEL && mas_vif.hresetn) begin
  //sampling the address phase
  //`uvm_info("MASTER MONITOR","INSIDE ADDR PHASE OF MAS MON",UVM_MEDIUM)
  trans_h.HADDR       = `MAS_MON_CB.HADDR;
  trans_h.HWRITE      = `MAS_MON_CB.HWRITE;
  trans_h.hsize_type  = hsize_enum'(`MAS_MON_CB.HSIZE);
  trans_h.hburst_type = hburst_enum'(`MAS_MON_CB.HBURST);
  trans_h.htrans_type = {htrans_enum'(`MAS_MON_CB.HTRANS)};
  trans_h.HREADY      = `MAS_MON_CB.HREADY;

  lock = 1;
  
  //`uvm_info("MASTER MONITOR","THIS IS MONITOR ADDR PHASE SENDING TRANSECTION",UVM_MEDIUM)
  //trans_h.print();
  //$cast(chk_req,trans_h.clone());
  //mas_ap_ch.write(chk_req);
  if(trans_h.htrans_type[0]!=IDLE) begin
  `uvm_info("MASTER MONITOR","THIS IS MONITOR ADDR_PHASE SENDING TRANSECTION",UVM_MEDIUM)
  trans_h.print();
  end

  end
     
endtask :addr_phase

//data_phase

task ahb_mas_mon::data_phase();
   
  ahb_mas_trans sb_req,cov_req;

  if(lock) begin
   
  @(`MAS_MON_CB);

  if(`MAS_MON_CB.HREADY && mas_vif.hresetn) begin

  //check if HTRANS is NONSEQ or SEQ  
  //`uvm_info("MASTER MONITOR","INSIDE DATA PHASE OF MAS MON",UVM_MEDIUM)
              
  trans_h.HWDATA = '{`MAS_MON_CB.HWDATA};
  trans_h.HRDATA = `MAS_MON_CB.HRDATA;
  trans_h.hresp_type  = hresp_enum'(`MAS_MON_CB.HRESP);

  lock = 0;
 
  //`uvm_info("MASTER MONITOR","THIS IS MONITOR DATA_PHASE SENDING TRANSECTION",UVM_MEDIUM)
  //trans_h.print();

  $cast(cov_req,trans_h.clone());
  if(`MAS_MON_CB.HREADY) begin
    if(trans_h.htrans_type[0]!=IDLE) begin
    `uvm_info("MASTER MONITOR","THIS IS MONITOR DATA_PHASE SENDING TRANSECTION",UVM_MEDIUM)
    trans_h.print();
    end
    $cast(sb_req,trans_h.clone());
    mas_ap_mon.write(sb_req);
  end
  mas_mon_cc.write(cov_req);
  end
  end
  
endtask :data_phase

`endif

