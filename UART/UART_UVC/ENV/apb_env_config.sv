////////////////////////////////////////////////
// File:          apb_env_config.sv
// Version:       v1
// Developer:     Mayank
// Project Name:  APB3 Protocol
// Discription:   APB environment config file 
/////////////////////////////////////////////////

//
// Class Description:
//
//
`ifndef APB_ENV_CONFIG
`define APB_ENV_CONFIG

class apb_env_config extends uvm_object;

   `uvm_object_utils(apb_env_config);
   //------------------------------------------
   // Data Members 
   //------------------------------------------  

   //To enable or disable the coverage
   //
   bit coverage = 1'b1;

   //------------------------------------------
   // Methods
   //------------------------------------------

//Various Agents
//  bit has_apb_agent=1;
  bit has_uvc=1;

//to set Score boaed conected to score board weusing has_sb .
  bit has_scoreboard=1; 

//to set checker.
//  bit has_apb_checker=0;
  bit has_uart_checker=0; 

//dynamic array Configuration handles for the sub_components.

//Set the noumber of DUT.
  int no_uvc=2;
//new counstructore declaration.
  function new(string name="apb_env_config");
    super.new(name);

  endfunction 

endclass : apb_env_config
`endif //APB_ENV_CONFIG
