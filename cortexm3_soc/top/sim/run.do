vlog ../../../UART/UART_UVC/ENV/apb_defines.sv \
     ../../../UART/UART_UVC/ENV/uvc_pkg.sv \
     ../../../AHB/tb/ahb_pkg.sv \
     ../tb/cortexm3_soc_tb.sv +incdir+../rtl +incdir+../../cm3_matrix/rtl +incdir+../../cmsdk_ahb_to_sram/rtl +incdir+../../cmsdk_fpga_sram/verilog +incdir+../../CORTEXM3INTEGRATION/rtl +incdir+../sim +incdir+../tb +incdir+../../../AHB/mas_agent +incdir+../../../AHB/slv_agent +incdir+../../../AHB/uvc +incdir+../../../AHB/env +incdir+../../../AHB/includes +incdir+../../../AHB/src +incdir+../../../AHB/test +incdir+../../../AHB/seq +incdir+../../../AHB/tb +incdir+../../../AHB/HDL_interconnect +incdir+../../../UART/UART_UVC/UART_TX_AGENT +incdir+../../../UART/UART_UVC/UART_RX_AGENT +incdir+../../../UART/UART_UVC/TEST +incdir+../../../UART/UART_UVC/INCLUDE +incdir+../../../UART/UART_UVC/SRC +incdir+../../../UART/UART_UVC/TB +incdir+../../../UART/UART_UVC/ENV +incdir+../../../UART/TEST +incdir+../../AHB_APB-RTL +incdir+../../I2C +incdir+../../UART +incdir+../../MEMORY +define+THR_SIZE=8 +define+PWDATA_WIDTH=8 +UVM_OBJECTION_TRACE
vsim -novopt -suppress 12110 -l logfile.txt cortexm3_soc_tb
do wave.do
run -all

