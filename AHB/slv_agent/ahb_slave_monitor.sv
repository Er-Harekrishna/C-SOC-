/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  NAME      :- Pradip Prajapati
//  FILE_NAME :- AHB_mas_monitor.sv
//  EDITED_BY :- Karan Patadiya(27-10-2023)
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

`ifndef AHB_SLAVE_MONITOR
`define AHB_SLAVE_MONITOR

`define SLV_MON_CB slv_vif.ahb_slv_mon_cb

class ahb_slv_mon extends uvm_monitor;

  //factory registration
  `uvm_component_param_utils(ahb_slv_mon)

  //analysis port declration
  uvm_analysis_port #(ahb_slv_trans) slv_ap_mon;
  uvm_analysis_port #(ahb_slv_trans) slv_mon_sb;
  uvm_analysis_port #(ahb_slv_trans) slv_mon_cc;

  //virtual interface
  virtual ahb_slv_inf slv_vif;

  //Transaction class handle
  ahb_slv_trans trans_h;

  //transaction classs queue
  ahb_slv_trans temp_queue[$];

  extern function new(string name="ahb_slv_mon",uvm_component parent=null);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
  extern task addr_phase();
  extern task data_phase();
  extern task reset();
     
endclass : ahb_slv_mon

//*****************************************************************************
//methods
//*****************************************************************************

//new function

function ahb_slv_mon::new(string name="ahb_slv_mon",uvm_component parent=null);

  super.new(name,parent);
  slv_ap_mon = new("slv_ap_mon",this);
  slv_mon_sb = new("slv_mon_sb",this);
  slv_mon_cc = new("slv_mon_cc",this);

endfunction : new

//build phase

function void ahb_slv_mon::build_phase(uvm_phase phase);
  
  trans_h=ahb_slv_trans::type_id::create("trans_h");

endfunction : build_phase

//run_phase

task ahb_slv_mon::run_phase(uvm_phase phase);
  
  forever begin

    fork
      
      forever begin
     
        @(`SLV_MON_CB);

        fork

          addr_phase();
          data_phase();
       
        join_any

      end

      begin wait(!slv_vif.hresetn); end

    join_any

    disable fork;

    if(!slv_vif.hresetn)

      reset();

  end

endtask : run_phase

//reset

task ahb_slv_mon::reset();

  `uvm_info("SLAVE MONITOR","THIS IS INSIDE SLAVE MONITOR RESET",UVM_MEDIUM)	
  @(posedge slv_vif.hresetn);
  disable addr_phase;
  disable data_phase;
  @(`SLV_MON_CB);
  @(`SLV_MON_CB);

endtask : reset

//addr_phase

task ahb_slv_mon::addr_phase();
  
  ahb_slv_trans req;
     
  if(`SLV_MON_CB.HREADY_IN && slv_vif.hresetn) begin
    
    //`uvm_info("SLAVE MONITOR","THIS IS INSIDE ADDR PHASE OF SLAVE MONITOR",UVM_MEDIUM)
    
    trans_h.HWRITE      = `SLV_MON_CB.HWRITE;
    trans_h.HADDR       = `SLV_MON_CB.HADDR;
    trans_h.hburst_type = hburst_enum'(`SLV_MON_CB.HBURST);
    trans_h.hsize_type  = hsize_enum'(`SLV_MON_CB.HSIZE);
    trans_h.htrans_type = htrans_enum'(`SLV_MON_CB.HTRANS); 
    
    if(trans_h.htrans_type!=IDLE) begin 
    `uvm_info("SLAVE MONITOR","THIS IS SLAVE SENDING TRANSECTION TO SEQUENCE",UVM_MEDIUM);
    trans_h.print();
    end
    
    $cast(req,trans_h.clone());
    slv_ap_mon.write(req);    
    
  end

endtask : addr_phase

//Data phase method.

task ahb_slv_mon::data_phase();
  
  ahb_slv_trans req=new();
  ahb_slv_trans req1;
  
  @(`SLV_MON_CB);

  req.HWRITE      = `SLV_MON_CB.HWRITE;
  req.HADDR       = `SLV_MON_CB.HADDR;
  req.hburst_type = hburst_enum'(`SLV_MON_CB.HBURST);
  req.hsize_type  = hsize_enum'(`SLV_MON_CB.HSIZE);
  req.htrans_type = htrans_enum'(`SLV_MON_CB.HTRANS);
  req.HRDATA      = `SLV_MON_CB.HRDATA;
  req.HWDATA      = `SLV_MON_CB.HWDATA;
  req.hresp_type  = hresp_enum'(`SLV_MON_CB.HRESP);
  req.HREADYOUT   = `SLV_MON_CB.HREADYOUT;
  slv_mon_cc.write(req);
     
  if(`SLV_MON_CB.HREADY_IN && slv_vif.hresetn) begin
  
    //`uvm_info("SLAVE MONITOR","THIS IS INSIDE DATA PHASE OF SLAVE MONITOR",UVM_MEDIUM)
    
    trans_h.HWDATA      = `SLV_MON_CB.HWDATA;
    trans_h.HRDATA      = `SLV_MON_CB.HRDATA;
    trans_h.hresp_type  = hresp_enum'(`SLV_MON_CB.HRESP);
   
    if(trans_h.htrans_type!=IDLE) begin 
    `uvm_info("SLAVE MONITOR","THIS IS SLAVE SENDING TRANSECTION TO SCOREBOARD AND SEQUENCE",UVM_MEDIUM);
    trans_h.print();
    end
    $cast(req1,trans_h.clone());

    slv_mon_sb.write(req1);
    
  end
  
endtask : data_phase

`endif
