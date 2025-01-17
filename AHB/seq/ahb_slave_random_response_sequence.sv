/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  NAME      :- Pradip Prajapati
//  FILE_NAME :- ahb_slave_random_response_sequence.sv
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Abstract:
 * Class ahb_slave_random_response_sequence defines a sequence class that
 * the testbench uses to provide slave response. The sequence receives 
 * a response object of type ahb_slv_trans from slave sequencer. 
 * The sequence class then randomizes the response with constraints 
 * and provides it to the slave driver within the slave agent. 
 * The sequence also writes into or reads from the slave memory.
 *
 * Execution phase: run_phase
 * Sequencer: ahb_slv_seqr
 */

`ifndef AHB_SLAVE_RANDOM_RESPONSE_SEQUENCE
`define AHB_SLAVE_RANDOM_RESPONSE_SEQUENCE

class ahb_slave_random_response_sequence extends ahb_base_slave_sequence;

  /** factroy registration */
  `uvm_object_param_utils(ahb_slave_random_response_sequence)

  /** class constructor */
  extern function new(string name="ahb_slave_random_response_sequence");
 
  /** body method */
  extern task body();
   
endclass : ahb_slave_random_response_sequence

//*****************************************************************************
//methods
//*****************************************************************************

/** class constructor */
function ahb_slave_random_response_sequence::new(string name="ahb_slave_random_response_sequence");
  super.new(name);
endfunction : new

/** body method */
task ahb_slave_random_response_sequence::body();
        
  forever begin
    
    p_sequencer.item_collected_fifo.get(req);
  	 
    `uvm_info("SLAVE SEQUENCE","This Is Slave Sequence Collected Transaction",UVM_MEDIUM)
    req.print();

    write(req);
    read(req);
    assert(req.randomize() with { hresp_type == OKAY; HREADYOUT dist {0:=2,1:=8}; wait_cycles==1; });

    `uvm_send(req);
 
  end   
     
endtask : body

`endif //AHB_SLAVE_RANDOM_RESPONSE_SEQUENCE	
