/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  NAME      :- Pradip Prajapati
//  FILE_NAME :- ahb_master_waited_busy_seq_sequence.sv
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Abstract:
 * This class defines a sequence in which a all burst AHB WRITE followed by a random AHB READ
 * with waited transfer in which busy cycles are inserted is generated using `uvm_do_with macros.
 *
 * Execution phase: main_phase
 * Sequencer: ahb_mas_seqr
 *
 */

`ifndef AHB_WAITED_BUSY_SEQ_SEQUENCE
`define AHB_WAITED_BUSY_SEQ_SEQUENCE

class ahb_master_waited_busy_seq_sequence extends ahb_base_master_sequence;
 
  /** factroy registration */
  `uvm_object_utils(ahb_master_waited_busy_seq_sequence)

  /** class constructor */
  extern function new(string name="ahb_master_waited_busy_seq_sequence");
  
  /** body method for generating stimulus */
  extern task body();

endclass : ahb_master_waited_busy_seq_sequence 

//*****************************************************************************
//methods
//*****************************************************************************

/** class constructor */
function ahb_master_waited_busy_seq_sequence::new(string name="ahb_master_waited_busy_seq_sequence");
  super.new(name);
endfunction 

/** body method for generating stimulus */
task ahb_master_waited_busy_seq_sequence::body();
  
  `uvm_info("body", "Entered ...", UVM_MEDIUM)

  if(!(uvm_config_db #(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length)))
    `uvm_info("BODY","GET FAILED",UVM_MEDIUM)

  `uvm_info("body", $sformatf("sequence_length is %0d", sequence_length), UVM_MEDIUM);
  
  for(int k=1;k<8;k++) begin

    for(int i=0;i<=$clog2(`DATA_WIDTH/8);i++) begin

      repeat (sequence_length) begin

        `uvm_do_with(req,
         {  HADDR       == 2**(i);
	    HWRITE      == 1;
	    hburst_type == hburst_enum'(k);
	    hsize_type  == hsize_enum'(i);
	    incr_size   == 3;
  	 })
	 
        `uvm_do_with(req,
         {  HADDR       == 2**(i);
	    HWRITE      == 0;
	    hburst_type == hburst_enum'(k);
	    hsize_type  == hsize_enum'(i);
	    incr_size   == 3;
  	 })
      end
  
    end
  end

  `uvm_info("body", "Exiting ...", UVM_MEDIUM)

endtask : body

`endif //AHB_MASTER_WAITED_BUSY_SEQ_SEQUENCE


