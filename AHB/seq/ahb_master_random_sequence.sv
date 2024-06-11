/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  NAME      :- Pradip Prajapati
//  FILE_NAME :- ahb_master_random_sequence.sv
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Abstract:
 * This class defines a sequence in which a all burst random AHB WRITE followed 
 * by a random AHB READ sequence is generated using `uvm_do_with macros.
 *
 * Execution phase: main_phase
 * Sequencer: ahb_mas_seqr
 *
 */

`ifndef AHB_MASTER_RANDOM_SEQUENCE
`define AHB_MASTER_RANDOM_SEQUENCE

class ahb_master_random_sequence extends ahb_base_master_sequence;
  
  /** factroy registration */
  `uvm_object_utils(ahb_master_random_sequence)
  
  /** class constructor */
  extern function new(string name="ahb_master_random_sequence");
  
  /** body method for generating stimulus */
  extern task body();

endclass : ahb_master_random_sequence

//*****************************************************************************
//methods
//*****************************************************************************

/** class constructor */
function ahb_master_random_sequence::new(string name="ahb_master_random_sequence");
  super.new(name);
endfunction : new

/** body method for generating stimulus */
task ahb_master_random_sequence::body();
  
  `uvm_info("body", "Entered ...", UVM_MEDIUM)

  if(!(uvm_config_db #(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length)))
    `uvm_info("BODY","GET FAILED",UVM_MEDIUM)

  `uvm_info("body", $sformatf("sequence_length is %0d", sequence_length), UVM_MEDIUM);

  repeat(sequence_length) 
    `uvm_do(req)
    
  `uvm_info("body", "Exiting ...", UVM_MEDIUM)

endtask : body

`endif //AHB_MASTER_RANDOM_SEQUENCE.



