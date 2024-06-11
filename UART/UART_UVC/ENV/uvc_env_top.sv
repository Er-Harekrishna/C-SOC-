///////////////////////////////////////////////
// File:          uvc_env_top.sv
// Version:       v1
// Developer:     Mayank
// Project Name:  APB_UART Protocol
// Discription:   APB environment file 
/////////////////////////////////////////////////

//
// Class Description:APB evn
//
//

class uvc_env_top extends uvm_env;
   // UVM Factory Registration Macro
   `uvm_component_utils(uvc_env_top);

   //------------------------------------------
   // Master and Salve UVC handles
   //------------------------------------------ 
   //apb_master_uvc apb_muvc_h;
   uart_uvc_env      uvc_h[];
   uart_scoreboard  uart_sb;
   uart_agent_config agcfg[];
   uart_reg_config uartregcfg[];
   //Instance of the Envoronment configuaration class
   //apb_env_config env_cfg;    //main env for configuration ofnenv variables
   

// Standard UVM Methods
function new(string name = "uvc_env_top",uvm_component parent);
   super.new(name,parent);
endfunction : new

//build_phase
function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_name(),"INSIDE BUILD_PHASE",UVM_DEBUG);
     agcfg = new[2];
     foreach (agcfg[i]) begin 
     agcfg[i] = uart_agent_config::type_id::create($sformatf("agcfg[%0d]",i),this);               //uart agent configure handle creation
     end
     agcfg[0].is_agent = RX_AGENT;
     agcfg[0].is_master = SLAVE;
     agcfg[1].is_master = SLAVE;
     agcfg[1].is_agent = RX_AGENT;
     //env_cfg = apb_env_config::type_id::create("env_cfg",this);               //uart agent configure handle creation

   // if(!uvm_config_db#(apb_env_config)::get(this,"","env_cfg",env_cfg))          
    //`uvm_error(get_full_name(),"ENABLE TO GET ENV_CONFIG");

    //Creating the master agent wrapper(master_uvc)      
    uartregcfg=new[2];
    foreach(uartregcfg[i])
      begin
        uartregcfg[i] = uart_reg_config::type_id::create($sformatf("uartregcfg[%0d]",i),this);
      end
    //apb_muvc_h = apb_master_uvc::type_id::create("apb_muvc_h",this);         //apb master uvc handle creation
    uart_sb = uart_scoreboard::type_id::create("uart_sb",this);  //apb_uart scoreboard handle creation

    //if(env_cfg.has_uvc == 1)begin
      //    uvc_h=new[env_cfg.no_uvc];
	//  `uvm_info(get_name(),$sformatf("here no of uvc is=%0d  & size of uvc array =%0d",env_cfg.no_uvc,uvc_h.size()),UVM_LOW);

      foreach(uvc_h[i])
        begin
            uvc_h[i] = uart_uvc_env ::type_id::create($sformatf("uvc_h[%0d]",i),this);
	 	    
	end
  
      foreach(uvc_h[i]) begin
          // uvm_config_db #(uart_agent_config) :: set(null,$sformatf("uvm_test_top.env_hh.uvc_h[i]",i),"agcfg",agcfg[i]);
	   if(i ==0)
	      uvm_config_db#(uart_agent_config)::set(this,$sformatf("uvc_h[%0d]",i),"agcfg",agcfg[i]);
	      else
	      uvm_config_db#(uart_agent_config)::set(this,$sformatf("uvc_h[%0d]",i),"agcfg",agcfg[i]);

	  //`uvm_info(get_name(),$sformatf(" agcfg[%0d] %s ",i,agcfg[i].is_agent.name()),UVM_LOW);
      end
       
    end
endfunction

//connect_phase
function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    foreach(uvc_h[i])
    begin
   // uvc_h[i].tx_agent_h[i].an_port.connect(uart_sb.mmon_imp);          //connection b/w analysis port of APB_MONITOR and imp port of SCOREBOARD
    
    if(agcfg[i].is_master == MASTER)begin     //if TX_AGENT is created(only write operation from APB to UART),port connection
       
       if(agcfg[i].is_agent == TX_AGENT)begin
       uvc_h[i].tx_agent_h.an_port.connect(uart_sb.mmon_imp);
       end

       if(agcfg[i].is_agent == RX_AGENT)begin                         //if RX_AGENT is created(only read operation from APB to UART),port connection
       uvc_h[i].rx_agent_h.an_port.connect(uart_sb.mmon_imp);
    end

    if(agcfg[i].is_agent == BOTH_AGENT)begin                       //TX and RX both AGENT created,then connection

       uvc_h[i].tx_agent_h.an_port.connect(uart_sb.mmon_imp);
       uvc_h[i].rx_agent_h.an_port.connect(uart_sb.mmon_imp);
    end
    end
   
   if(agcfg[i].is_master == SLAVE)begin     //if TX_AGENT is created(only write operation from APB to UART),port connection
       
       if(agcfg[i].is_agent == TX_AGENT)begin
       uvc_h[i].tx_agent_h.an_port.connect(uart_sb.umon_imp);
       end

       if(agcfg[i].is_agent == RX_AGENT)begin                         //if RX_AGENT is created(only read operation from APB to UART),port connection
       uvc_h[i].rx_agent_h.an_port.connect(uart_sb.umon_imp);
    end

    if(agcfg[i].is_agent == BOTH_AGENT)begin                       //TX and RX both AGENT created,then connection

       uvc_h[i].tx_agent_h.an_port.connect(uart_sb.umon_imp);
       uvc_h[i].rx_agent_h.an_port.connect(uart_sb.umon_imp);
    end
    end // 


    end // foreach

    endfunction : connect_phase

endclass : uvc_env_top

