

/////////////////////////////////////////////////////////////////////////
// Company        : SCALEDGE 
// Engineer       : SIDDHARTH 
// Create Date    : 10-10-2023
// File Name   	  : uart_uvc.sv
// Class Name 	  : uart_uvc
// Project Name	  : UART_UVC 
// Description	  : 
//////////////////////////////////////////////////////////////////////////

class uart_uvc_env extends uvm_agent ;

    // factory register
    `uvm_component_utils(uart_uvc_env);

    // uart_uvc constructor
    function new(string name = "apb_master_uvc",uvm_component parent);
          super.new(name,parent);
   endfunction : new

    // agent_config and agent handles
    uart_agent_config agcfg;
    uart_tx_agent     tx_agent_h;
    uart_rx_agent     rx_agent_h;
   // apb_uart_scoreboard  apb_uart_sb; 

    function void build_phase(uvm_phase phase);
        `uvm_info(get_name(),"Starting of Build Phase",UVM_HIGH)
        super.build_phase(phase);

//	`uvm_info(get_name(),$sformatf(" size of agcfg array =%0d",agcfg.size()),UVM_LOW);

      //foreach (agcfg[i])
          
        //agcfg[$sformatf("%0d",i)] = new();
	// agcg.is_agent = BOTH_AGENT;
         if(!uvm_config_db#(uart_agent_config)::get(this,"","agcfg",agcfg))
           `uvm_fatal(get_full_name(),"uart_uvc_env not getting agent config class ");

        // agent config get from test
	
	if(agcfg.is_agent == TX_AGENT)begin
            tx_agent_h = uart_tx_agent::type_id::create("tx_agent_h",this);
	    uvm_config_db#(uart_agent_config)::set(this,"*","agcfg",agcfg) ;
        end
       
        if(agcfg.is_agent == RX_AGENT)begin
            rx_agent_h = uart_rx_agent::type_id::create("rx_agent_h",this);
	 uvm_config_db#(uart_agent_config)::set(this,"*","agcfg",agcfg) ;
        end


        if(agcfg.is_agent == BOTH_AGENT)begin
            tx_agent_h = uart_tx_agent::type_id::create("tx_agent_h",this);
            rx_agent_h = uart_rx_agent::type_id::create("rx_agent_h",this);
	  uvm_config_db#(uart_agent_config)::set(this,"*","agcfg",agcfg) ;
        end


    endfunction:build_phase

    

endclass:uart_uvc_env






