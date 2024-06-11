//////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  NAME      :- Pradip Prajapati
//  FILE_NAME :- ahb_assertion.sv
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Abstract:
 * ahb_assertion provides protocol levele checks with the help of assertions.
 * protocol violation is reported by the assetions.
 *
 */
import uvm_pkg::*;
`include "uvm_macros.svh"

`ifndef AHB_ASSERTIONS
`define AHB_ASSERTIONS

interface ahb_assertion(input bit                         HCLK,
                        input bit                         HRESETn,
                        input logic [`DATA_WIDTH-1:0]     HRDATA,
                        input logic                       HREADY,
                        input logic                       HRESP,
	                input logic                       HNONSEC,
	                input logic [`HMASTER_WIDTH-1:0]  HMASTER,
                        input logic [`ADDR_WIDTH-1:0]     HADDR,
                        input logic [`HBURST_WIDTH-1:0]   HBURST,
                        input logic                       HMASTLOCK,
                        input logic [`HPROT_WIDTH-1:0]    HPROT,
                        input logic [2:0]                 HSIZE,
                        input logic [1:0]                 HTRANS,
                        input logic [`DATA_WIDTH-1:0]     HWDATA,
                        input logic                       HWRITE);
  
  /** freq_check - checks for the clock frequency */
  property freq_check();
    time current_time;
    (1,current_time=$time)|=>($time-current_time==`TIME_PERIOD);
  endproperty : freq_check

  /** size_less_or_equal_data_width - check that size of the transfer must be less than data width */
  property size_less_or_equal_data_width();		     
    if(HRESETn)  
      HSIZE <= ($clog2(`DATA_WIDTH/8));
  endproperty : size_less_or_equal_data_width

  /** align address - checks that adress must be aligned */
  property aligned_address();
    if(HRESETn && HTRANS!=0) HADDR % (2**HSIZE) ==0;
  endproperty : aligned_address

  /** okay_resp_in_busy_and_idle - checks during busy and idle transfer it should give zero wait 
   *  state okay response  
   */
  property okay_resp_in_busy_and_idle();
    (HTRANS == 0||HTRANS == 1) && (HREADY)|=> !HRESP;	  
  endproperty : okay_resp_in_busy_and_idle

  /** ready_deassert_error_first_cycle - checks during error reponse first cycle hready should 
   *  be deasserted
   */
  property two_cycle_error();
    HRESP |-> !HREADY |-> ##1 HRESP |-> (!HREADY && HTRANS==0) |-> ##1 HREADY ;	  
  endproperty : two_cycle_error

  /** idle_to_busy_seq_invalid_change - checks in single cycles IDLE to BUSY and SEQ transfer is inavlid */
  property idle_to_busy_seq_invalid_change();			
    (HTRANS==0) |=> (HTRANS!=1 && HTRANS!=3); 		
  endproperty : idle_to_busy_seq_invalid_change

  /** reset_valid_signal - checks signal validity during reset */
  property reset_valid_signal();
    1 |-> @(posedge HRESETn) HADDR!=='bx && HBURST!=='bx && HTRANS=='b0 && HMASTLOCK!=='bx && HPROT!=='bx && HSIZE!=='bx && HNONSEC!=='bx && HMASTER!=='bx && HWDATA!=='bx && HWRITE!=='bx && HREADY=='b1 && HRESP!=='bx;
  endproperty : reset_valid_signal

  /** non_tristate - checks any signal not driven to tristate */
  property non_tristate();	
    HADDR!=='bz && HBURST!=='bz && HTRANS!=='bz && HMASTLOCK!=='bz && HPROT!=='bz && HSIZE!=='bz && `ifdef AHB_SECURE_TR_PROPERTY HNONSEC!=='bz && `endif `ifdef AHB_EXCLUSIVE_TR_PROPERTY HEXCL!=='bz && HMASTER!=='bz && `endif HWDATA!=='bz && `ifdef AHB_STROBE_PROPERTY HWSTRB!=='bz && `endif HWRITE!=='bz && HRDATA!=='bz && HREADY!=='bz && HRESP!=='bz `ifdef AHB_EXCLUSIVE_TR_PROPERTY && HEXOKAY!=='bz `endif;
  endproperty : non_tristate

  /** fixed_busy_to_invalid_change - checks during fixed burst transfer BUSY to IDLE and 
   *  NONSEQ transfer is invalid.
   */
  property fixed_busy_to_invalid_change();
    (HTRANS==1 && HBURST!=0 && HBURST!=1 && !HRESP) |-> ##1 (HTRANS!=0 && HTRANS!=2);
  endproperty : fixed_busy_to_invalid_change

  /** nonseq_to_idle_invalid_change - checks during fixed and undefined length transfer 
   *  NONSEQ to IDLE transfer is not possible.
   */
  property nonseq_to_idle_invalid_change();
    disable iff(!HRESETn) (HTRANS==2 && HBURST!=0 && !HRESP) |-> ##1 (HTRANS!=0);
  endproperty : nonseq_to_idle_invalid_change

  /** single_invalid_trans - checks in single burst BUSY and SEQ transfer type is inavlid */
  property single_invalid_trans();
    (HBURST==0) |-> (HTRANS!=1 && HTRANS!=3);
  endproperty : single_invalid_trans

  /** waited_fixed_burst_trans_busy_to_invalid_change - checks during wiated fixed burst 
   *  transfer BUSY to IDLE and NONSEQ transfer is invalid.
   */		
  property waited_fixed_burst_trans_busy_to_invalid_change();
    (!HREADY && HTRANS==1 && HBURST!=1 && !HRESP) |-> ##1 (HTRANS!=0 && HTRANS!=2);
  endproperty : waited_fixed_burst_trans_busy_to_invalid_change

  /**waited_fixed_burst_trans_idle_to_invalid_change - checks during waited fixed burst
   * transfer IDLE to BUSY and SEQ transfer is inavlid.
   */		
  property waited_fixed_burst_trans_idle_to_invalid_change();
    (!HREADY && HTRANS==0 && !HRESP) |-> ##1 (HTRANS!=1 && HTRANS!=3);
  endproperty : waited_fixed_burst_trans_idle_to_invalid_change

  /** waited_fixed_burst_busy_to_seq_trans_constant - checks during waited fixed burst
   *  transfer BUSY to SEQ transfer is constant until hready is high.
   */
  property waited_fixed_burst_busy_to_seq_trans_constant();
    (!HREADY && HTRANS==1 && HBURST!=1 && !HRESP) |-> ##1 (HTRANS==3 && !HREADY)|-> HREADY [*1] |-> $stable(HTRANS) && $stable(HADDR);	  
  endproperty : waited_fixed_burst_busy_to_seq_trans_constant

  /** waited_undefined_burst_busy_to_any_trans_constant - checks during waited undefined
   *  burst length transfer BUSY to SEQ or NONSEQ transfer is happened that must be constant 
   *  until hready is high.
   */
  property waited_undefined_burst_busy_to_any_trans_constant();
    (!HREADY && HTRANS==1 && HBURST==1 && !HRESP) |-> ##1 ((HTRANS==3 || HTRANS==2) && !HREADY) |-> HREADY [*1] |-> $stable(HTRANS) && $stable(HADDR);
  endproperty : waited_undefined_burst_busy_to_any_trans_constant

  /** idle_to_nonseq_trans_constant - checks during waited transfer IDLE to NONSEQ transfer must
   *  constant until hready is high. 
   */			
  property idle_to_nonseq_trans_addr_constant();		
    (!HREADY && HTRANS==0 && !HRESP) |-> ##1 (HTRANS==2 && !HREADY) |-> HREADY [*1] |-> $stable(HTRANS) && $stable(HADDR);		
  endproperty : idle_to_nonseq_trans_addr_constant

  /** busy_to_seq_addr_constant - checks during BUSY to SEQ transfer address must be constant */
  property busy_to_seq_addr_constant();
    (HTRANS==1) |=> (HTRANS==3) |-> $stable(HADDR);	  
  endproperty : busy_to_seq_addr_constant

  /** signal_stable_until_ready - checks during waited transfers HTRANS, HADDR, HWDATA must be 
   *  constant until hready is high.
   */
  property signal_stable_until_ready();
    (HRESETn && !HREADY && (HTRANS==2 || HTRANS==3) && !HRESP) |-> ##1 HREADY[*1] |-> $stable(HTRANS) && $stable(HADDR) && $stable(HWDATA);				
  endproperty : signal_stable_until_ready	

  /** wait_timeout - checks wait cycles cant't be more than 16 cycles */
  property wait_timeout();
    !HREADY [*16] |=> HREADY;	  
  endproperty : wait_timeout
  
  FREQUENCY_CHECK                                   : assert property (@(posedge HCLK) freq_check)
  else
    `uvm_error("Assertion Failed!!!","Frequency Check Is Failed");

  SIZE_LESS_OR_EQUAL_DATA_WIDTH                     : assert property (@(posedge HCLK) size_less_or_equal_data_width)
  else 
    `uvm_error("Assertion Failed!!!","Size Of The Transfer Is Greater Than Data Width");

  ALIGNED_ADDRESS                                   : assert property (@(posedge HCLK) aligned_address)
  else 
    `uvm_error("Assertion Failed!!!","Address Is Not Aligned With Transfer Size");
  
  OKAY_RESP_IN_BUSY_AND_IDLE                        : assert property (@(posedge HCLK) okay_resp_in_busy_and_idle)
  else 
    `uvm_error("Assertion Failed!!!","BUSY and IDLE Transfer Not Received Zero Wait Cycle Okay Response");
  
  TWO_CYCLE_ERROR                                   : assert property (@(posedge HCLK) two_cycle_error)
  else
    `uvm_error("Assertion Failed!!!","Error Response Is Not Of Two Cycle")
  
  IDLE_TO_BUSY_SEQ_INVALID_CHANGE                   : assert property (@(posedge HCLK) idle_to_busy_seq_invalid_change)
  else 
    `uvm_error("Assertion Failed!!!","During Single Burst Inavlid Transfer From IDLE Transfer Is Detected");
  
  //FIXED_BURST_ADDR_INCR                           : assert property (@(posedge HCLK) incr_burst_addr_incr)
  RESET_VALID_SIGNAL                                : assert property (@(negedge HRESETn) reset_valid_signal)
  else 
    `uvm_error("Assertion Failed!!!","During Reset Signals are Not valid");
  
  NON_TRISTATE                                      : assert property (@(posedge HCLK) non_tristate)
  else 
    `uvm_error("Assertion Failed!!!","Tristate is Detected On Bus");
 
  FIXED_BUSY_TO_INVALID_CHANGE                      : assert property (@(posedge HCLK) fixed_busy_to_invalid_change)
  else
    `uvm_error("Assertion Failed!!!","During Fixed Burst Transfer BUSY To IDLE or NONSEQ Transfer");

  NONSEQ_TO_IDLE_INVALID_CHANGE                     : assert property (@(posedge HCLK) nonseq_to_idle_invalid_change)
  else
    `uvm_error("Assertion Failed!!!","During Fixed And Undefined Length Burst NONSEQ to IDLE Transfer");

  SINGLE_INVALID_TRANS                              : assert property (@(posedge HCLK) single_invalid_trans)
  else 
    `uvm_error("Assertion Failed!!!","During SINGLE Burst Transfer BUSY or SEQ Transfer is Detected"); 

  WAITED_FIXED_BURST_TRANS_BUSY_TO_INVALID_CHANGE           : assert property (@(posedge HCLK) waited_fixed_burst_trans_busy_to_invalid_change)
  else 
    `uvm_error("Assertion Failed!!!","During Waited Fixed Burst Transfer BUSY To Invalid Transfer Detected");
  
  WAITED_FIXED_BURST_TRANS_IDLE_TO_INVALID_CHANGE           : assert property (@(posedge HCLK) waited_fixed_burst_trans_idle_to_invalid_change)
  else 
    `uvm_error("Assertion Failed!!!","During Waited Fixed Burst Transfer IDLE to Invalid Transfer Detected");

  WAITED_FIXED_BURST_BUSY_TO_SEQ_TRANS_CONSTANT     : assert property (@(posedge HCLK) waited_fixed_burst_busy_to_seq_trans_constant)
  else 
    `uvm_error("Assertion Failed!!!","During Waited Fixed Burst Transfer BUSY To SEQ Transfer is Not Constant Until HREADY is High");
  
  WAITED_UNDEFINED_BURST_BUSY_TO_ANY_TRANS_CONSTANT : assert property (@(posedge HCLK) waited_undefined_burst_busy_to_any_trans_constant)
  else 
    `uvm_error("Assertion Failed!!!","During Waited Undefined Length Burst Transfer BUSY to NONSEQ or SEQ Transfer Type is Not Constant");
 
  SIGNAL_STABLE_UNTIL_READY                         : assert property (@(posedge HCLK) signal_stable_until_ready)
  else 
    `uvm_error("Assertion Failed!!!","During Waited Transfer Control Singles Are Not Stable");
   
  IDLE_TO_NONSEQ_TRANS_ADDR_CONSTANT                : assert property (@(posedge HCLK) idle_to_nonseq_trans_addr_constant)
  else 
    `uvm_error("Assertion Failed!!!","During Waited Transfer IDLE To NONSEQ Transfer Transfer Type Is Not Constant Until HREADY is High");
  
  WAIT_TIMEOUT                                      : assert property (@(posedge HCLK) wait_timeout)
  else
    `uvm_error("Assertion Failed!!!","After 16 Wait Cycles Timeout")

  BUSY_TO_SEQ_ADDR_CONSTANT                         : assert property (@(posedge HCLK) busy_to_seq_addr_constant)
  else
    `uvm_error("Assertion Failed!!!","During BUSY to SEQ Transfer Address is Changed")

endinterface : ahb_assertion

`endif //AHB_ASSERTIONS
