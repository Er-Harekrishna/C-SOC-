/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  NAME      :- Pradip Prajapati
//  FILE_NAME :- ahb_master_increment_burst_sequence.sv
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Abstract:
 * This class defines a sequence in which a INCR burst AHB WRITE followed by a AHB READ
 * with all different sizes like 1,2,3,...,32,33 to 63,64,65 to 255,256,257 to 512,513 to 1023,1024
 * sequence is generated using `uvm_do_with macros.
 *
 * Execution phase: main_phase
 * Sequencer: ahb_mas_seqr
 *
 */

`ifndef AHB_MASTER_INCREMENT_BURST_SEQUENCE
`define AHB_MASTER_INCREMENT_BURST_SEQUENCE

class ahb_master_increment_burst_sequence extends ahb_base_master_sequence;
  
  /** factroy registration */
  `uvm_object_utils(ahb_master_increment_burst_sequence)
  
  /** class constructor */
  extern function new(string name="ahb_master_increment_burst_sequence");
  
  /** body method for generating stimulus */
  extern task body();

endclass : ahb_master_increment_burst_sequence

//*****************************************************************************
//methods
//*****************************************************************************

/** class constructor */
function ahb_master_increment_burst_sequence::new(string name="ahb_master_increment_burst_sequence");
  super.new(name);
endfunction : new

/** body method for generating stimulus */
task ahb_master_increment_burst_sequence::body();
  
  `uvm_info("body", "Entered ...", UVM_MEDIUM)

  if(!(uvm_config_db #(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length)))
    `uvm_info("BODY","GET FAILED",UVM_MEDIUM)

  `uvm_info("body", $sformatf("sequence_length is %0d", sequence_length), UVM_MEDIUM);
  
  for(int i=1;i<33;i++) begin

    `uvm_do_with(req,
     {  HADDR       == 2**(i);
        HWRITE      == 1;
        hburst_type == hburst_enum'(INCR);
        hsize_type  == hsize_enum'(HALFWORD);
        incr_size   == i;
	foreach(busy_trans_cycles[i])
	  busy_trans_cycles[i]==0;
     })

    `uvm_do_with(req,
     {  HADDR       == 2**(i);
        HWRITE      == 0;
        hburst_type == hburst_enum'(INCR);
        hsize_type  == hsize_enum'(HALFWORD);
        incr_size   == i;
	foreach(busy_trans_cycles[i])
	  busy_trans_cycles[i]==0;
     })

  end
  
  for(int k=64;k<=1024;k=k*2) begin
 
    `uvm_do_with(req,
     {  HADDR       == 0; 
        HWRITE      == 1;
        hburst_type == hburst_enum'(INCR);
        hsize_type  == hsize_enum'(BYTE);
        incr_size   == k;
	foreach(busy_trans_cycles[i])
	  busy_trans_cycles[i]==0;
     })

    `uvm_do_with(req,
     {  HADDR       == 0;
        HWRITE      == 1;
        hburst_type == hburst_enum'(INCR);
        hsize_type  == hsize_enum'(BYTE);
        incr_size   == k;
	foreach(busy_trans_cycles[i])
	  busy_trans_cycles[i]==0;
     })

   end

   for(int j=63;j<1024;j=j*2) begin

     `uvm_do_with(req,
      {  HADDR       == 0;
         HWRITE      == 1;
         hburst_type == hburst_enum'(INCR);
         hsize_type  == hsize_enum'(BYTE);
         incr_size   == j;
	 foreach(busy_trans_cycles[i])
	   busy_trans_cycles[i]==0;
      })

     `uvm_do_with(req,
      {  HADDR       == 0;
         HWRITE      == 1;
         hburst_type == hburst_enum'(INCR);
         hsize_type  == hsize_enum'(BYTE);
         incr_size   == j;
	 foreach(busy_trans_cycles[i])
	   busy_trans_cycles[i]==0;
      })
   end
   
  `uvm_info("body", "Exiting ...", UVM_MEDIUM)

endtask : body

`endif //AHB_MASTER_INCREMENT_BURST_SEQUENCE.



