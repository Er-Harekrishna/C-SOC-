/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  FILE_NAME :- ahb_mas_inf.sv
//  NAME      :- Pradip Prajapati
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * The master interface ahb_mas_if defines the AHB signals appropriate
 * for a single port, along with the modports needed for the driver and
 * monitor.
 *
 */

`ifndef AHB_MASTER_INTERFACE
`define AHB_MASTER_INTERFACE

`include "ahb_assertion.sv"

interface ahb_mas_inf (input logic hclk,hresetn);

  // Global Interface signals
  logic         [(`DATA_WIDTH - 1):0]    HRDATA;
  logic                                  HREADY;
  logic         [(`HRESP_WIDTH - 1):0]   HRESP;
  logic                                  HNONSEC;
  logic         [(`HMASTER_WIDTH - 1):0] HMASTER;
  logic         [(`ADDR_WIDTH - 1):0]    HADDR;
  logic         [(`HBURST_WIDTH - 1):0]  HBURST;
  logic                                  HMASTLOCK;
  logic         [(`HPROT_WIDTH - 1):0]   HPROT;
  logic         [(`HSIZE_WIDTH - 1):0]   HSIZE;
  logic         [(`HTRANS_WIDTH-1):0]    HTRANS;
  logic         [(`DATA_WIDTH - 1):0]    HWDATA;
  logic                                  HWRITE;
  logic                                  HSEL;

  // AHB Clocking blocks
  //-----------------------------------------------------------------------
  /**
   * Clocking block that defines VIP AHB Master Interface
   * signal synchronization and directionality.
   */
  clocking ahb_mas_drv_cb @(posedge hclk);
    default input #`AHB_MASTER_DRIVER_IF_SETUP_TIME output #`AHB_MASTER_DRIVER_IF_HOLD_TIME;

    output HNONSEC;
    output HMASTER;
    output HADDR;
    output HBURST;
    output HMASTLOCK;
    output HPROT;
    output HSIZE;
    output HTRANS;
    output HWDATA;
    output HWRITE;

  endclocking: ahb_mas_drv_cb

  //-----------------------------------------------------------------------
  /**
   * Clocking block that defines the AHB Monitor Interface
   * signal synchronization and directionality.
   */
  clocking ahb_mas_mon_cb @(posedge hclk);
    default input #`AHB_MASTER_MONITOR_IF_SETUP_TIME output #`AHB_MASTER_MONITOR_IF_HOLD_TIME;

    input HRDATA;
    input HSEL;
    input HREADY;
    input HRESP;
    input HNONSEC;
    input HMASTER;
    input HADDR;
    input HBURST;
    input HMASTLOCK;
    input HPROT;
    input HSIZE;
    input HTRANS;
    input HWDATA;
    input HWRITE;

   endclocking : ahb_mas_mon_cb

//-----------------------------------------------------------------------
// Modports
//-----------------------------------------------------------------------
  //------------------------------------------------------------------------
  /** Modport used to connect the VIP Master to AHB interface signals. */
  modport ahb_mas_drv_mp (clocking ahb_mas_drv_cb,input hresetn);

  //-----------------------------------------------------------------------
  /** Modport used to connect the VIP Monitor to AHB interface signals. */
  modport ahb_mas_mon_mp (clocking ahb_mas_mon_cb,input hresetn);

  //------------------------------------------------------
  /** Assertion used to verify the protocol violation. */
  `ifdef ENABLE_MASTER_ASSERTION
  ahb_assertion mas_assertion(.HCLK(hclk),
                              .HRESETn(hresetn),
                              .HRDATA(HRDATA),
                              .HREADY(HREADY),
                              .HRESP(HRESP),
                              .HNONSEC(HNONSEC),
                              .HMASTER(HMASTER),
                              .HADDR(HADDR),
                              .HBURST(HBURST),
                              .HMASTLOCK(HMASTLOCK),
                              .HPROT(HPROT),
                              .HSIZE(HSIZE),
                              .HTRANS(HTRANS),
                              .HWDATA(HWDATA),
                              .HWRITE(HWRITE));
  `endif

  task force_and_release_x_z_value(logic value,int release_delay);

    force HADDR  =value;
    force HWDATA =value;
    force HRDATA =value;
    force HADDR  =value;
    force HTRANS =value;
    force HBURST =value;
    force HWRITE =value;
    #(release_delay);
    release HADDR;
    release HWDATA;
    release HRDATA;
    release HADDR ;
    release HTRANS;
    release HBURST;
    release HWRITE;

  endtask
 
endinterface: ahb_mas_inf

`endif // AHB_MASTER_INTERFACE
