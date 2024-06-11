//////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  NAME      :- Pradip Prajapati
//  FILE_NAME :- AHB_master_agent.sv
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Abstract:
 * ahb_mas_agent contains master driver, master sequencer and master monitor.
 * It also contains configurations for agent.
 *
 */

`ifndef AHB_MASTER_AGENT
`define AHB_MASTER_AGENT

class ahb_mas_agent extends uvm_agent;

  /** factory registration */
  `uvm_component_param_utils(ahb_mas_agent)

  /** configuration class instance */
  ahb_mas_agent_cfg   mas_agent_cfg;

  /** component handles(sequencer, driver, monitor, checker) */
  ahb_mas_seqr        mas_seqr_h;
  ahb_mas_drv         mas_drv_h;
  ahb_mas_mon         mas_mon_h;
  ahb_mas_checker     mas_chk_h;

  /** virtual interface */
  virtual ahb_mas_inf mas_vif;

  /** class constructor */
  extern function new(string name = "ahb_mas_agent", uvm_component parent = null);

  /** build phase */
  extern function void build_phase(uvm_phase phase);

  /** connect phase */
  extern function void connect_phase(uvm_phase phase);

endclass : ahb_mas_agent

//*****************************************************************************
//methods
//*****************************************************************************

/** class constructor */
function ahb_mas_agent::new(string name = "ahb_mas_agent", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

/** build phase - create the master sequencer, master driver, master_monitor, master checker */
function void ahb_mas_agent::build_phase(uvm_phase phase);

  /** master agent configurations */
  if (!uvm_config_db#(ahb_mas_agent_cfg)::get(this, "", "mas_agent_cfg", mas_agent_cfg))
    `uvm_fatal(get_full_name(), "Not Able To Get The Configurations Of Master!!!")

  /** create master sequencer and master driver */
  if (mas_agent_cfg.is_active == UVM_ACTIVE) begin
    mas_seqr_h = ahb_mas_seqr::type_id::create("mas_seqr_h", this);
    mas_drv_h  = ahb_mas_drv::type_id::create("mas_drv_h", this);
  end

  /** create master monitor */
  mas_mon_h = ahb_mas_mon::type_id::create("mas_mon_h", this);

  /** create master checker */
  if (mas_agent_cfg.is_enable == ENABLE)
    mas_chk_h = ahb_mas_checker::type_id::create("mas_chk_h", this);

  /** master interface */
  if (!uvm_config_db#(virtual ahb_mas_inf)::get(this, "", "mas_vif", mas_vif))
    `uvm_fatal(get_full_name(), "Not Able To Get The Interface!!!")

endfunction : build_phase

/** connect phase - connection of master driver and master sequencer 
 *  passing the interface to the driver, monitor and checker. 
 */
function void ahb_mas_agent::connect_phase(uvm_phase phase);

  if (mas_agent_cfg.is_active == UVM_ACTIVE) begin
    mas_drv_h.seq_item_port.connect(mas_seqr_h.seq_item_export);
    mas_drv_h.mas_vif  = mas_vif;
  end

  mas_mon_h.mas_vif = mas_vif;

  if (mas_agent_cfg.is_enable == ENABLE) mas_mon_h.mas_ap_ch.connect(mas_chk_h.mas_ai_ch);

endfunction : connect_phase

`endif  //AHB_MASTER_AGENT
