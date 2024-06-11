/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  NAME      :- Pradip Prajapati
//  FILE_NAME :- ahb_base_master_sequence.sv
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Abstract:
 * ahb_base_master_sequence provides API methods and seuqence length and
 * p_sequencer handle and every sequences are extends from this sequence.
 * This class defines a api medthods to provide ease for making test cases.
 *
 * Execution phase: main_phase
 * Sequencer: ahb_mas_seqr
 *
 */

`ifndef AHB_BASE_MASTER_SEQUENCE
`define AHB_BASE_MASTER_SEQUENCE

class ahb_base_master_sequence extends uvm_sequence #(ahb_mas_trans);

  /** factroy registration */
  `uvm_object_param_utils(ahb_base_master_sequence)
 
  /** number of transactions that will be generated */
  int sequence_length = 20;

  /** p_sequencer declartion */
  `uvm_declare_p_sequencer(ahb_mas_seqr)
 
  /** class constructor */
  extern function new(string name="ahb_base_master_sequence");

  /** body method for generating stimulus */
  extern task pre_body();
  extern task post_body();

  /** API methods for user convinience in making sequences */
  extern task write(hburst_enum burst,hsize_enum size,htrans_enum trans[$]={},int incr_length=1);
  extern task read(hburst_enum burst,htrans_enum trans[$]={},int incr_length=1);
 
endclass : ahb_base_master_sequence

//*****************************************************************************
//methods
//*****************************************************************************

/** class constructor */
function ahb_base_master_sequence::new(string name="ahb_base_master_sequence");
  super.new(name);
endfunction : new

/**pre body */
task ahb_base_master_sequence::pre_body();

  if(starting_phase !=null)
    starting_phase.raise_objection(this);

  else
   `uvm_error("seq","error")
        
endtask : pre_body

/** post body*/
task ahb_base_master_sequence::post_body();

  if(starting_phase !=null) begin
    starting_phase.drop_objection(this);
    starting_phase.phase_done.set_drain_time(this,500ns);
  end

  else
   `uvm_error("seq","error")
         
endtask : post_body

/** task write */
task ahb_base_master_sequence::write(hburst_enum burst,hsize_enum size,htrans_enum trans[$]={},int incr_length=1);

  req = ahb_mas_trans::type_id::create("req");  //create the req (seq item)
  wait_for_grant();                            //wait for grant
  assert(req.randomize() with {HWRITE==1; hburst_type==burst; hsize_type==size; incr_size==incr_length;});
  if($size(trans)!=0)
     req.htrans_type=trans;
  send_request(req);                           //send req to driver
  wait_for_item_done();                        //wait for item done from driver
	
endtask :write

/** task read */
task ahb_base_master_sequence::read(hburst_enum burst,htrans_enum trans[$]={},int incr_length=1);

  req = ahb_mas_trans::type_id::create("req");  //create the req (seq item)
  wait_for_grant();                            //wait for grant
  assert(req.randomize() with {HWRITE==0; hburst_type==burst; incr_size==incr_length;});
  if($size(trans)!=0)
     req.htrans_type=trans;
  send_request(req);                           //send req to driver
  wait_for_item_done();                        //wait for item done from driver
	
endtask :read

`endif // AHB_BASE_MASTER_SEQUENCE
