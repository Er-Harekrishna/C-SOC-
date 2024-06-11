/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  NAME      :- Pradip Prajapati
//  FILE_NAME :- ahb_cc.svh
//  EDITED_BY :- Karan Patadiya
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//`define ADDRR_WIDTH 32

                 /** WILDCARD BINS FOR WORD , HALFWORD AND BYTE ALIGNED
                     * ADDRESS====>new bins from vip */
  covergroup cvg_32_bit_aligned_addr with function sample(ahb_mas_trans mas_trans_h);

    bit_32_aligned_addr     : coverpoint mas_trans_h.HADDR{
                       wildcard bins wildcard_bins_for_byte_aligned = {32'h????_????};
                       wildcard bins wildcard_bins_for_halfword_aligned = {{28'h????_???,4'b???0}};
                       wildcard bins wildcard_bins_for_word_aligned = {{28'h????_???,4'b??00}};
                       wildcard bins wildcard_bins_for_doubleword_aligned = {{28'h????_???,4'b?000}};
                     }
  endgroup
  covergroup cvg_64_bit_aligned_addr with function sample(ahb_mas_trans mas_trans_h);
    bit_64_aligned_addr : coverpoint mas_trans_h.HADDR{
                       wildcard bins wildcard_bins_for_byte_aligned = {64'h????_????_????_????};
                       wildcard bins wildcard_bins_for_halfword_aligned = {{60'h????_????_????_???,4'b???0}};
                       wildcard bins wildcard_bins_for_word_aligned = {{60'h????_????_????_???,4'b??00}};
                       wildcard bins wildcard_bins_for_doubleword_aligned = {{60'h????_????_????_???,4'b?000}};
                     }
  endgroup
  
  covergroup cvg_mas_data with function sample(ahb_mas_trans mas_trans_h,bit b);

    option.per_instance = 1;        //we need multiple instance seperate coverage.

    mas_wdata_in : coverpoint b{
                      bins data_transition_0_to_1=(0=>1);
                      bins data_transition_1_to_0=(1=>0);
                   }
  endgroup

  covergroup cvg_mas_all_signals with function sample(ahb_mas_trans mas_trans_h);
    mas_haddr_range  : coverpoint mas_trans_h.HADDR{
                     bins addr_low_range={[0:500]};
                     bins addr_mid_range={[501:1500]};
                     bins addr_high_range ={[1501:2048]};
                 }
                 
    
    mas_hwrite_transition : coverpoint mas_trans_h.HWRITE{
                      bins hwrite_0_to_1=(0=>1);
                      bins hwrite_1_to_0=(1=>0);
                 }

    hwrite_range : coverpoint mas_trans_h.HWRITE{
                      //bins hwrite[] = {0,1}; 
                      bins hwrite_0 = {0};
                      bins hwrite_1 = {1};
                  }

    mas_hburst_state : coverpoint mas_trans_h.hburst_type{
                         bins single_burst_operation = {SINGLE};
                         bins incr_burst_operation = {INCR};
                         bins incr4_burst_operation = {INCR4};
                         bins incr8_burst_operation = {INCR8};
                         bins incr16_burst_operation = {INCR16};
                         bins wrap4_burst_operation = {WRAP4};
                         bins wrap8_burst_operation = {WRAP8};
                         bins wrap16_burst_operation = {WRAP16};
                 }
  
    cross_hburst_wr_rd_operation : coverpoint {mas_trans_h.hburst_type,mas_trans_h.HWRITE} {

                  wildcard bins single_wr_rd_any_burst_rd_wr = (4'b000? => 4'b000?,4'b001?,4'b011?,4'b100?,4'b101?,4'b110?,4'b111?);
                  wildcard bins incr_wr_rd_any_burst_rd_wr = (4'b001? => 4'b000?,4'b001?,4'b011?,4'b100?,4'b101?,4'b110?,4'b111?);
                  wildcard bins wrap4_wr_rd_any_burst_rd_wr = (4'b010? => 4'b000?,4'b001?,4'b011?,4'b100?,4'b101?,4'b110?,4'b111?);
                  wildcard bins incr4_wr_rd_any_burst_rd_wr = (4'b011? => 4'b000?,4'b001?,4'b011?,4'b100?,4'b101?,4'b110?,4'b111?);
                  wildcard bins wrap8_wr_rd_any_burst_rd_wr = (4'b100? => 4'b000?,4'b001?,4'b011?,4'b100?,4'b101?,4'b110?,4'b111?);
                  wildcard bins incr8_wr_rd_any_burst_rd_wr = (4'b101? => 4'b000?,4'b001?,4'b011?,4'b100?,4'b101?,4'b110?,4'b111?);
                  wildcard bins wrap16_wr_rd_any_burst_rd_wr = (4'b110? => 4'b000?,4'b001?,4'b011?,4'b100?,4'b101?,4'b110?,4'b111?);
                  wildcard bins incr16_wr_rd_any_burst_rd_wr = (4'b111? => 4'b000?,4'b001?,4'b011?,4'b100?,4'b101?,4'b110?,4'b111?);

                }
    mas_hsize :  coverpoint mas_trans_h.hsize_type{
                      //bins hsize[] = {[0:$clog2(`DATA_WIDTH/8)]};
                      bins hsize[] = {[0:2]};
                 }

    htrans_state : coverpoint mas_trans_h.htrans_type[0]{
                      bins idle_trans = {IDLE};
                      bins nonseq_trans = {NONSEQ};
                      bins busy_trans = {BUSY};
                      bins seq_trans = {SEQ};
                  }

    htrans_nonseq_state : coverpoint mas_trans_h.htrans_type[0]{
                         bins nonseq_trans = {NONSEQ};
                     }

/** waited===>all burst possible transition change*/                  
    waited_all_burst_trans_change  : coverpoint mas_trans_h.htrans_type[0]{
                      bins idle_nonseq = (IDLE=>NONSEQ);
                  }
    
    cross_cp_all_burst_htrans_waited_scenario : cross mas_hburst_state , waited_all_burst_trans_change iff(!mas_trans_h.HREADY){
                                   bins cross_all_burst_idle_to_nonseq_operation = binsof(mas_hburst_state) && binsof(waited_all_burst_trans_change);
                               }

/** waited===>fixed burst possible transition change*/                  
    fixed_hburst_waited_scenario : coverpoint mas_trans_h.hburst_type{
                                   bins waited_fixed_hburst[]={INCR4,WRAP4,INCR8,WRAP8,INCR16,WRAP16};
                               }
    waited_fixed_burst_trans_change  : coverpoint mas_trans_h.htrans_type[0]{
                      bins busy_seq = (BUSY=>SEQ);
                  }
    cross_cp_fixed_burst_htrans_waited_scenario : cross fixed_hburst_waited_scenario , waited_fixed_burst_trans_change iff(!mas_trans_h.HREADY){
                               }

/** waited===>undefined length burst possible transition change*/                  
    undefined_length_hburst_waited_scenario : coverpoint mas_trans_h.hburst_type{
                                   bins waited_undefined_hburst={INCR};
                               }

    waited_undefined_trans_change_for_idle_burst  : coverpoint mas_trans_h.htrans_type[0]{
                      
                      //BUSY TO ALL TRANS TYPE TRANSITION.
                      bins busy_idle = (BUSY=>IDLE);
                      bins busy_nonseq = (BUSY=>NONSEQ);
                      bins busy_seq = (BUSY=>SEQ);
                    }
    cross_cp_undefined_length_burst_htrans_waited_scenario : cross undefined_length_hburst_waited_scenario , waited_undefined_trans_change_for_idle_burst iff(!mas_trans_h.HREADY){
                               }

/** fixed burst trans change */
    fixed_burst_trans_change  : coverpoint mas_trans_h.htrans_type[0]{
                      bins fixed_nonseq_idle = (NONSEQ=>IDLE);
                      bins fixed_nonseq_busy = (NONSEQ=>BUSY);
                      bins fixed_nonseq_seq = (NONSEQ=>SEQ);
                      bins fixed_busy_busy = (BUSY=>BUSY);
                      bins fixed_busy_seq = (BUSY=>SEQ);
                      bins fixed_busy_idle = (BUSY=>IDLE);
                      bins fixed_idle_idle = (IDLE=>IDLE);
                      bins fixed_seq_seq = (SEQ=>SEQ);
                      bins fixed_seq_idle = (SEQ=>IDLE);
                      bins fixed_seq_busy = (SEQ=>BUSY);
                  }

    cross_cp_fixed_burst_htrans_without_wait_scenario : cross fixed_hburst_waited_scenario , fixed_burst_trans_change {
                               }
    
/** INCR trans change */
    cross_cp_incr_burst_nonseq_to_any_without_wait_scenario : cross undefined_length_hburst_waited_scenario , fixed_burst_trans_change {
                               }

/** all signals cross bins*/
    single_hsize_hwrite_htrans_cross_cp : cross mas_hburst_state,mas_hsize,hwrite_range,htrans_nonseq_state{
                              
               bins cross_single_burst_any_size_wr_rd_nonseq = binsof(mas_hburst_state.single_burst_operation) && binsof(mas_hsize) && binsof(hwrite_range) && binsof(htrans_nonseq_state);

                          }

    fixed_hsize_hwrite_htrans_cross_cp : cross fixed_hburst_waited_scenario , mas_hsize , hwrite_range , htrans_state{
    }
    
    undefined_hsize_hwrite_htrans_cross_cp : cross undefined_length_hburst_waited_scenario , mas_hsize , hwrite_range , htrans_state{
    }
  endgroup


  //-------Covergroup-----Slave side-------------------------
  covergroup cvg_slv_data with function sample(ahb_slv_trans slv_trans_h,bit c);
    slv_hrdata : coverpoint c{
                   bins slv_rd_data_transition_0_to_1=(0=>1);
                   bins slv_rd_data_transition_1_to_0=(1=>0);
                 }
  endgroup

  covergroup cvg_slv_signal with function sample(ahb_slv_trans slv_trans_h);
    slv_hready_transition : coverpoint slv_trans_h.HREADYOUT{
                   bins readyout_transiton_0_to_1=(0=>1);
                   bins readyout_transition_1_to_0=(1=>0);
                 }

   //--need optimization for calculating wait cycle.
    slv_hready_consecutive : coverpoint slv_trans_h.HREADYOUT{
                   bins hreadyout_consecutive_0[] = (0[*16]);
               }

    slv_hresp_state  : coverpoint slv_trans_h.hresp_type{
                   bins response_state[]={OKAY,ERROR};

                  /** Transition bins for check weather transfer continues
                  * after error reponse or not*/
                   bins transition_error_to_okay = (ERROR=>OKAY);
                  // bins transition_error_to_error = (ERROR=>ERROR);
                   bins transition_okay_to_okay = (OKAY=>OKAY);
                   bins transition_okay_to_error = (OKAY=>ERROR);

                 }

   /** New bins as per VIP coverage*/
    slv_hwrite_state : coverpoint slv_trans_h.HWRITE{
                       bins slv_hwrite_state []={0,1};
                   }

    slv_hburst_state : coverpoint slv_trans_h.hburst_type{
                         bins single_burst_operation = {SINGLE};
                         bins incr_burst_operation = {INCR};
                         bins incr4_burst_operation = {INCR4};
                         bins incr8_burst_operation = {INCR8};
                         bins incr16_burst_operation = {INCR16};
                         bins wrap4_burst_operation = {WRAP4};
                         bins wrap8_burst_operation = {WRAP8};
                         bins wrap16_burst_operation = {WRAP16};
                       }

    cross_cp_response_burst_wr_rd : cross slv_hwrite_state,slv_hburst_state,slv_hresp_state {
                                      bins hwrite_hburst_hresp= binsof(slv_hburst_state) && binsof(slv_hwrite_state) && binsof(slv_hresp_state.response_state);
                                    }
    

  endgroup

class ahb_cc extends uvm_component;

/*covergroup wait_cycle @(vif.hclk);
  hreadyout_wait_cycle : coverpoint vif.slv_if.HREADY{
            bins consecutive_wait_cycle = (0[*16]);
        }
endgroup*/
  //factory registration

  `uvm_component_utils(ahb_cc)

  `uvm_analysis_imp_decl (_mas)
  `uvm_analysis_imp_decl (_slv)
 
   cvg_mas_data data_h[];
   cvg_32_bit_aligned_addr addr_handle;
   cvg_64_bit_aligned_addr addr_h;


   cvg_mas_all_signals mas_signal_h;
   cvg_slv_data slv_data_h[`DATA_WIDTH];
   cvg_slv_signal slv_signal_h;

  //analysis import for receiving data from monitor for coverage

  uvm_analysis_imp_mas #(ahb_mas_trans,ahb_cc) mas_ai_cc;
  uvm_analysis_imp_slv #(ahb_slv_trans,ahb_cc) slv_ai_cc;
  
  extern function new(string name="ahb_cc",uvm_component parent=null);
  extern function void write_mas(ahb_mas_trans mas_trans_h);
  extern function void write_slv(ahb_slv_trans slv_trans_h);
  extern function void report_phase(uvm_phase phase);
 
endclass : ahb_cc

//*****************************************************************************
//methods
//*****************************************************************************

//new function

function ahb_cc::new(string name="ahb_cc",uvm_component parent=null);

  super.new(name,parent);
  mas_ai_cc = new("mas_ai_cc",this);
  slv_ai_cc = new("slv_ai_cc",this);
  

  if(`ADDR_WIDTH==32)
    addr_handle=new();
  if(`ADDR_WIDTH==64)
    addr_h=new();

 // wait_cycle =new();
  data_h=new[`DATA_WIDTH];
 //--master covergroup handle
 foreach(data_h[i])
   data_h[i]=new();

 mas_signal_h=new();
  //--slave covergroup handle.
 for(int i=0;i<`DATA_WIDTH;i++) begin
    slv_data_h[i]=new();
 end
 slv_signal_h=new();

endfunction : new

//master write method

function void ahb_cc::write_mas(ahb_mas_trans mas_trans_h);

  for(int j=0;j<`DATA_WIDTH;j++) begin
    data_h[j].sample(mas_trans_h,mas_trans_h.HWDATA[0][j]);        
  end
  
  mas_signal_h.sample(mas_trans_h);  
  
  if(`ADDR_WIDTH==32)
    addr_handle.sample(mas_trans_h);
  if(`ADDR_WIDTH==64)
    addr_h.sample(mas_trans_h);
endfunction : write_mas

function void ahb_cc::write_slv(ahb_slv_trans slv_trans_h);

  for(int k=0;k<`DATA_WIDTH;k++) begin
    slv_data_h[k].sample(slv_trans_h,slv_trans_h.HRDATA[k]);
  end
  
  slv_signal_h.sample(slv_trans_h);

endfunction : write_slv

function void ahb_cc :: report_phase(uvm_phase phase);
  `uvm_info(get_type_name(),$sformatf("Total coverage======%f",$get_coverage),UVM_LOW)
endfunction




