
import uvm_pkg::*;
`include "uvm_macros.svh"

//`include "common_if.sv"
`include "cm3_outM0.v"
`include "cm3_outM1.v"
`include "cm3_outM2.v"
`include "cm3_outM3.v"
`include "cm3_matrix_default_slave.v"
`include "cmsdk_MyArbiterNameM0.v"
`include "cmsdk_MyArbiterNameM1.v"
`include "cmsdk_MyArbiterNameM2.v"
`include "cmsdk_MyArbiterNameM3.v"
`include "cmsdk_MyDecoderNameS0.v"
`include "cmsdk_MyDecoderNameS1.v"
`include "cmsdk_MyDecoderNameS3.v"
`include "cmsdk_MyDecoderNameS4.v"
`include "cmsdk_MyDecoderNameS5.v"
`include "cm3_matrix.v"
`include "cm3_matrix_lite.v"
`include "cm3_in.v"

`include "cmsdk_ahb_to_sram.v"

`include "cmsdk_fpga_sram.v"

`include "cortexm3ds_logic.v"
`include "CORTEXM3INTEGRATIONDS.v"

`include "cortexm3_soc.v"

`include "ahb_defines.sv"
`include "ahb_dut.v"
`include "ahb_dut_wrapper.sv"

`include "top_rtl.v"
`include "apb_memory.v"
`include "i2c.v"
`include "apb_uart.sv"

`include "apb_defines.sv"
`include "uart_interface.sv"

module cortexm3_soc_tb();

  reg HCLK;
  reg HRESETn;

  wire TX_o_AU,RX_i_AU;

  /** Import the AHB VIP */
  import ahb_pkg::*;
  `include "ahb_base_test.sv"

  import uvc_pkg::*;

  initial begin
    HCLK = 0;
    HRESETn = 0;
    #103 HRESETn = 1;
   // #39647 HRESETn = 0;
   // #150 HRESETn = 1;
  end
  
  always #10 HCLK = ~HCLK;

  cortexm3_soc cortexm3_soc_i0 (.HCLK(HCLK),
                                .HRESETn(HRESETn),
			        .TX_o_AU(TX_o_AU),
				.RX_i_AU(RX_i_AU));

  assign RX_i_AU = TX_o_AU;

  ahb_inf  sram_ahb_inf();
  sram_inf sram_if(HCLK);

  assign sram_ahb_inf.hclk = HCLK;
  
  always@(*) sram_ahb_inf.hresetn = HRESETn; 

  //M0
  always@(*) sram_ahb_inf.mas_if[0].HSEL      = cortexm3_soc_i0.HSELM0;
  always@(*) sram_ahb_inf.mas_if[0].HADDR     = cortexm3_soc_i0.HADDRM0;
  always@(*) sram_ahb_inf.mas_if[0].HTRANS    = cortexm3_soc_i0.HTRANSM0;
  always@(*) sram_ahb_inf.mas_if[0].HBURST    = cortexm3_soc_i0.HBURSTM0;
  always@(*) sram_ahb_inf.mas_if[0].HPROT     = cortexm3_soc_i0.HPROTM0;
  always@(*) sram_ahb_inf.mas_if[0].HMASTLOCK = cortexm3_soc_i0.HMASTLOCKM0;
  always@(*) sram_ahb_inf.mas_if[0].HWRITE    = cortexm3_soc_i0.HWRITEM0;
  always@(*) sram_ahb_inf.mas_if[0].HSIZE     = cortexm3_soc_i0.HSIZEM0;
  always@(*) sram_ahb_inf.mas_if[0].HWDATA    = cortexm3_soc_i0.HWDATAM0;
  always@(*) sram_ahb_inf.mas_if[0].HRDATA    = cortexm3_soc_i0.HRDATAM0;
  always@(*) sram_ahb_inf.mas_if[0].HREADY    = cortexm3_soc_i0.HREADYOUTM0;
  always@(*) sram_ahb_inf.mas_if[0].HRESP     = cortexm3_soc_i0.HRESPM0;

  //M1
  always@(*) sram_ahb_inf.mas_if[1].HSEL      = cortexm3_soc_i0.HSELM1;
  always@(*) sram_ahb_inf.mas_if[1].HADDR     = cortexm3_soc_i0.HADDRM1;
  always@(*) sram_ahb_inf.mas_if[1].HTRANS    = cortexm3_soc_i0.HTRANSM1;
  always@(*) sram_ahb_inf.mas_if[1].HBURST    = cortexm3_soc_i0.HBURSTM1;
  always@(*) sram_ahb_inf.mas_if[1].HPROT     = cortexm3_soc_i0.HPROTM1;
  always@(*) sram_ahb_inf.mas_if[1].HMASTLOCK = cortexm3_soc_i0.HMASTLOCKM1;
  always@(*) sram_ahb_inf.mas_if[1].HWRITE    = cortexm3_soc_i0.HWRITEM1;
  always@(*) sram_ahb_inf.mas_if[1].HSIZE     = cortexm3_soc_i0.HSIZEM1;
  always@(*) sram_ahb_inf.mas_if[1].HWDATA    = cortexm3_soc_i0.HWDATAM1;
  always@(*) sram_ahb_inf.mas_if[1].HRDATA    = cortexm3_soc_i0.HRDATAM1;
  always@(*) sram_ahb_inf.mas_if[1].HREADY    = cortexm3_soc_i0.HREADYOUTM1;
  always@(*) sram_ahb_inf.mas_if[1].HRESP     = cortexm3_soc_i0.HRESPM1;

  //M2
  always@(*) sram_ahb_inf.mas_if[2].HSEL      = cortexm3_soc_i0.HSELM2;
  always@(*) sram_ahb_inf.mas_if[2].HADDR     = cortexm3_soc_i0.HADDRM2;
  always@(*) sram_ahb_inf.mas_if[2].HTRANS    = cortexm3_soc_i0.HTRANSM2;
  always@(*) sram_ahb_inf.mas_if[2].HBURST    = cortexm3_soc_i0.HBURSTM2;
  always@(*) sram_ahb_inf.mas_if[2].HPROT     = cortexm3_soc_i0.HPROTM2;
  always@(*) sram_ahb_inf.mas_if[2].HMASTLOCK = cortexm3_soc_i0.HMASTLOCKM2;
  always@(*) sram_ahb_inf.mas_if[2].HWRITE    = cortexm3_soc_i0.HWRITEM2;
  always@(*) sram_ahb_inf.mas_if[2].HSIZE     = cortexm3_soc_i0.HSIZEM2;
  always@(*) sram_ahb_inf.mas_if[2].HWDATA    = cortexm3_soc_i0.HWDATAM2;
  always@(*) sram_ahb_inf.mas_if[2].HRDATA    = cortexm3_soc_i0.HRDATAM2;
  always@(*) sram_ahb_inf.mas_if[2].HREADY    = cortexm3_soc_i0.HREADYOUTM2;
  always@(*) sram_ahb_inf.mas_if[2].HRESP     = cortexm3_soc_i0.HRESPM2;

  //M3
  always@(*) sram_ahb_inf.mas_if[3].HSEL      = cortexm3_soc_i0.HSELM3;
  always@(*) sram_ahb_inf.mas_if[3].HADDR     = cortexm3_soc_i0.HADDRM3;
  always@(*) sram_ahb_inf.mas_if[3].HTRANS    = cortexm3_soc_i0.HTRANSM3;
  always@(*) sram_ahb_inf.mas_if[3].HBURST    = cortexm3_soc_i0.HBURSTM3;
  always@(*) sram_ahb_inf.mas_if[3].HPROT     = cortexm3_soc_i0.HPROTM3;
  always@(*) sram_ahb_inf.mas_if[3].HMASTLOCK = cortexm3_soc_i0.HMASTLOCKM3;
  always@(*) sram_ahb_inf.mas_if[3].HWRITE    = cortexm3_soc_i0.HWRITEM3;
  always@(*) sram_ahb_inf.mas_if[3].HSIZE     = cortexm3_soc_i0.HSIZEM3;
  always@(*) sram_ahb_inf.mas_if[3].HWDATA    = cortexm3_soc_i0.HWDATAM3;
  always@(*) sram_ahb_inf.mas_if[3].HRDATA    = cortexm3_soc_i0.HRDATAM3;
  always@(*) sram_ahb_inf.mas_if[3].HREADY    = cortexm3_soc_i0.HREADYOUTM3;
  always@(*) sram_ahb_inf.mas_if[3].HRESP     = cortexm3_soc_i0.HRESPM3;

  //AHB_TO_SRAMS
  always@(*) sram_ahb_inf.mas_if[4].HSEL      = cortexm3_soc_i0.HSEL_SRAMS;
  always@(*) sram_ahb_inf.mas_if[4].HADDR     = cortexm3_soc_i0.HADDR_SRAMS;
  always@(*) sram_ahb_inf.mas_if[4].HTRANS    = cortexm3_soc_i0.HTRANS_SRAMS;
  //always@(*) sram_ahb_inf.mas_if[4].HBURST    = cortexm3_soc_i0.HBURST_SRAMS;
  //always@(*) sram_ahb_inf.mas_if[4].HPROT     = cortexm3_soc_i0.HPROT_SRAMS;
  //always@(*) sram_ahb_inf.mas_if[4].HMASTLOCK = cortexm3_soc_i0.HMASTLOCK_SRAMS;
  always@(*) sram_ahb_inf.mas_if[4].HWRITE    = cortexm3_soc_i0.HWRITE_SRAMS;
  always@(*) sram_ahb_inf.mas_if[4].HSIZE     = cortexm3_soc_i0.HSIZE_SRAMS;
  always@(*) sram_ahb_inf.mas_if[4].HWDATA    = cortexm3_soc_i0.HWDATA_SRAMS;
  always@(*) sram_ahb_inf.mas_if[4].HRDATA    = cortexm3_soc_i0.HRDATA_SRAMS;
  always@(*) sram_ahb_inf.mas_if[4].HREADY    = cortexm3_soc_i0.HREADYOUT_SRAMS;
  always@(*) sram_ahb_inf.mas_if[4].HRESP     = cortexm3_soc_i0.HRESP_SRAMS;

  //SRAMS
  always@(*) sram_if.SRAMCS    = cortexm3_soc_i0.CS_SRAMS;
  always@(*) sram_if.SRAMWEN   = cortexm3_soc_i0.WREN_SRAMS;
  always@(*) sram_if.SRAMADDR  = cortexm3_soc_i0.ADDR_SRAMS;
  always@(*) sram_if.SRAMWDATA = cortexm3_soc_i0.WDATA_SRAMS;
  always@(*) sram_if.SRAMRDATA = cortexm3_soc_i0.RDATA_SRAMS;

  //S0 
  always@(*) sram_ahb_inf.slv_if[0].HADDR     = cortexm3_soc_i0.HADDRS0;
  always@(*) sram_ahb_inf.slv_if[0].HTRANS    = cortexm3_soc_i0.HTRANSS0;
  always@(*) sram_ahb_inf.slv_if[0].HBURST    = cortexm3_soc_i0.HBURSTS0;
  always@(*) sram_ahb_inf.slv_if[0].HPROT     = cortexm3_soc_i0.HPROTS0;
  always@(*) sram_ahb_inf.slv_if[0].HMASTLOCK = cortexm3_soc_i0.HMASTLOCKS0;
  always@(*) sram_ahb_inf.slv_if[0].HWRITE    = cortexm3_soc_i0.HWRITES0;
  always@(*) sram_ahb_inf.slv_if[0].HSIZE     = cortexm3_soc_i0.HSIZES0;
  always@(*) sram_ahb_inf.slv_if[0].HWDATA    = cortexm3_soc_i0.HWDATAS0;
  always@(*) sram_ahb_inf.slv_if[0].HRDATA    = cortexm3_soc_i0.HRDATAS0;
  always@(*) sram_ahb_inf.slv_if[0].HREADY_IN = cortexm3_soc_i0.HREADYS0;
  always@(*) sram_ahb_inf.slv_if[0].HRESP     = cortexm3_soc_i0.HRESPS0;

  //S1
  always@(*) sram_ahb_inf.slv_if[1].HADDR     = cortexm3_soc_i0.HADDRS1;
  always@(*) sram_ahb_inf.slv_if[1].HTRANS    = cortexm3_soc_i0.HTRANSS1;
  always@(*) sram_ahb_inf.slv_if[1].HBURST    = cortexm3_soc_i0.HBURSTS1;
  always@(*) sram_ahb_inf.slv_if[1].HPROT     = cortexm3_soc_i0.HPROTS1;
  always@(*) sram_ahb_inf.slv_if[1].HMASTLOCK = cortexm3_soc_i0.HMASTLOCKS1;
  always@(*) sram_ahb_inf.slv_if[1].HWRITE    = cortexm3_soc_i0.HWRITES1;
  always@(*) sram_ahb_inf.slv_if[1].HSIZE     = cortexm3_soc_i0.HSIZES1;
  always@(*) sram_ahb_inf.slv_if[1].HWDATA    = cortexm3_soc_i0.HWDATAS1;
  always@(*) sram_ahb_inf.slv_if[1].HRDATA    = cortexm3_soc_i0.HRDATAS1;
  always@(*) sram_ahb_inf.slv_if[1].HREADY_IN = cortexm3_soc_i0.HREADYS1;
  always@(*) sram_ahb_inf.slv_if[1].HRESP     = cortexm3_soc_i0.HRESPS1;

  //S3
  always@(*) sram_ahb_inf.slv_if[2].HADDR     = cortexm3_soc_i0.HADDRS3;
  always@(*) sram_ahb_inf.slv_if[2].HTRANS    = cortexm3_soc_i0.HTRANSS3;
  always@(*) sram_ahb_inf.slv_if[2].HBURST    = cortexm3_soc_i0.HBURSTS3;
  always@(*) sram_ahb_inf.slv_if[2].HPROT     = cortexm3_soc_i0.HPROTS3;
  always@(*) sram_ahb_inf.slv_if[2].HMASTLOCK = cortexm3_soc_i0.HMASTLOCKS3;
  always@(*) sram_ahb_inf.slv_if[2].HWRITE    = cortexm3_soc_i0.HWRITES3;
  always@(*) sram_ahb_inf.slv_if[2].HSIZE     = cortexm3_soc_i0.HSIZES3;
  always@(*) sram_ahb_inf.slv_if[2].HWDATA    = cortexm3_soc_i0.HWDATAS3;
  always@(*) sram_ahb_inf.slv_if[2].HRDATA    = cortexm3_soc_i0.HRDATAS3;
  always@(*) sram_ahb_inf.slv_if[2].HREADY_IN = cortexm3_soc_i0.HREADYS3;
  always@(*) sram_ahb_inf.slv_if[2].HRESP     = cortexm3_soc_i0.HRESPS3;

  //S4
  always@(*) sram_ahb_inf.slv_if[3].HADDR     = cortexm3_soc_i0.HADDRS4;
  always@(*) sram_ahb_inf.slv_if[3].HTRANS    = cortexm3_soc_i0.HTRANSS4;
  always@(*) sram_ahb_inf.slv_if[3].HBURST    = cortexm3_soc_i0.HBURSTS4;
  always@(*) sram_ahb_inf.slv_if[3].HPROT     = cortexm3_soc_i0.HPROTS4;
  always@(*) sram_ahb_inf.slv_if[3].HMASTLOCK = cortexm3_soc_i0.HMASTLOCKS4;
  always@(*) sram_ahb_inf.slv_if[3].HWRITE    = cortexm3_soc_i0.HWRITES4;
  always@(*) sram_ahb_inf.slv_if[3].HSIZE     = cortexm3_soc_i0.HSIZES4;
  always@(*) sram_ahb_inf.slv_if[3].HWDATA    = cortexm3_soc_i0.HWDATAS4;
  always@(*) sram_ahb_inf.slv_if[3].HRDATA    = cortexm3_soc_i0.HRDATAS4;
  always@(*) sram_ahb_inf.slv_if[3].HREADY_IN = cortexm3_soc_i0.HREADYS4;
  always@(*) sram_ahb_inf.slv_if[3].HRESP     = cortexm3_soc_i0.HRESPS4;

  //S5
  always@(*) sram_ahb_inf.slv_if[4].HADDR     = cortexm3_soc_i0.HADDRS5;
  always@(*) sram_ahb_inf.slv_if[4].HTRANS    = cortexm3_soc_i0.HTRANSS5;
  always@(*) sram_ahb_inf.slv_if[4].HBURST    = cortexm3_soc_i0.HBURSTS5;
  always@(*) sram_ahb_inf.slv_if[4].HPROT     = cortexm3_soc_i0.HPROTS5;
  always@(*) sram_ahb_inf.slv_if[4].HMASTLOCK = cortexm3_soc_i0.HMASTLOCKS5;
  always@(*) sram_ahb_inf.slv_if[4].HWRITE    = cortexm3_soc_i0.HWRITES5;
  always@(*) sram_ahb_inf.slv_if[4].HSIZE     = cortexm3_soc_i0.HSIZES5;
  always@(*) sram_ahb_inf.slv_if[4].HWDATA    = cortexm3_soc_i0.HWDATAS5;
  always@(*) sram_ahb_inf.slv_if[4].HRDATA    = cortexm3_soc_i0.HRDATAS5;
  always@(*) sram_ahb_inf.slv_if[4].HREADY_IN = cortexm3_soc_i0.HREADYS5;
  always@(*) sram_ahb_inf.slv_if[4].HRESP     = cortexm3_soc_i0.HRESPS5;

  uart_interface  uinf_master(HCLK,HRESETn);
  uart_interface  uinf_slave(HCLK,HRESETn);
  
  always @(*) uinf_master.rxd = cortexm3_soc_i0.TX_o_AU;
  always @(*) uinf_slave.rxd = cortexm3_soc_i0.RX_i_AU;

  initial begin

    uvm_config_db #(virtual ahb_inf)::set(null,"*","inf",sram_ahb_inf);
    
    uvm_config_db #(virtual ahb_mas_inf)::set(null,"*.env_h.ahb_uvc_h[0].mas_agent_h[0]*","mas_vif",sram_ahb_inf.mas_if[0]);	  
    uvm_config_db #(virtual ahb_mas_inf)::set(null,"*.env_h.ahb_uvc_h[0].mas_agent_h[1]*","mas_vif",sram_ahb_inf.mas_if[1]);	  
    uvm_config_db #(virtual ahb_mas_inf)::set(null,"*.env_h.ahb_uvc_h[0].mas_agent_h[2]*","mas_vif",sram_ahb_inf.mas_if[2]);	  
    uvm_config_db #(virtual ahb_mas_inf)::set(null,"*.env_h.ahb_uvc_h[0].mas_agent_h[3]*","mas_vif",sram_ahb_inf.mas_if[3]);	  
    uvm_config_db #(virtual ahb_mas_inf)::set(null,"*.env_h.ahb_uvc_h[0].mas_agent_h[4]*","mas_vif",sram_ahb_inf.mas_if[4]);	  
    

    uvm_config_db #(virtual ahb_slv_inf)::set(null,"*.env_h.ahb_uvc_h[0].slv_agent_h[0]*","slv_vif",sram_ahb_inf.slv_if[0]);	  
    uvm_config_db #(virtual ahb_slv_inf)::set(null,"*.env_h.ahb_uvc_h[0].slv_agent_h[1]*","slv_vif",sram_ahb_inf.slv_if[1]);	  
    uvm_config_db #(virtual ahb_slv_inf)::set(null,"*.env_h.ahb_uvc_h[0].slv_agent_h[2]*","slv_vif",sram_ahb_inf.slv_if[2]);	  
    uvm_config_db #(virtual ahb_slv_inf)::set(null,"*.env_h.ahb_uvc_h[0].slv_agent_h[3]*","slv_vif",sram_ahb_inf.slv_if[3]);	  
    uvm_config_db #(virtual ahb_slv_inf)::set(null,"*.env_h.ahb_uvc_h[0].slv_agent_h[4]*","slv_vif",sram_ahb_inf.slv_if[4]);	  
    
    uvm_config_db #(virtual sram_inf)::set(null,"*","sram_if",sram_if);	  
       
    uvm_config_db#(virtual uart_interface)::set(null,"*.env_hh*","mas_vif",uinf_master); 
    uvm_config_db#(virtual uart_interface)::set(null,"*.env_hh*","slv_vif",uinf_slave); 
    
    run_test();  

  end

endmodule
