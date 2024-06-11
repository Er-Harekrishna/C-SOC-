/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  NAME      :- Pradip Prajapati
//  FILE_NAME :- AHB_slave_driver.sv
//  EDITED_BY :- Rajvi Padaria
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

`ifndef AHB_SLAVE_DRIVER
`define AHB_SLAVE_DRIVER

`define SLV_DRV_CB slv_vif.ahb_slv_drv_cb
`define SLV_MON_CB slv_vif.ahb_slv_mon_cb

class ahb_slv_drv extends uvm_driver #(ahb_slv_trans);

  //factory registration

  `uvm_component_param_utils(ahb_slv_drv)
  `uvm_register_cb(ahb_slv_drv,slv_drv_callback)

  //virtual interface handle

  virtual ahb_slv_inf slv_vif;
  bit rst_flag;

  extern function new(string name="ahb_slv_drv",uvm_component parent=null);
  extern task run_phase(uvm_phase phase);
  extern task send_to_dut();
  extern task reset();
  extern function void x_invalid_signal();
  
endclass : ahb_slv_drv

//*****************************************************************************
//methods
//*****************************************************************************

//new method

function ahb_slv_drv::new(string name="ahb_slv_drv",uvm_component parent=null);

  super.new(name,parent);

endfunction : new

//run phase

task ahb_slv_drv::run_phase(uvm_phase phase);
  
  wait(!slv_vif.hresetn) 

    reset();

  forever begin

    fork 
      
      forever begin

        @(`SLV_DRV_CB);
	`uvm_info("SLAVE_DRIVER","THIS IS BEFOR GET NEXT ITEM",UVM_MEDIUM)
        seq_item_port.get_next_item(req);           
	rst_flag=1;	  
        send_to_dut();
        seq_item_port.item_done();
	rst_flag=0;

      end
          
      begin wait(!slv_vif.hresetn); end

    join_any

    disable fork;
       
    if(!slv_vif.hresetn) 

      reset();

  end

endtask : run_phase

//send_to_dut

task ahb_slv_drv::send_to_dut();

  `uvm_info("SLAVE DRIVER","THIS IS INSIDE SLAVE DRIVER", UVM_MEDIUM)
  req.print();
  if(req.x_invalid_signal)
    x_invalid_signal();

  else begin
    if(req.htrans_type==IDLE || req.htrans_type==BUSY) begin
      
    `uvm_info("SLAVE DRIVER","THIS IS INSIDE BUSY AND IDLE OKAY RESP", UVM_MEDIUM)
    `SLV_DRV_CB.HREADYOUT <= req.HREADYOUT;
    `SLV_DRV_CB.HRESP  <= hresp_enum'(OKAY);
    `SLV_DRV_CB.HRDATA <= req.HRDATA; 

    end
    
    else if(req.hresp_type) begin
      
     `uvm_info("SLAVE DRIVER","THIS IS INSIDE ERROR RESP", UVM_MEDIUM)
     `SLV_DRV_CB.HRESP     <= hresp_enum'(ERROR);
     `SLV_DRV_CB.HRDATA    <= 0;       
     `SLV_DRV_CB.HREADYOUT <= 1'b0;
     @(`SLV_DRV_CB);
     `SLV_DRV_CB.HREADYOUT <= 1'b1;
     if(req.error_cycle==1) begin
       `uvm_do_callbacks(ahb_slv_drv,slv_drv_callback,hresp_cycle_count(req)); 
       `SLV_DRV_CB.HRESP     <= req.hresp_type;
     end

    end
   
    else begin

     `uvm_info("SLAVE DRIVER","THIS IS INSIDE READ OKAY RESP", UVM_MEDIUM)
     `SLV_DRV_CB.HREADYOUT <= req.HREADYOUT;
     `SLV_DRV_CB.HRESP  <= req.hresp_type;
     `SLV_DRV_CB.HRDATA <= req.HRDATA; 

    end  

    if(!req.HREADYOUT && !`SLV_MON_CB.HRESP) begin
    
     `SLV_DRV_CB.HREADYOUT <= 0;
     repeat(req.wait_cycles) 
       @(`SLV_DRV_CB);
     `SLV_DRV_CB.HREADYOUT <= 1;

    end

    else if(`SLV_MON_CB.HRESP && `SLV_MON_CB.HTRANS==htrans_enum'(IDLE))

      `SLV_DRV_CB.HREADYOUT <= 1; 
  end
endtask : send_to_dut


function void ahb_slv_drv::x_invalid_signal();  
  //if(req.x_invalid_signal) begin 
  `SLV_DRV_CB.HREADYOUT <= 'hx;
  `SLV_DRV_CB.HRESP     <= 'hx; 
  `SLV_DRV_CB.HRDATA    <= 'bx;
  `ifdef AHB_5
  `ifdef AHB_EXCLUSIVE_TR_PROPERTY
  `SLV_DRV_CB.HEXOKAY   <= 'bx; 
  `endif
  `endif
//end

endfunction 
//reset

task ahb_slv_drv::reset();

  `uvm_info("SLAVE DRIVER","SLAVE SIDE RESET", UVM_MEDIUM)
  
  `SLV_DRV_CB.HREADYOUT <= 1'b1; slv_vif.HREADYOUT <= 1'b1;
  `SLV_DRV_CB.HRESP     <= 1'b0; slv_vif.HRESP     <= 1'b0;
  `SLV_DRV_CB.HRDATA    <= 'b0;  slv_vif.HRDATA    <= 'b0;
  `ifdef AHB_5
  `ifdef AHB_EXCLUSIVE_TR_PROPERTY
  `SLV_DRV_CB.HEXOKAY   <= 'b0;  slv_vif.HEXOKAY   <= 'b0;
  `endif
  `endif

  if(rst_flag) begin

    seq_item_port.item_done();
    rst_flag=0;

  end

  wait(slv_vif.hresetn);
  @(`SLV_DRV_CB);

endtask : reset

`endif

