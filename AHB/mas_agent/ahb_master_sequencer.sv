/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  NAME      :- Pradip Prajapati
//  FILE_NAME :- ahb_master_sequencer.sv
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Abstract:
 * ahb_mas_seqr provides communication between sequences and master driver.
 *
 */

`ifndef AHB_MASTER_SEQUENCER
`define AHB_MASTER_SEQUENCER

class ahb_mas_seqr extends uvm_sequencer #(ahb_mas_trans);

  /** factroy registration */
  `uvm_component_param_utils(ahb_mas_seqr)

  /** virtual interface  */
  virtual ahb_inf vif;

  /** class constructor */
  extern function new(string name = "ahb_mas_seqr", uvm_component parent = null);

  /** build phase */
  extern function void build_phase(uvm_phase phase);
  
endclass : ahb_mas_seqr

//*****************************************************************************
//methods
//*****************************************************************************

/** class constructor */
function ahb_mas_seqr::new(string name = "ahb_mas_seqr", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//build_phase
function void ahb_mas_seqr::build_phase(uvm_phase phase);

  super.build_phase(phase);

  if(!(uvm_config_db#(virtual ahb_inf)::get(this,"*","inf",vif)))
    `uvm_fatal(get_type_name(),"Failed To Get The Interface Handle!!!")

endfunction : build_phase

`endif  //AHB_MASTER_SEQUENCER
