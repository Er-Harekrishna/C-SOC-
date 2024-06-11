TARGET_DIR = ..\sim
SOURCE_FILES = ..\sim\TEST_WD\image.hex ..\sim\mem_data_tgl_test\image.hex

move:
	@$(shell) copy $(SOURCE_FILE) $(TARGET_DIR)

all:
	@for (f in $(SOURCE_FILES)); do\
		@$(shell) copy $(f) $(TARGET_DIR)\
	#	vsim -coverage -vopt cortexm3_soc_tb -c -do "coverage save -onexit -directive -cvg -codeall Test_01.ucdb; run -all;exit"
		done


comp:
	vlog -coveropt 3 +cover +acc ..\..\..\UART\UART_UVC\ENV\apb_defines.sv ..\..\..\UART\UART_UVC\ENV\uvc_pkg.sv  ..\..\..\AHB\tb\ahb_pkg.sv ..\tb\cortexm3_soc_tb.sv +incdir+..\rtl +incdir+..\..\cm3_matrix\rtl +incdir+..\..\cmsdk_ahb_to_sram\rtl +incdir+..\..\cmsdk_fpga_sram\verilog +incdir+..\..\CORTEXM3INTEGRATION\rtl +incdir+..\sim +incdir+..\tb  +incdir+..\..\..\AHB\mas_agent +incdir+..\..\..\AHB\slv_agent  +incdir+..\..\..\AHB\uvc +incdir+..\..\..\AHB\env +incdir+..\..\..\AHB\includes +incdir+..\..\..\AHB\src +incdir+..\..\..\AHB\test +incdir+..\..\..\AHB\seq +incdir+..\..\..\AHB\tb +incdir+..\..\..\AHB\HDL_interconnect +incdir+..\..\..\UART\UART_UVC\UART_TX_AGENT +incdir+..\..\..\UART\UART_UVC\UART_RX_AGENT +incdir+..\..\..\UART\UART_UVC\TEST +incdir+..\..\..\UART\UART_UVC\INCLUDE +incdir+..\..\..\UART\UART_UVC\SRC +incdir+..\..\..\UART\UART_UVC\TB +incdir+..\..\..\UART\UART_UVC\ENV +incdir+..\..\..\UART\TEST +incdir+..\..\AHB_APB-RTL +incdir+..\..\I2C +incdir+..\..\UART +incdir+..\..\MEMORY +define+THR_SIZE=8 +define+PWDATA_WIDTH=8 +UVM_OBJECTION_TRACE

qsim: comp
	vsim -vopt cortexm3_soc_tb +UVM_TESTNAME="ahb_base_test"

sim: comp
	vsim -vopt cortexm3_soc_tb -c -do "run -all;exit" +UVM_TESTNAME="ahb_base_test"

cov_sim1:
	vsim -coverage -vopt cortexm3_soc_tb -c -do "coverage save -onexit -directive -cvg -codeall Test_01.ucdb; run -all;exit"

cov_sim2:
	vsim -coverage -vopt cortexm3_soc_tb -c -do "coverage save -onexit -directive -cvg -codeall Test_02.ucdb; run -all;exit"

cov_sim3:
	vsim -coverage -vopt cortexm3_soc_tb -c -do "coverage save -onexit -directive -cvg -codeall Test_03.ucdb; run -all;exit"

cov_sim4:
	vsim -coverage -vopt cortexm3_soc_tb -c -do "coverage save -onexit -directive -cvg -codeall Test_04.ucdb; run -all;exit"

cov_sim5:
	vsim -coverage -vopt cortexm3_soc_tb -c -do "coverage save -onexit -directive -cvg -codeall Test_05.ucdb; run -all;exit"

cov_sim6:
	vsim -coverage -vopt cortexm3_soc_tb -c -do "coverage save -onexit -directive -cvg -codeall Test_06.ucdb; run -all;exit"

cov_sim7:
	vsim -coverage -vopt cortexm3_soc_tb -c -do "coverage save -onexit -directive -cvg -codeall Test_07.ucdb; run -all;exit"

cov_sim_uart1:
	vsim -coverage -vopt cortexm3_soc_tb -c -do "coverage save -onexit -directive -cvg -codeall uart_01.ucdb; run -all;exit" +UVM_TESTNAME="ahb_base_test"

cov_sim_uart2:
	vsim -coverage -vopt cortexm3_soc_tb -c -do "coverage save -onexit -directive -cvg -codeall uart_02.ucdb; run -all;exit" +UVM_TESTNAME="ahb_base_test"

cov_sim_uart3:
	vsim -coverage -vopt cortexm3_soc_tb -c -do "coverage save -onexit -directive -cvg -codeall uart_03.ucdb; run -all;exit" +UVM_TESTNAME="ahb_base_test"

cov_sim_uart4:
	vsim -coverage -vopt cortexm3_soc_tb -c -do "coverage save -onexit -directive -cvg -codeall uart_04.ucdb; run -all;exit" +UVM_TESTNAME="ahb_base_test"

cov_sim_uart5:
	vsim -coverage -vopt cortexm3_soc_tb -c -do "coverage save -onexit -directive -cvg -codeall uart_05.ucdb; run -all;exit" +UVM_TESTNAME="ahb_base_test"

cov_sim_uart6:
	vsim -coverage -vopt cortexm3_soc_tb -c -do "coverage save -onexit -directive -cvg -codeall uart_06.ucdb; run -all;exit" +UVM_TESTNAME="ahb_base_test"

cov_sim_uart7:
	vsim -coverage -vopt cortexm3_soc_tb -c -do "coverage save -onexit -directive -cvg -codeall uart_07.ucdb; run -all;exit" +UVM_TESTNAME="ahb_base_test"

cov_sim_uart8:
	vsim -coverage -vopt cortexm3_soc_tb -c -do "coverage save -onexit -directive -cvg -codeall uart_08.ucdb; run -all;exit" +UVM_TESTNAME="ahb_base_test"

cov_sim_uart9:
	vsim -coverage -vopt cortexm3_soc_tb -c -do "coverage save -onexit -directive -cvg -codeall uart_09.ucdb; run -all;exit" +UVM_TESTNAME="ahb_base_test"

cov_sim_uart10:
	vsim -coverage -vopt cortexm3_soc_tb -c -do "coverage save -onexit -directive -cvg -codeall uart_10.ucdb; run -all;exit" +UVM_TESTNAME="ahb_base_test"

cov_sim_uart11:
	vsim -coverage -vopt cortexm3_soc_tb -c -do "coverage save -onexit -directive -cvg -codeall uart_11.ucdb; run -all;exit" +UVM_TESTNAME="ahb_base_test"

cov_rep:
	vcover merge merge.ucdb Test_01.ucdb Test_02.ucdb Test_03.ucdb Test_04.ucdb Test_05.ucdb Test_06.ucdb
	vcover report -html -htmldir COVERAGE merge.ucdb 

cov_uart_rep:
	vcover merge merge.ucdb uart_01.ucdb uart_02.ucdb uart_03.ucdb uart_04.ucdb uart_05.ucdb uart_06.ucdb uart_07.ucdb uart_08.ucdb uart_09.ucdb uart_10.ucdb uart_11.ucdb  
	vcover report -html -htmldir COVERAGE_UART merge.ucdb 

cov_sim: comp
	vsim -coverage -vopt cortexm3_soc_tb -c -do "coverage save -onexit -directive -cvg -codeall Test_01.ucdb; run -all;exit" +HEXFILE="image01.hex"
	vsim -coverage -vopt cortexm3_soc_tb -c -do "coverage save -onexit -directive -cvg -codeall Test_02.ucdb; run -all;exit" +HEXFILE="image02.hex"
	vsim -coverage -vopt cortexm3_soc_tb -c -do "coverage save -onexit -directive -cvg -codeall Test_03.ucdb; run -all;exit" +HEXFILE="image03.hex"
	vcover merge merge.ucdb Test_01.ucdb Test_02.ucdb Test_03.ucdb
	vcover report -html -htmldir COVERAGE merge.ucdb 

logsim: comp
	vsim -vopt cortexm3_soc_tb -c -do "run -all;exit" >sim.log
	
