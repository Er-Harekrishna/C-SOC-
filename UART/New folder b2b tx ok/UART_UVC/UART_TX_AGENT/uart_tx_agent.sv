
/////////////////////////////////////////////////////////////////////////
// Company        : SCALEDGE 
// Engineer       : SIDDHARTH 
// Create Date    : 10-10-2023
// File Name   	  : uart_agent.sv
// Class Name 	  : uart_agent
// Project Name	  : UART_UVC 
// Description	  : 
//////////////////////////////////////////////////////////////////////////

class uart_tx_agent extends uvm_agent;

    //UVM factory registration
    `uvm_component_utils(uart_tx_agent)
    uart_reg_config  reg_cfg_h;   

   //uvm analysis port
    uvm_analysis_port#(uart_seq_item) an_port;

    //new constructor declaration
    function new(string name= "uagent_h",uvm_component parent);
        super.new(name,parent);
    endfunction

    //interface handle
    virtual uart_interface   vif;
     uart_driver              drv;
    uart_sequencer           seqr;
    uart_tx_monitor          tx_mon;
    uart_agent_config agcfg;

///////////////////////////////////////////////////////////////////////////////////////////////////
//  Function Build phase
////////////////////////////////////////////////////////////////////////////////////////////////////
    function void build_phase(uvm_phase phase);
    `uvm_info(get_name(),"Starting of Build Phase",UVM_DEBUG)
        super.build_phase(phase);
        //creating analysis port
        an_port = new("an_port",this);
       
       if(!uvm_config_db#(uart_agent_config)::get(this,"","agcfg",agcfg))
           `uvm_fatal(get_full_name()," not getting agent config class ");
 

        if(agcfg.is_master == MASTER)begin
        // getting the uart interface from top
          if(!uvm_config_db #(virtual uart_interface)::get(this,"","mas_vif",vif))
              `uvm_fatal(get_name(),"Interface Configuration is Faild !!!!");
	end

        if(agcfg.is_master == SLAVE)begin
        // getting the uart interface from top
          if(!uvm_config_db #(virtual uart_interface)::get(this,"","slv_vif",vif))
              `uvm_fatal(get_name(),"Interface Configuration is Faild !!!!");
	end
      
             drv = uart_driver::type_id::create("drv",this);
             seqr = uart_sequencer::type_id::create("seqr",this);
             tx_mon = uart_tx_monitor::type_id::create("tx_mon",this);
      `uvm_info(get_name(),"Ending of Build Phase",UVM_DEBUG)
  endfunction:build_phase

///////////////////////////////////////////////////////////////////////////////////////////////////
//  Function Connect phase
///////////////////////////////////////////////////////////////////////////////////////////////////
  
 function void connect_phase(uvm_phase phase);
    `uvm_info(get_name(),"Starting of Connect Phase",UVM_DEBUG)
         tx_mon.uif = vif;
         drv.seq_item_port.connect(seqr.seq_item_export);
         drv.uif = vif;
         seqr.get_port.connect(tx_mon.get_imp);
         tx_mon.item_collected_port.connect(an_port);

  endfunction:connect_phase

endclass:uart_tx_agent


    
            




