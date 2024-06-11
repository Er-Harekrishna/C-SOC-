///////////////////////////////////////////////////////////////////////////////////////////////////
//
//  NAME      :- Pradip Prajapati
//  FILE_NAME :- ahb_master_min_max_addr_data_sequence.sv
//
///////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Abstract:
 * This class defines a sequence in which a all burst with minimum and maximux address
 * AHB WRITE and AHB READ is done. sequence is generated using `uvm_do_with macros.
 *
 * Execution phase: main_phase
 * Sequencer: ahb_mas_seqr
 *
 */
	  
`ifndef AHB_MASTER_MIN_MAX_ADDR_DATA_SEQUENCE
`define AHB_MASTER_MIN_MAX_ADDR_DATA_SEQUENCE

class ahb_master_min_max_addr_data_sequence extends ahb_base_master_sequence;
  
  /** factroy registration */
  `uvm_object_utils(ahb_master_min_max_addr_data_sequence)
  
  /** class constructor */
  extern function new(string name="ahb_master_min_max_addr_data_sequence");
  
  /** body method for generating stimulus */
  extern task body();

endclass : ahb_master_min_max_addr_data_sequence

//*****************************************************************************
//methods
//*****************************************************************************

/** class constructor */
function ahb_master_min_max_addr_data_sequence::new(string name="ahb_master_min_max_addr_data_sequence");
  super.new(name);
endfunction : new

/** body method for generating stimulus */
task ahb_master_min_max_addr_data_sequence::body();
  
  `uvm_info("body", "Entered ...", UVM_MEDIUM)
  
  if(!(uvm_config_db #(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length)))
    `uvm_info("BODY","GET FAILED",UVM_MEDIUM)

  `uvm_info("body", $sformatf("sequence_length is %0d", sequence_length), UVM_MEDIUM);

  for(int k=0;k<8;k++) begin
     
    `uvm_do_with(req,
     { HADDR       == (('d2**(`ADDR_WIDTH))-1);
       HWRITE      == 1;
       hburst_type == hburst_enum'(k);
       hsize_type  == hsize_enum'(BYTE);
       incr_size   == 3;
       foreach(busy_trans_cycles[i])
	 busy_trans_cycles[i]==0;
     })

    `uvm_do_with(req,
     { HADDR       == (('d2**(`ADDR_WIDTH))-1);
       HWRITE      == 0;
       hburst_type == hburst_enum'(k);
       hsize_type  == hsize_enum'(BYTE);
       incr_size   == 3;
       foreach(busy_trans_cycles[i])
	 busy_trans_cycles[i]==0;
     })

  end
  
  for(int k=0;k<8;k++) begin
    for(int i=0;i<=$clog2(`DATA_WIDTH/8);i++) begin  
      
      `uvm_do_with(req,
       { HADDR       == 0;
         HWRITE      == 1;
	 hburst_type == hburst_enum'(k);
	 hsize_type  == hsize_enum'(i);
	 incr_size   == 3;
	 foreach(busy_trans_cycles[i])
	   busy_trans_cycles[i]==0;
       })
      
      `uvm_do_with(req,
       { HADDR       == 0;
         HWRITE      == 0;
	 hburst_type == hburst_enum'(k);
	 hsize_type  == hsize_enum'(i);
	 incr_size   == 3;
	 foreach(busy_trans_cycles[i])
	   busy_trans_cycles[i]==0;
       })

    end
  end

  `uvm_do_with(req,
   { HADDR       == 0;
     HWRITE      == 1;
     hburst_type == hburst_enum'(SINGLE);
     hsize_type  == hsize_enum'(WORDLINE_32);
     HWDATA[0]   == -1;
     foreach(busy_trans_cycles[i])
       busy_trans_cycles[i]==0;
   })
  
  `uvm_do_with(req,
   { HADDR       == 0;
     HWRITE      == 0;
     hburst_type == hburst_enum'(SINGLE);
     hsize_type  == hsize_enum'(WORDLINE_32);
     incr_size   == 1;
     foreach(busy_trans_cycles[i])
       busy_trans_cycles[i]==0;
   })
  
  `uvm_do_with(req,
   { HADDR       == 0;
     HWRITE      == 1;
     hburst_type == hburst_enum'(SINGLE);
     hsize_type  == hsize_enum'(WORDLINE_32);              
     HWDATA[0]   == 0;
     foreach(busy_trans_cycles[i])
       busy_trans_cycles[i]==0;
   })
  `uvm_do_with(req,
   { HADDR       == 0;
     HWRITE      == 0;
     hburst_type == hburst_enum'(SINGLE);
     hsize_type  == hsize_enum'(WORDLINE_32);
     foreach(busy_trans_cycles[i])
       busy_trans_cycles[i]==0;
   })
  
  `uvm_info("body", "Exiting ...", UVM_MEDIUM)

endtask : body

`endif //AHB_MASTER_MIN_MAX_ADDR_DATA_SEQUENCE.



