/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  NAME      :- Pradip Prajapati
//  FILE_NAME :- ahb_base_slave_sequence.sv
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Abstract:
 * ahb_base_slave_sequence provides API methods and p_sequencer handle. 
 * every sequences are extends from this sequence. This class defines 
 * a api medthods to provide memory write and read functionality.
 *
 * Execution phase: run_phase
 * Sequencer: ahb_slv_seqr
 *
 */

`ifndef AHB_BASE_SLAVE_SEQUENCE
`define AHB_BASE_SLAVE_SEQUENCE

class ahb_base_slave_sequence extends uvm_sequence #(ahb_slv_trans);

  /** factroy registration */
  `uvm_object_param_utils(ahb_base_slave_sequence)

  /** p sequencer declration */
  `uvm_declare_p_sequencer(ahb_slv_seqr)

  /** class constructor */
  extern function new(string name="ahb_base_slave_sequence");

  /** body method */
  extern task body();

  /** API methods for memory write and read functionality */
  extern function void write(ahb_slv_trans wr_req);
  extern function void read(ahb_slv_trans rd_req);
   
endclass : ahb_base_slave_sequence

//*****************************************************************************
//methods
//*****************************************************************************

/** class constructor */
function ahb_base_slave_sequence::new(string name="ahb_base_slave_sequence");
  super.new(name);
endfunction : new

/** body method */
task ahb_base_slave_sequence::body();    
  if(!$cast(p_sequencer,m_sequencer))
    `uvm_fatal(get_full_name(),"Sequencer Up-Casting Failed!!")          	             
endtask : body

/** write */
function void ahb_base_slave_sequence::read(ahb_slv_trans rd_req);

  /** local address and data fields for read */
  bit [`ADDR_WIDTH-1:0] addr;
  bit [`DATA_WIDTH-1:0] data;
  int addr_offset;

  /** Address and Offset Calculations */
  addr = rd_req.HADDR;
  addr_offset = addr - ((int'(addr/(`DATA_WIDTH/8)))*(`DATA_WIDTH/8));

  if(!rd_req.HWRITE && !rd_req.hresp_type) begin

    `uvm_info("SLAVE SEQUENCE","This Is Read Transfer",UVM_MEDIUM)
 
    /** Read Mmeory From Address */
    if(rd_req.htrans_type!=BUSY) begin
      for(int i=0;i<(2**rd_req.hsize_type);i++) begin
        data[(addr_offset*8) +: 8] = p_sequencer.mem[addr];
	addr_offset++;
        addr++;
      end
      rd_req.HRDATA = data;
    end

    `uvm_info("SLAVE SEQUENCE","This Slave Sending Transaction To The Sequencer",UVM_MEDIUM)       
    rd_req.print();

  end
    
endfunction : read

/** read */
function void ahb_base_slave_sequence::write(ahb_slv_trans wr_req);

  /** local address and data fields for write */
  bit [`ADDR_WIDTH-1:0] addr;
  bit [`DATA_WIDTH-1:0] data;
  int addr_offset;

  p_sequencer.wr_trans_q.push_back(wr_req);

  if(!p_sequencer.wr_trans_q[0].HWRITE)
    p_sequencer.wr_trans_q.delete(0);

  if(wr_req.hresp_type)
    p_sequencer.wr_trans_q.delete();

  if(p_sequencer.wr_trans_q.size()!=0) begin 
   if(p_sequencer.wr_trans_q[0].htrans_type==BUSY || p_sequencer.wr_trans_q[0].htrans_type==IDLE)
     p_sequencer.wr_trans_q.delete(0);  
  end

  if($size(p_sequencer.wr_trans_q)==2) begin

    addr = p_sequencer.wr_trans_q[0].HADDR;
    addr_offset = addr - ((int'(addr/(`DATA_WIDTH/8)))*(`DATA_WIDTH/8));

    if(p_sequencer.wr_trans_q[0].HWRITE && !p_sequencer.wr_trans_q[0].hresp_type) begin 

      `uvm_info("SLAVE SEQUENCE","This Is Inside Write Transfer",UVM_MEDIUM)
      
      /** Write Mmeory From Address */
      if(p_sequencer.wr_trans_q[0].htrans_type!=BUSY) begin         
	for(int i=0;i<(2**p_sequencer.wr_trans_q[0].hsize_type);i++) begin            
          p_sequencer.mem[addr] = p_sequencer.wr_trans_q[1].HWDATA[(addr_offset*8) +: 8];
	  addr_offset++;
          addr++;
        end
      end
    
      `uvm_info("SLAVE SEQUENCE","This Is Slave Sending Transfer To Sequencer",UVM_MEDIUM)       
      wr_req.print();
    									        
      p_sequencer.wr_trans_q.delete(0);

      if(p_sequencer.wr_trans_q[0].htrans_type==BUSY)
	p_sequencer.wr_trans_q.delete(0);

    end

    else if(wr_req.hresp_type) 
      p_sequencer.wr_trans_q.delete();

  end

endfunction : write

`endif //AHB_BASE_SLAVE_SEQUENCE
