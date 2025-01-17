/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  NAME      :- Pradip Prajapati
//  FILE_NAME :- ahb_slave_sequencer.sv
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Abstract:
 * ahb_slv_seqr provides communication between sequences and slave driver.
 *
 */

`ifndef AHB_SLAVE_SEQUENCER
`define AHB_SLAVE_SEQUENCER

class ahb_slv_seqr extends uvm_sequencer #(ahb_slv_trans);

  /** memory for reactive slave mode */  
  bit [7:0] mem [`MEM_DEAPTH];

  /** wr_trans_q - transaction queue for storing transactions in sequence */
  ahb_slv_trans wr_trans_q[$];

  /** interface handle */
  virtual ahb_inf vif;

  /** factroy registration */
  `uvm_component_param_utils(ahb_slv_seqr)

  /** item_export - analysis export for receiveing transactions from monitor */
  uvm_analysis_export #(ahb_slv_trans) item_export;

  /** item_collected_fifo for storing the received transactions */
  uvm_tlm_analysis_fifo #(ahb_slv_trans) item_collected_fifo;

  /** class constructor */
  extern function new(string name="ahb_slv_seqr",uvm_component parent=null);

  /** build phase */
  extern function void build_phase(uvm_phase phase);

  /** connect phase */
  extern function void connect_phase(uvm_phase phase);

  /** run phase */
  extern task run_phase(uvm_phase phase);

endclass : ahb_slv_seqr

//*****************************************************************************
//methods
//*****************************************************************************

/** class constructor */
function ahb_slv_seqr::new(string name="ahb_slv_seqr",uvm_component parent=null);
  super.new(name,parent);
  /** create item_export and item_collected_fifo */
  item_export = new("item_export",this);
  item_collected_fifo = new("item_collected_fifo",this);
endfunction : new

/** build phase */
function void  ahb_slv_seqr::build_phase(uvm_phase phase);
  if(!(uvm_config_db#(virtual ahb_inf)::get(null,"","inf",vif))) begin
    `uvm_fatal(get_type_name(),"Failed To Get Interface!!!")
  end
endfunction : build_phase

/** connect phase */
function void ahb_slv_seqr::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  item_export.connect(item_collected_fifo.analysis_export);
endfunction : connect_phase

/** run phase */
task ahb_slv_seqr::run_phase(uvm_phase phase);

 ahb_slv_trans req;	

 forever begin
   @(negedge vif.hresetn);
   wr_trans_q.delete(); 
   foreach(mem[i])
     mem[i]='b0;
 end
endtask : run_phase

`endif //AHB_SLAVE_SEQUENCER
