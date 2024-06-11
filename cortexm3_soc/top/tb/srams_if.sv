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

`ifndef SRAM_INTERFACE
`define SRAM_INTERFACE

interface sram_inf (input bit HCLK);    
   
  logic                  SRAMCS;
  logic [3:0]            SRAMWEN;
  logic [9:0]            SRAMADDR;
  logic [31:0]           SRAMWDATA;
  logic [31:0]           SRAMRDATA;

  //-----------------------------------------------------------------------
  // Modports
  //-----------------------------------------------------------------------
  
  //------------------------------------------------------------------------
  /** Modport used to connect the VIP Master to AHB interface signals. */
  //modport ahb_mas_drv_mp (clocking ahb_mas_drv_cb,input hresetn);

  //-----------------------------------------------------------------------
  /** Modport used to connect the VIP Monitor to AHB interface signals. */
  //modport ahb_mas_mon_mp (clocking ahb_mas_mon_cb,input hresetn);

endinterface

`endif //SRAM_INTERFACE
