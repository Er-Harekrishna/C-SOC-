/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  NAME      :- Pradip Prajapati
//  FILE_NAME :- ahb_base_test.sv
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Abstract:
 * This file creates test 'ahb_base_test', which is extended from the
 * uvm_test class.
 *
 * In the build phase of the test we will set the necessary test related
 * information:
 *  - System config for configuration whole envionment
 *  - Create environment
 *
 */

`ifndef AHB_BASE_TEST
`define AHB_BASE_TEST

class ahb_base_test extends uvm_test;

  /** factory registration */
  `uvm_component_utils(ahb_base_test)

  /** environment handle - uvc environment */
  ahb_env                           env_h;

  /** system configuration handle - for passing the system configuration */
  ahb_system_config                 sys_cfg;

  /** virtual interface */
  virtual ahb_inf vif;

  /** class constructor */
  extern function new(string name = "ahb_test", uvm_component parent = null);

  /** build phase*/
  extern function void build_phase(uvm_phase phase);

  /** end of elaboration phase */
  extern function void end_of_elaboration_phase(uvm_phase phase);

endclass : ahb_base_test

//*****************************************************************************
//methods
//*****************************************************************************

/** class constructor */
function ahb_base_test::new(string name = "ahb_test", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

/** build_phase */
function void ahb_base_test::build_phase(uvm_phase phase);

  /** Creating the configuration class for UVC */	
  sys_cfg = ahb_system_config::type_id::create("sys_cfg");

  /** Creating environment class for UVC */
  env_h   = ahb_env::type_id::create("env_h", this);

  /** From system configuration class environment related configurations are
   *  passed to the environment handle env_h from ahb_base_test. 
   */
  uvm_config_db#(ahb_env_config)::set(this, "env_h", "env_cfg", sys_cfg.env_cfg);

  if(!(uvm_config_db#(virtual ahb_inf)::get(null,"","inf",vif)))
    `uvm_fatal(get_type_name(),"Failed to get interface in the base test!!")

endfunction : build_phase

/** end of elaboration phase */
function void ahb_base_test::end_of_elaboration_phase(uvm_phase phase);
  /** topology */
  uvm_top.print_topology();
endfunction : end_of_elaboration_phase

`endif  //AHB_BASE_TEST
