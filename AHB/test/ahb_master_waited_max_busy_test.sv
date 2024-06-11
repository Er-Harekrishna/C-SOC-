/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  NAME      :- Pradip Prajapati
//  FILE_NAME :- ahb_master_waited_max_busy_test.sv
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Abstract:
 * This file creates test 'ahb_master_waited_max_busy_test', which is extended 
 * from the ahb_base_test class.
 * 
 * In the build phase of the test we will set the necessary test related
 * information:
 *  - Configure the ahb_master_waited_max_busy_sequence as the default sequence for
 *    the main phase of the Master Sequencer
 *  - Configure the ahb_slave_mem_response_max_wait_sequence as the default sequence 
 *    for the run phase of the Slave Sequencer
 *
 */

`ifndef AHB_MASTER_WAITED_MAX_BUSY_TEST
`define AHB_MASTER_WAITED_MAX_BUSY_TEST

class ahb_master_waited_max_busy_test extends ahb_base_test;

 /** Factory registration */
 `uvm_component_utils(ahb_master_waited_max_busy_test)
 
 /** class constructor */
 extern function new(string name="ahb_master_waited_max_busy_test",uvm_component parent);

 /** build phase*/
 extern function void build_phase(uvm_phase phase);
 
endclass : ahb_master_waited_max_busy_test

//*****************************************************************************
//methods
//*****************************************************************************

/** class constructor */
function ahb_master_waited_max_busy_test::new(string name="ahb_master_waited_max_busy_test",uvm_component parent);   
  super.new(name,parent);
endfunction : new

/** build_phase */
function void ahb_master_waited_max_busy_test::build_phase(uvm_phase phase);
  
  `uvm_info ("build_phase", "Entered...",UVM_MEDIUM)

  super.build_phase(phase);

  /** Apply the ahb_master_waited_max_busy_sequence to the master sequencer */
  uvm_config_db#(uvm_object_wrapper)::set(this,"env_h.ahb_uvc_h*.mas_agent_h*.mas_seqr_h.main_phase","default_sequence",ahb_master_waited_max_busy_sequence::type_id::get());
  
  /** Apply the ahb_slave_mem_response_max_wait_sequence to the slave sequencer */
  uvm_config_db#(uvm_object_wrapper)::set(this,"env_h.ahb_uvc_h*.slv_agent_h*.slv_seqr_h.run_phase","default_sequence",ahb_slave_mem_response_max_wait_sequence::type_id::get());

  /** Set the sequence 'length' to generate 5 directed transactions */
  uvm_config_db#(int unsigned)::set(this, "ahb_master_waited_max_busy_sequence", "sequence_length", 5);
  
  `uvm_info ("build_phase", "Exiting...",UVM_MEDIUM)
 
endfunction : build_phase 

`endif //AHB_MASTER_WAITED_MAX_BUSY_TEST
