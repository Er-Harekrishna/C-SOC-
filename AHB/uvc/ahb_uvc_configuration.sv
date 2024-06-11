/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  NAME      :- Pradip Prajapati
//  FILE_NAME :- ahb_uvc_config.svh
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Abstract:
 * ahb_uvc_cfg is used by user to configure the uvc whether uvc agent is
 * master or slave and also containes configurations for master and slave
 * agents.
 *
 */

`ifndef AHB_UVC_CONFIG
`define AHB_UVC_CONFIG

class ahb_uvc_config extends uvm_object;

  /** configurations which can be modified to select that uvc contain how much
   * number of master or slave. 
   */
  int no_of_masters = 1;
  int no_of_slaves  = 1;

  /** master agent and slave agent config handles */
  ahb_mas_agent_cfg master_cfg[];
  ahb_slv_agent_cfg slave_cfg[];

  /** factory registration */
  `uvm_object_utils_begin(ahb_uvc_config)
    `uvm_field_int(no_of_masters,UVM_PRINT)
    `uvm_field_int(no_of_slaves,UVM_PRINT)
    `uvm_field_array_object(master_cfg,UVM_PRINT)
    `uvm_field_array_object(slave_cfg,UVM_PRINT)
  `uvm_object_utils_end

  /** create_sub_cfgs */
  extern function void create_sub_cfgs(int no_of_master=1,int no_of_slave=1);

  /** class constructor */
  extern function new(string name = "ahb_uvc_config");

endclass : ahb_uvc_config

//*****************************************************************************
//methods
//*****************************************************************************

/** create_sub_cfgs */
function void ahb_uvc_config::create_sub_cfgs(int no_of_master=1,int no_of_slave=1);
  
  master_cfg = new[no_of_master];
  slave_cfg  = new[no_of_slave];

  foreach(master_cfg[i])
    master_cfg[i] = ahb_mas_agent_cfg::type_id::create($sformatf("mas_agent_cfg[%0d]",i));
  foreach(slave_cfg[i]) 
    slave_cfg[i]  = ahb_slv_agent_cfg::type_id::create($sformatf("slv_agent_cfg[%0d]",i));

endfunction : create_sub_cfgs

/** new function */
function ahb_uvc_config::new(string name = "ahb_uvc_config");
  super.new(name);
endfunction : new

`endif  //AHB_UVC_CONFIG
