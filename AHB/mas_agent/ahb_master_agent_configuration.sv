/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  NAME      :- Pradip Prajapati
//  FILE_NAME :- ahb_master_agent_configuration.sv
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Abstract:
 * ahb_mas_agent_cfg is used by user to configure the agents whether our agent
 * is active or passive and also used for enabling and disabling checkers by
 * the use of uvm_active_passive_enum and uvm_checker_enable_disable_enum.
 *
 */

`ifndef AHB_MASTER_AGENT_CONFIG
`define AHB_MASTER_AGENT_CONFIG

class ahb_mas_agent_cfg extends uvm_object;

  /** configurations which can be modified 
   *  is_active - if UVM_ACTIVE configures the agent as active if its UVM_PASSIVE
   *              configures the agent as passive.
   *  is_enable - if ENABLE the checker is enables and if DISABLE checker is disabled.
   */
  uvm_active_passive_enum         is_active = UVM_ACTIVE;
  uvm_checker_enable_disable_enum is_enable = ENABLE;

  /** factory registration */
  `uvm_object_utils_begin(ahb_mas_agent_cfg)

    `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_PRINT)
    `uvm_field_enum(uvm_checker_enable_disable_enum, is_enable, UVM_PRINT)

  `uvm_object_utils_end

  /** class constructor */
  extern function new(string name = "ahb_mas_agent_config");

endclass : ahb_mas_agent_cfg

//*****************************************************************************
//methods
//*****************************************************************************

/** class constructor */
function ahb_mas_agent_cfg::new(string name = "ahb_mas_agent_config");
  super.new(name);
endfunction : new

`endif  //AHB_MASTER_AGENT_CONFIG
