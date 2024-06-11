/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  FILE_NAME :- ahb_slv_inf.sv
//  NAME      :- Pradip Prajapati
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * The slave interface ahb_slv_inf defines the AHB signals appropriate
 * for a single port, along with the modports needed for the driver and
 * monitor.
 *
 */

`ifndef AHB_SLAVE_INTERFACE
`define AHB_SLAVE_INTERFACE

`include "ahb_assertion.sv"

interface ahb_slv_inf (input logic hclk,hresetn);
    
  // Global Interface signals
  logic [(`DATA_WIDTH -1):0]       HRDATA;
  logic [(`HRESP_WIDTH -1):0]      HRESP;
  logic                            HNONSEC;
  logic [(`HMASTER_WIDTH-1):0]     HMASTER;
  logic [(`ADDR_WIDTH -1):0]       HADDR;
  logic [(`HBURST_WIDTH -1):0]     HBURST;
  logic [(`HPROT_WIDTH -1):0]      HPROT;
  logic [(`HSIZE_WIDTH -1):0]      HSIZE;
  logic [(`HTRANS_WIDTH -1):0]     HTRANS;
  logic [(`DATA_WIDTH -1):0]       HWDATA;
  logic                            HWRITE;
  logic                            HMASTLOCK;
  logic [(`HSEL_WIDTH -1):0]       HSEL;
  logic                            HREADY_IN;
  logic                            HREADYOUT;

  //-----------------------------------------------------------------------
  /**
   * Clocking block that defines the slave driver signal directionality.
   */
  clocking ahb_slv_drv_cb @(posedge hclk);
    default input #`AHB_SLAVE_DRIVER_IF_SETUP_TIME output #`AHB_SLAVE_DRIVER_IF_HOLD_TIME;
    
    output  HRDATA;
    output  HREADYOUT;
    output  HRESP;

  endclocking : ahb_slv_drv_cb

  //-----------------------------------------------------------------------
  /**
   * Clocking block that defines the slave monitor directionality.
   */
  clocking ahb_slv_mon_cb @(posedge hclk);
    default input #`AHB_SLAVE_MONITOR_IF_SETUP_TIME output #`AHB_SLAVE_MONITOR_IF_HOLD_TIME;
    
    input HADDR;
    input HMASTER;
    input HNONSEC;
    input HBURST;
    input HMASTLOCK;
    input HPROT;
    input HSEL;
    input HSIZE;
    input HTRANS;
    input HWDATA;
    input HWRITE;
    input HRDATA;
    input HREADYOUT;
    input HREADY_IN;    
    input HRESP;

  endclocking : ahb_slv_mon_cb

//-----------------------------------------------------------------------
// Modports
//-----------------------------------------------------------------------
  //------------------------------------------------------------------------
  /** Modport used to connect the Slave Driver signals. */
  modport ahb_slv_drv_mp (clocking ahb_slv_drv_cb);

  //-----------------------------------------------------------------------
  /** Modport used to connect the Slave Monitor signals. */
  modport ahb_slv_mon_mp (clocking ahb_slv_mon_cb);

  //------------------------------------------------------
  /** Assertion used to verify the protocol violation. */
  `ifdef ENABLE_SLAVE_ASSERTION
  ahb_assertion slv_assertion(hclk,
	                      hresetn, 	  
	                      HRDATA,
                              HREADYOUT,
                              HRESP,
                              HNONSEC,
                              HMASTER,
                              HADDR,
                              HBURST,
                              HMASTLOCK,
                              HPROT,
                              HSIZE,
                              HTRANS,
                              HWDATA,
                              HWRITE);
  `endif
 
endinterface: ahb_slv_inf

`endif //AHB_SLAVE_INTERFACE
