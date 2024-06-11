/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  NAME      :- Pradip Prajapati
//  FILE_NAME :- ahb_master_sanity_sequence.sv
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Abstract:
 * This class defines a sequence in which a single burst random AHB WRITE followed 
 * by a random AHB READ sequence is generated using `uvm_do_with macros.
 *
 * Execution phase: main_phase
 * Sequencer: ahb_mas_seqr
 *
 */

`ifndef AHB_MASTER_SANITY_SEQUENCE
`define AHB_MASTER_SANITY_SEQUENCE

class ahb_master_sanity_sequence extends ahb_base_master_sequence;

  /** factroy registration */
  `uvm_object_param_utils(ahb_master_sanity_sequence)
    
  /** class constructor */
  extern function new(string name="ahb_master_sanity_sequence");

  /** body method for generating stimulus */
  extern task body();
 
endclass : ahb_master_sanity_sequence

//*****************************************************************************
//methods
//*****************************************************************************

/** class constructor */
function ahb_master_sanity_sequence::new(string name="ahb_master_sanity_sequence");
  super.new(name);
endfunction : new

/** body method */ 
task ahb_master_sanity_sequence::body();
 
  `uvm_info("body", "Entered ...", UVM_MEDIUM)

  if(!(uvm_config_db #(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length)))
    `uvm_info("BODY","GET FAILED",UVM_MEDIUM)

  `uvm_info("body", $sformatf("sequence_length is %0d", sequence_length), UVM_MEDIUM);
  
  for(int i=0;i<=$clog2(`DATA_WIDTH/8);i++) begin
    repeat (sequence_length) begin
     
      `uvm_do_with(req,
       {  HADDR       == 0;
          HWRITE      == 1;
          hburst_type == hburst_enum'(SINGLE);
          hsize_type  == hsize_enum'(WORD);
          incr_size   == 1;
       })

      `uvm_do_with(req,
       {  HADDR       == 0;
          HWRITE      == 0;
          hburst_type == hburst_enum'(SINGLE);
          hsize_type  == hsize_enum'(HALFWORD);
          incr_size   == 1;
       })
    
    end   
  end

  `uvm_info("body", "Exiting...", UVM_MEDIUM)
  
endtask : body

`endif // AHB_MASTER_SANITY_SEQUENCE

