/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  NAME      :- Pradip Prajapati
//  FILE_NAME :- ahb_dut_wrapper.sv
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

/** 
 * Abstract: A HDL Interconnect wrapper that connects the HDL
 * Interconnect to the interface.
 *
 */

`ifndef AHB_DUT_WRAPPER
`define AHB_DUT_WRAPPER

`include "ahb_inf.sv"

module ahb_dut_wrapper (ahb_inf ahb_if);

  ahb_dut dut (
    .hclk           (ahb_if.hclk),
    .hresetn        (ahb_if.hresetn),
    
    /* Master side of ahb protocol interface signals.
     */
    .haddr_m0       (ahb_if.mas_if[0].HADDR),
    .hburst_m0      (ahb_if.mas_if[0].HBURST),
    .hmastlock_m0   (ahb_if.mas_if[0].HMASTLOCK),
    .hsize_m0       (ahb_if.mas_if[0].HSIZE),
    .htrans_m0      (ahb_if.mas_if[0].HTRANS),
    .hwdata_m0      (ahb_if.mas_if[0].HWDATA),
    .hwrite_m0      (ahb_if.mas_if[0].HWRITE),
    .hprot_m0       (ahb_if.mas_if[0].HPROT),
    .hready_m0      (ahb_if.mas_if[0].HREADY),
    .hresp_m0       (ahb_if.mas_if[0].HRESP),
    .hrdata_m0      (ahb_if.mas_if[0].HRDATA),
    .hmaster_m0     (ahb_if.mas_if[0].HMASTER),
    .hnonsec_m0     (ahb_if.mas_if[0].HNONSEC),

    /* Slave side of ahb protocol interface signals.
     */
    .hsel_s0        (ahb_if.slv_if[0].HSEL),
    .hrdata_s0      (ahb_if.slv_if[0].HRDATA),
    .hresp_s0       (ahb_if.slv_if[0].HRESP),
    .hready_s0      (ahb_if.slv_if[0].HREADYOUT),
    .haddr_s0       (ahb_if.slv_if[0].HADDR),
    .hburst_s0      (ahb_if.slv_if[0].HBURST),
    .hsize_s0       (ahb_if.slv_if[0].HSIZE),
    .htrans_s0      (ahb_if.slv_if[0].HTRANS),
    .hprot_s0       (ahb_if.slv_if[0].HPROT),
    .hwrite_s0      (ahb_if.slv_if[0].HWRITE),
    .hwdata_s0      (ahb_if.slv_if[0].HWDATA),
    .hmastlock_s0   (ahb_if.slv_if[0].HMASTLOCK),
    .hmaster_s0     (ahb_if.slv_if[0].HMASTER),
    .hnonsec_s0     (ahb_if.slv_if[0].HNONSEC) 
    );

   assign ahb_if.slv_if[0].HREADY_IN = dut.hready_s0;

endmodule

`endif //AHB_DUT_WRAPPER
