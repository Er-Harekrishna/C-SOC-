
/////////////////////////////////////////////////////////////////////////
// Company        : SCALEDGE 
// Engineer       : SIDDHARTH 
// Create Date    : 10-10-2023
// File Name   	  : uart_agent_cfg.sv
// Class Name 	  : uart_agent_cfg
// Project Name	  : UART_UVC 
// Description	  : 
//////////////////////////////////////////////////////////////////////////
typedef enum bit[1:0]{TX_AGENT,RX_AGENT,BOTH_AGENT}agent;
typedef enum bit[1:0] {MASTER,SLAVE} mas_slv;
//--------------------------------------------------------------------------
// class  : uart_agent_cfg 
//--------------------------------------------------------------------------
class uart_agent_config extends uvm_object;

//UVM Fectory registretion.
//uvm_sequencer is Object that's why we are using `uvm_object_utils macro.
  `uvm_object_utils(uart_agent_config)

//new counstructore declaration.
  function new(string name="UART_AGENT_CFG");
    super.new(name);
  endfunction :new 

//To set Agent to be active or passive agent we using is_active here.
  agent is_agent = RX_AGENT;
  mas_slv is_master;
  int no_of_agent = 2;
  int no_master,no_of_slave;

//base on delay_cycle we can delay ready or pready signal do driver.  
  bit [4:0]delay_cycle=1;
  


endclass :uart_agent_config

