/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  FILE_NAME :- ahb_inf.sv
//  NAME      :- Pradip Prajapati
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * AHB interface which can be used to connect the VIP to the DUT.
 * A top level interface ahb_if is defined. The top level interface
 * contains reset signal for the bus, and an array of master 
 * & slave interfaces. The top level interface can be used for connecting the
 * master & slave components to the AHB Bus. By default, The number of master
 * and slave interfaces in top level interface can be controlled using macros 
 * AHB_MAX_NUM_MASTERS_{0...} and AHB_MAX_NUM_SLAVES_{0...} respectively. 
 * For example, if you want to use 2 master interfaces and 2 slave interfaces, 
 * you can define following macros when compiling the VIP:
 * AHB_MAX_NUM_MASTERS 2
 * AHB_MAX_NUM_SLAVES  2 
 *
 */

`ifndef AHB_INTERFACE
`define AHB_INTERFACE

`include "ahb_assertion.sv"
`include "ahb_master_inf.sv"
`include "ahb_slave_inf.sv"

interface ahb_inf ();

  logic hclk;	
  logic hresetn;
  
  /* AHB_MAX_NUM_MASTERS_0 defines there are no master interface 
   */
  `ifndef AHB_MAX_NUM_MASTERS_0
    ahb_mas_inf  mas_if[`AHB_MAX_NUM_MASTERS](hclk,hresetn);
  `endif

  /* AHB_MAX_NUM_SLAVES_0 defines there are no slave interface 
   */
  `ifndef AHB_MAX_NUM_SLAVES_0  
    ahb_slv_inf  slv_if[`AHB_MAX_NUM_SLAVES](hclk,hresetn);
  `endif

  /* reset task - used for applying reset in between 
   * rst_delay indicates the time before applying reset after calling reset
   * and no_of_rst_cycles defines number of cycles reset is asserted.
   */
  task reset(int rst_delay,int no_of_rst_cycle);
 
    #(rst_delay);	  
    hresetn = 0;
    repeat(no_of_rst_cycle)
      @(posedge hclk);
    hresetn = 1;    

  endtask : reset
  
endinterface : ahb_inf

`endif //AHB_INTERFACE
