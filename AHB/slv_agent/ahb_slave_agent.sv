/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  NAME      :- Pradip Prajapati
//  FILE_NAME :- ahb_slave_agent.sv
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Abstract:
 * ahb_slv_agent contains slave driver, slave sequencer and slave monitor.
 * It also contains configurations for agent.
 *
 */

`ifndef AHB_SLAVE_AGENT
`define AHB_SLAVE_AGENT

class ahb_slv_agent extends uvm_agent;

  /** configuration class instance */
  ahb_slv_agent_cfg slv_agent_cfg;

  /** factory registration */
  `uvm_component_param_utils(ahb_slv_agent)

  /** component handles(sequencer, driver, monitor, checker) */
  ahb_slv_seqr     slv_seqr_h;
  ahb_slv_drv      slv_drv_h;
  ahb_slv_mon      slv_mon_h;
  //ahb_slv_checker  slv_chk_h;

  /** virtual interface */
  virtual ahb_slv_inf slv_vif;

  /** class constructor */
  extern function new(string name = "ahb_slv_agent", uvm_component parent = null);

  /** build phase */
  extern function void build_phase(uvm_phase phase);

  /** connect phase */
  extern function void connect_phase(uvm_phase phase);

endclass : ahb_slv_agent

//*****************************************************************************
//methods
//*****************************************************************************

/** class constructor */
function ahb_slv_agent::new(string name = "ahb_slv_agent", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

/** build_phase - create slave seuqencer, slave driver, slave monitor */
function void ahb_slv_agent::build_phase(uvm_phase phase);
 
  /** get the slave agent configurations */
  if (!uvm_config_db#(ahb_slv_agent_cfg)::get(this, "", "slv_agent_cfg", slv_agent_cfg))
    `uvm_fatal(get_full_name(), "Not Able To Get The Slave Agent Configurations!!!")

  /** create slave sequencer, slave driver, slave monitor */
  if (slv_agent_cfg.is_active == UVM_ACTIVE) begin
    slv_seqr_h = ahb_slv_seqr::type_id::create("slv_seqr_h", this);
    slv_drv_h  = ahb_slv_drv::type_id::create("slv_drv_h", this);
  end
 
  /** create master monitor */
  slv_mon_h = ahb_slv_mon::type_id::create("slv_mon_h", this);

  /** create master checker */
  //if (slv_agent_cfg.is_enable == ENABLE)
    //slv_chk_h = ahb_slv_checker::type_id::create("slv_chk_h", this);

  /** get interface for slave */
  if (!uvm_config_db#(virtual ahb_slv_inf)::get(this, "", "slv_vif", slv_vif))
    `uvm_fatal(get_full_name(), "Not Able To Get The Interface!!!")

endfunction : build_phase

/** connect phase - connect slave sequencer and slave driver also slave monitor
 *  to slave sequencer for reactive support. passing interface to monitor and 
 *  driver.
 */
function void ahb_slv_agent::connect_phase(uvm_phase phase);

  if (slv_agent_cfg.is_active == UVM_ACTIVE) begin
    slv_drv_h.seq_item_port.connect(slv_seqr_h.seq_item_export);
    slv_drv_h.slv_vif  = slv_vif;
    slv_mon_h.slv_ap_mon.connect(slv_seqr_h.item_export);
  end

  slv_mon_h.slv_vif = slv_vif;

  //if (slv_agent_cfg.is_enable == ENABLE) slv_mon_h.slv_ap_ch.connect(slv_chk_h.slv_ai_ch);

endfunction : connect_phase

`endif  //AHB_SLAVE_AGENT
