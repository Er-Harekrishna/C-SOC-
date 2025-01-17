/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  NAME      :- Pradip Prajapati
//  FILE_NAME :- ahb_mas_trans.sv
//  EDITED_BY :- Rajvi Padaria
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

class ahb_mas_trans extends ahb_base_trans;

  //master output signals
  
  rand bit [(`ADDR_WIDTH-1):0]   HADDR;
  rand bit [(`DATA_WIDTH-1):0]   HWDATA[];
  rand bit                       HWRITE;
  rand bit [(`HPROT_WIDTH-1):0]  HPROT;
  rand bit                       HMASTLOCK;
  rand bit [`HMASTER_WIDTH-1:0]  HMASTER;
  rand hburst_enum               hburst_type;
  rand hsize_enum                hsize_type;
  rand htrans_enum               htrans_type[];
  
  bit                            HREADY;
  hresp_enum                     hresp_type;
 
  rand int                       beat_cnt;
  rand bit                       enb_hsize;
  rand bit                       enb_haddr;
  rand bit[2:0]                  no_of_wait;  //temp variable for idle transition at the end of burst.

  rand int                       busy_trans_cycles[$];
  rand htrans_enum               idle_trans_queue[$];
  rand int                       index_for_busy_transfer;

  /** CALLBACK ENABLE/DISABLE VARIABLE */
  rand bit                       enb_hsize_greater_than_width_cb;
  rand bit                       enb_haddr_cross_boundary_cb;
  rand bit                       enb_hsize_change_in_between_burst_cb;
  rand bit                       enb_hburst_change_in_between_burst_cb;
  rand bit                       enb_x_value_cb;

  //enum for HBURST AND HSIZE types
  
  rand int                       incr_size;

  int                            no_of_beats;
  int                            no_of_bytes;
  int                            lower_boundary;
  int                            addr_boundary;
  int                            higher_boundary;
  int                            addr_incr;
  
  //factory registration
  
  `uvm_object_param_utils_begin(ahb_mas_trans)
      
    `uvm_field_int (HADDR,UVM_ALL_ON)
    `uvm_field_int (HWRITE,UVM_ALL_ON)
    `uvm_field_array_int(HWDATA,UVM_ALL_ON)
    `uvm_field_int (HPROT,UVM_ALL_ON)
    `uvm_field_int (HMASTER,UVM_ALL_ON)
    `uvm_field_int (HMASTLOCK,UVM_ALL_ON)
    `uvm_field_int (HREADY,UVM_ALL_ON)
    `uvm_field_enum(hburst_enum,hburst_type,UVM_ALL_ON)
    `uvm_field_enum(hsize_enum,hsize_type,UVM_ALL_ON)
    `uvm_field_array_enum(htrans_enum,htrans_type,UVM_ALL_ON)
    `uvm_field_enum(hresp_enum,hresp_type,UVM_ALL_ON)
    `uvm_field_int (incr_size,UVM_ALL_ON)
    `uvm_field_int (beat_cnt,UVM_ALL_ON)
    
  `uvm_object_utils_end

  //address allignement
  constraint allign_addr{ soft HADDR%(2**hsize_type) == 0; soft HADDR<=2048; }
  
  /** beat_count_for_hburst - Burst decides how much transfers are there in the burst */
  constraint beat_count_for_hburst{
                                    if(hburst_type==SINGLE)                        beat_cnt==1;
		        	    if(hburst_type==INCR)                          beat_cnt==incr_size;
		        	    if(hburst_type==INCR4  || hburst_type==WRAP4)  beat_cnt==4;
		        	    if(hburst_type==INCR8  || hburst_type==WRAP8)  beat_cnt==8;
		        	    if(hburst_type==INCR16 || hburst_type==WRAP16) beat_cnt==16;
                                  }

  //soft constranit for no_of_Wait
  constraint no_of_waiit {soft no_of_wait==0;};

  /** addr_boundary_limit - burst should not generate address which crosses the boundary limit */ 
  constraint addr_boundary_limit{ HADDR%1024+(beat_cnt*(2**hsize_type)) <= 4092000; }

  /** hsize_less_than_data_width -  hsize should be less than data width */
  constraint hsize_less_than_data_width{ hsize_type <= $clog2(`DATA_WIDTH/8); }
 
  /** increment_burst_size - by default the size of the increment burst is 1 */
  constraint increment_burst_size { soft incr_size==1; }
  
  /** busy_cycle */
  constraint busy_cycle { busy_trans_cycles.size()==beat_cnt-1; }
  
  /** htrans_types - decides the transfer type in burst */
  constraint htrans_types { htrans_type.size() == beat_cnt; 
                            htrans_type[0] == NONSEQ;
		            foreach(htrans_type[i])
		            { if(i>0) htrans_type[i] == SEQ;}   
                          } 

  /** busy_cycles - default number of busy cycles */
  constraint busy_cycles { if(beat_cnt==1)
                           { foreach(busy_trans_cycles[i]) 
                               busy_trans_cycles[i]==0;
			   }
			   else
			   { foreach(busy_trans_cycles[i])
			       soft busy_trans_cycles[i] inside {[0:16]};
			   }
			 }
			       
  /** data_count_for_hburst - data is generated based on the transfers */
  constraint data_count_for_hburst{ HWDATA.size()==beat_cnt; }
  
  /** err_hsize_greater_than_data_width - enables the hsize greater than data width is enabled  */
  constraint err_hsize_greater_than_data_width {enb_hsize_greater_than_width_cb==0;}

  /** err_unalign_addr - unalign address callback is enabled */
  constraint err_unalign_addr {enb_haddr_cross_boundary_cb==0;}

  /** err_hsize_change_btn_burst */
  constraint err_hsize_change_btn_burst {enb_hsize_change_in_between_burst_cb==0;}

  /** err_hburst_change_btn_burst */
  constraint err_hburst_change_btn_busrt {enb_hburst_change_in_between_burst_cb==0;}
  
  /** err_x_drive */
  constraint err_x_drive {enb_x_value_cb==0;}
  
  extern function new(string name="ahb_mas_trans");
  extern function void calc();
  extern function void print();
  extern function void post_randomize();

endclass : ahb_mas_trans
 
//new method
function ahb_mas_trans::new(string name="ahb_mas_trans");
  super.new(name);
endfunction : new
  
//calc method  
function void ahb_mas_trans::calc();

  no_of_beats     = HWDATA.size();
  no_of_bytes     = no_of_beats*(2**hsize_type);
  lower_boundary  = (int'(HADDR/no_of_bytes))*no_of_bytes;
  addr_boundary   = no_of_bytes;
  addr_incr       = 2**hsize_type;
  higher_boundary = lower_boundary + addr_boundary;
  
endfunction : calc

//print meythod
function void ahb_mas_trans::print();

  $display("------------------------------------------------------------------");
  $display("NAME           TYPE        SUB-TYPE     SIZE          VALUE");
  $display("------------------------------------------------------------------");
  $display("HWRITE        integral      binary        1          %b",HWRITE );
  $display("HADDR         integral      hex          %0d         %h",`ADDR_WIDTH , HADDR );
  $display("HWDATA        integral      hex          %0d         %p",`DATA_WIDTH,HWDATA );
  $display("hburst_type   hburst_enum   enum          3          %p",hburst_type);
  $display("hsize_type    hsize_enum    enum          3          %p",hsize_type);
  $display("htrans_type   htrans_enum   enum          3          %p",htrans_type);
  $display("HRDATA        integral      hex          %0d         %0h",`DATA_WIDTH,HRDATA );
  $display("hresp_type    htrans_enum   enum          2          %p",hresp_type);
  $display("hready        hready        bit           1          %p",HREADY);
  $display("-------------------------------------------------------------------");

endfunction : print

function void ahb_mas_trans::post_randomize();

  htrans_enum trans_q[$];

  //trans_q = htrans_type;

  for(int i=0; i<htrans_type.size(); i++) begin
    trans_q.push_back(htrans_type[i]);
    if(i<htrans_type.size()-1) begin
      repeat(busy_trans_cycles[i])     
        trans_q.push_back(BUSY);	    
    end
  end
  
  /*foreach(busy_trans_cycles[i]) begin
    repeat(busy_trans_cycles[i]) begin
      trans_q.insert(i+1,BUSY); 
    end
  end
*/
  htrans_type = trans_q;

endfunction : post_randomize
