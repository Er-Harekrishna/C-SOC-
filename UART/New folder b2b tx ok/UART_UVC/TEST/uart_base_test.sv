///////////////////////////////////////////////
// File:          uart_base_test.sv
// Version:       v1
// Developer:     Jaydeep
// Project Name:  APB_UART Protocol
// Discription:   APB_TO_UART base test file 
/////////////////////////////////////////////////
//
// Class Description:This class contains base test 
//
//


class uart_base_test extends uvm_test;
   // UVM Factory Registration Macro
   //
   `uvm_component_utils(uart_base_test);
    uart_seq_item uart_trans; 
   //Environment class instance
   uvc_env_top env_hh;
   //uart_uvc_env uvc_1;
   //uart_uvc_env uvc_2;
  // apb_env_config env_cfg; 
   uart_agent_config agcfg[];
   virtual uart_interface uinf_master;
   virtual uart_interface uinf_slave;
   
   //Environment class instance
   //
  // apb_env env_hhh;

   //Instance of the slave sequencer   
      //Instance of the slave base sequence
   //   apb_slv_base_seq sseq_h;

   //------------------------------------------
   // Methods
   //------------------------------------------

   // Standard UVM Methods:  
   function new(string name = "uart_base_test",uvm_component parent);
      super.new(name,parent);
   endfunction : new

   //build_phase
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      `uvm_info(get_type_name(),"INSIDE BUILD_PHASE",UVM_DEBUG); 
      //env_cfg = apb_env_config::type_id::create("env_cfg");
       env_hh = uvc_env_top::type_id::create("env_hh",this);
       //uvc_1 = uart_uvc_env::type_id::create("uvc_1",this);
       //uvc_2 = uart_uvc_env::type_id::create("uvc_2",this);
      uart_trans=new();
      //agcfg = uart_agent_config::type_id::create("agcfg");
    // uvm_config_db#(apb_env_config)::set(this,"*","env_cfg",env_cfg);
    // uvm_config_db#(uart_agent_config)::set(this,"*","uart_agent_cfg",agcfg); 
     
     uvm_config_db#(virtual uart_interface)::get(this,"*","vif",uinf_master);
     uvm_config_db#(virtual uart_interface)::get(this,"*","vif",uinf_slave);

     
      //Creating the Environment
     
   endfunction : build_phase

   


   //End_of_elaboration_phase
   function void end_of_elaboration_phase(uvm_phase phase);
      super.end_of_elaboration_phase(phase);
      `uvm_info(get_type_name(),"INSIDE END_OF_ELABORATION_PHASE",UVM_FULL);
      //printing testbench components      
       `uvm_info(get_name(),"[**********************************************************************************************************************]",UVM_LOW);
       print();
   endfunction : end_of_elaboration_phase

   //run_phase
   task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      `uvm_info(get_type_name(),"INSIDE RUN_PHASE",UVM_DEBUG); 
      //slave in always reactive so for all test cases this sequence must start on its sequencer and also we can make it as the default sequence
      phase.drop_objection(this);
      //phase.phase_done.set_drain_time(this,100ns);
   endtask : run_phase




endclass : uart_base_test

