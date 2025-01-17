/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  NAME      :- Pradip Prajapati
//  FILE_NAME :- ahb_master_error_sequence.sv
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Abstract:
 * This class defines a sequence in which a all error scenarios is generated 
 * using `uvm_do_with macros.
 *
 * Execution phase: main_phase
 * Sequencer: ahb_mas_seqr
 *
 */
	 
`ifndef AHB_MASTER_ERROR_SEQUENCE
`define AHB_MASTER_ERROR_SEQUENCE

class ahb_master_error_sequence extends ahb_base_master_sequence;

  /** factroy registration */
  `uvm_object_utils(ahb_master_error_sequence)

  /** class constructor */
  extern function new(string name="ahb_master_error_sequence");
  
  /** body method for generating stimulus */
  extern task body();

endclass : ahb_master_error_sequence

//*****************************************************************************
//methods
//*****************************************************************************

/** class constructor */
function ahb_master_error_sequence::new(string name="ahb_master_error_sequence");
  super.new(name);
endfunction 

/** body method for generating stimulus */
task ahb_master_error_sequence::body();
  
  `uvm_info("body", "Entered ...", UVM_MEDIUM)

  if(!(uvm_config_db #(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length)))
    `uvm_info("BODY","GET FAILED",UVM_MEDIUM)

  `uvm_info("body", $sformatf("sequence_length is %0d", sequence_length), UVM_MEDIUM);
  
// for(int k=2;k<8;k++) begin

  /* for(int i=0;i<=$clog2(`DATA_WIDTH/8);i++) begin

//---first not noseq seq.
     repeat (sequence_length) begin
      //if(k==2 || k==3) begin
        write(INCR4,hsize_enum'(i),{NONSEQ,SEQ,SEQ,SEQ});
        read(INCR4,{NONSEQ,SEQ,SEQ,SEQ}); 
      //end
      //if(k==4 || k==5) begin
        write(INCR8,hsize_enum'(i),{SEQ,SEQ,SEQ,SEQ,SEQ,SEQ,SEQ,SEQ});
        read(INCR8,{SEQ,SEQ,SEQ,SEQ,SEQ,SEQ,SEQ,SEQ}); 
      //end
      //if(k==6 || k==7) begin
        write(INCR16,hsize_enum'(i),{SEQ,SEQ,SEQ,SEQ,SEQ,SEQ,SEQ,SEQ,SEQ,SEQ,SEQ,SEQ,SEQ,SEQ,SEQ,SEQ});
        read(INCR16,{SEQ,SEQ,SEQ,SEQ,SEQ,SEQ,SEQ,SEQ,SEQ,SEQ,SEQ,SEQ,SEQ,SEQ,SEQ,SEQ}); 
     // end
 
     end
    
     p_sequencer.vif.reset(1,2);

//---sanity seq. 
     repeat(3) begin
       write(SINGLE,hsize_enum'(i),{});
       read(SINGLE,{});
     end


//---idle to busy seq
        
     repeat (sequence_length) begin
     // if(k==2 || k==3) begin
        write(INCR4,hsize_enum'(i),{NONSEQ,SEQ,BUSY,IDLE,BUSY,SEQ,SEQ});
        read(INCR4,{NONSEQ,SEQ,BUSY,IDLE,BUSY,SEQ,SEQ});
     // end
     // if(k==4 || k==5) begin
        write(INCR8,hsize_enum'(i),{NONSEQ,SEQ,SEQ,BUSY,SEQ,SEQ,BUSY,SEQ,IDLE,BUSY,SEQ,SEQ});
        read(INCR8,{NONSEQ,SEQ,SEQ,BUSY,SEQ,SEQ,BUSY,SEQ,IDLE,BUSY,SEQ,SEQ});
     // end
     // if(k==6 || k==7) begin
        write(INCR16,hsize_enum'(i),{NONSEQ,SEQ,SEQ,SEQ,SEQ,SEQ,SEQ,SEQ,SEQ,SEQ,BUSY,SEQ,SEQ,BUSY,SEQ,SEQ,SEQ,IDLE,BUSY,SEQ,BUSY,SEQ,BUSY,SEQ});
        read(INCR16,{NONSEQ,SEQ,SEQ,SEQ,SEQ,SEQ,SEQ,SEQ,SEQ,SEQ,BUSY,SEQ,SEQ,BUSY,SEQ,SEQ,SEQ,IDLE,BUSY,SEQ,BUSY,SEQ,BUSY,SEQ});
       //end
      end

      p_sequencer.vif.reset(1,2);

//---sanity seq. 
     repeat(3) begin
       write(SINGLE,hsize_enum'(i),{});
       read(SINGLE,{});
     end

//--idle to seq seq

     repeat (sequence_length) begin
      //if(k==2 || k==3) begin
        write(INCR4,hsize_enum'(i),{NONSEQ,SEQ,IDLE,SEQ,SEQ});
        read(INCR4,{NONSEQ,SEQ,IDLE,SEQ,SEQ});
      //end
      //if(k==4 || k==5) begin
        write(INCR8,hsize_enum'(i),{NONSEQ,SEQ,SEQ,BUSY,SEQ,SEQ,BUSY,SEQ,IDLE,SEQ,SEQ});
        read(INCR8,{NONSEQ,SEQ,SEQ,BUSY,SEQ,SEQ,BUSY,SEQ,IDLE,SEQ,SEQ});
      //end
      //if(k==6 || k==7) begin
        write(INCR16,hsize_enum'(i),{NONSEQ,SEQ,SEQ,SEQ,SEQ,SEQ,SEQ,SEQ,SEQ,SEQ,BUSY,SEQ,SEQ,BUSY,SEQ,SEQ,SEQ,IDLE,SEQ,BUSY,SEQ,BUSY,SEQ});
        read(INCR16,{NONSEQ,SEQ,SEQ,SEQ,SEQ,SEQ,SEQ,SEQ,SEQ,SEQ,BUSY,SEQ,SEQ,BUSY,SEQ,SEQ,SEQ,IDLE,SEQ,BUSY,SEQ,BUSY,SEQ});
      //end
     end
   
      p_sequencer.vif.reset(1,2);

//---sanity seq. 
     repeat(3) begin
       write(SINGLE,hsize_enum'(i),{});
       read(SINGLE,{});
     end
   end*/
// end
   repeat(5) begin

     `uvm_do_with(req,
      { HADDR       == 0;
        HWRITE      == 1;
	hburst_type == hburst_enum'(SINGLE);
	hsize_type  == hsize_enum'(BYTE);
	incr_size   == 3;
	foreach(busy_trans_cycles[i])
	  busy_trans_cycles[i]==0;
      })
     
     `uvm_do_with(req,
      { HADDR       == 0;
        HWRITE      == 0;
	hburst_type == hburst_enum'(SINGLE);
	hsize_type  == hsize_enum'(BYTE);
	incr_size   == 3;
	foreach(busy_trans_cycles[i])
	  busy_trans_cycles[i]==0;
      })
      
   end

  `uvm_info("body", "Exiting ...", UVM_MEDIUM)

endtask : body

`endif //AHB_MASTER_ERROR_SEQUENCE



