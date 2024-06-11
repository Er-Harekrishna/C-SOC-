/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  NAME      :- Pradip Prajapati
//  FILE_NAME :- ahb_dut.sv
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Abstract:
 * This module represents a DUT that has 2 AHB Protocol Interfaces.
 * Protocol interface 0 connects to an AHB Master, and all pins have the suffix _m0.
 * Protocol interface 1 connects to an AHB Slave, and all pins have the suffix _s0.. 
 * The behavior of this module is to simply connect the two protocol interfaces 
 * by assigning the appropriate inputs on the Slave side to the outputs on the Master side, 
 * and vice versa.
 *
 */

`ifndef AHB_DUT
`define AHB_DUT

module  ahb_dut 
(

/**
 * Clock and reset
 */

  hclk,
  hresetn,
    
  // Master side of ahb protocol interface signals
  haddr_m0,
  hburst_m0,
  hmastlock_m0,
  hsize_m0,
  htrans_m0,
  hwdata_m0,
  hwrite_m0,
  hprot_m0,
  hready_m0,
  hresp_m0,
  hrdata_m0,
  hmaster_m0,
  hnonsec_m0,
 
  // Slave side of ahb protocol interface signals
  hsel_s0,
  hrdata_s0,
  hresp_s0,
  hready_s0,
  haddr_s0,
  hburst_s0,
  hsize_s0,
  htrans_s0,
  hprot_s0,
  hwrite_s0,
  hwdata_s0,
  hmastlock_s0,
  hmaster_s0,
  hnonsec_s0
  );

  input  hclk;
  input  hresetn;

  //-----------------------------------------------------------
  // AHB Master Port Interface m0: Dataflow Interface Signals
  //-----------------------------------------------------------
  input  [`ADDR_WIDTH -1:0]    haddr_m0;
  input  [`HBURST_WIDTH -1:0]  hburst_m0;
  input                        hmastlock_m0;
  input  [`HSIZE_WIDTH-1:0]    hsize_m0;
  input  [`HTRANS_WIDTH-1:0]   htrans_m0;
  input  [`DATA_WIDTH-1:0]     hwdata_m0;
  input                        hwrite_m0;
  input  [`HPROT_WIDTH-1:0]    hprot_m0;
  input  [`HMASTER_WIDTH-1:0]  hmaster_m0;
  input                        hnonsec_m0;
  output                       hready_m0;
  output [`HRESP_WIDTH-1:0]    hresp_m0;
  output [`DATA_WIDTH-1:0]     hrdata_m0;

  //-------------------------------------------------------------
  // AHB Slave Protocol Interface s0: Dataflow Interface Signals
  //-------------------------------------------------------------
  output [`HSEL_WIDTH-1:0]     hsel_s0;
  input  [`DATA_WIDTH-1:0]     hrdata_s0;
  input  [`HRESP_WIDTH-1:0]    hresp_s0;
  input                        hready_s0;
  output [`ADDR_WIDTH-1:0]     haddr_s0;
  output [`HBURST_WIDTH-1:0]   hburst_s0;
  output [`HSIZE_WIDTH-1:0]    hsize_s0;
  output [`HTRANS_WIDTH-1:0]   htrans_s0;
  output [`HPROT_WIDTH-1:0]    hprot_s0;
  output                       hwrite_s0;
  output [`DATA_WIDTH-1:0]     hwdata_s0;
  output                       hmastlock_s0;
  output [`HMASTER_WIDTH-1:0]  hmaster_s0;
  output                       hnonsec_s0;

  // ===================================================================================================
  // Appropriate inputs from AHB Interface m1 are connected to outputs on AHB Interface s1 and viceversa
  // ----------------------------------------------------------------------------------------------------

  assign haddr_s0         = haddr_m0; 
  assign hburst_s0        = hburst_m0;
  assign hsize_s0         = hsize_m0;
  assign htrans_s0        = htrans_m0;
  assign hwdata_s0        = hwdata_m0;
  assign hwrite_s0        = hwrite_m0;
  assign hprot_s0         = hprot_m0;
  assign hmastlock_s0     = hmastlock_m0;
  assign hnonsec_s0       = hnonsec_m0;
  assign hmaster_s0       = hmaster_m0;
  assign hready_m0        = hready_s0;
  assign hresp_m0         = hresp_s0;
  assign hrdata_m0        = hrdata_s0;

  assign hsel_s0          = 1'b1;

endmodule
// =============================================================================
`endif //AHB_DUT

