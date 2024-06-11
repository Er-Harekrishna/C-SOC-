
RTL = ../APB_UART_PROTOCOL/RTL/apb_uart_sv.sv
TB = ../APB_UART_PROTOCOL/APB_UART_TOP/apb_top.sv

lib:
	vlib work

comp:
	vlog ../APB_UART_PROTOCOL/APB_UART_TOP/apb_top.sv ../APB_UART_PROTOCOL/RTL/apb_uart_sv.sv +incdir../APB_UART_PROTOCOL/APB_ENV +incdir+../APB_UART_PROTOCOL/APB_ENV +incdir../APB_UART_PROTOCOL/RTL +incdir../APB_UART_PROTOCOL/TEST +incdir+../APB_UART_PROTOCOL/UART_UVC/UART_TX_AGENT +incdir+../APB_UART_PROTOCOL/UART_UVC/UART_RX_AGENT +incdir+../APB_UART_PROTOCOL/UART_UVC/SEQS ../APB_UART_PROTOCOL/APB_ENV/apb_pkg.sv ../APB_UART_PROTOCOL/RTL/io_generic_fifo.sv ../APB_UART_PROTOCOL/RTL/uart_interrupt.sv ../APB_UART_PROTOCOL/RTL/uart_rx.sv +incdir+../APB_UART_PROTOCOL/UART_UVC/TEST ../APB_UART_PROTOCOL/RTL/uart_tx.sv +incdir+../APB_UART_PROTOCOL/UART_UVC/INCLUDE +incdir+../APB_UART_PROTOCOL/UART_UVC/SRC +incdir+../APB_UART_PROTOCOL/UART_UVC/TB +incdir+../APB_UART_PROTOCOL/UART_UVC/ENV +incdir+../APB_UART_PROTOCOL/TEST +define+THR_SIZE=8 +define+PWDATA_WIDTH=8 +UVM_OBJECTION_TRACE


sim:	
	vsim -novopt apb_top -l apb_tx_rx_case.log +UVM_TESTNAME=apb_uart_tx_rx_write_read_with_cmd_test +data_bit=5 +baudrate=9600 +parity=1 +stp_bit=2
	vsim -novopt apb_top -l apb_tx_rx_case.log +UVM_TESTNAME=apb_uart_tx_rx_write_read_with_cmd_test +data_bit=5 +baudrate=56000 +parity=1 +stp_bit=2
	vsim -novopt apb_top -l apb_tx_rx_case.log +UVM_TESTNAME=apb_uart_tx_rx_write_read_with_cmd_test +data_bit=5 +baudrate=2400 +parity=1 +stp_bit=2
	vsim -novopt apb_top -l apb_tx_rx_case.log +UVM_TESTNAME=apb_uart_tx_rx_write_read_with_cmd_test +data_bit=5 +baudrate=4800 +parity=1 +stp_bit=2
	vsim -novopt apb_top -l apb_tx_rx_case.log +UVM_TESTNAME=apb_uart_tx_rx_write_read_with_cmd_test +data_bit=5 +baudrate=19200 +parity=1 +stp_bit=2
	vsim -novopt apb_top -l apb_tx_rx_case.log +UVM_TESTNAME=apb_uart_tx_rx_write_read_with_cmd_test +data_bit=5 +baudrate=38400 +parity=1 +stp_bit=2
	vsim -novopt apb_top -l apb_tx_rx_case.log +UVM_TESTNAME=apb_uart_tx_rx_write_read_with_cmd_test +data_bit=5 +baudrate=128000 +parity=1 +stp_bit=2
	vsim -novopt apb_top -l apb_tx_rx_case.log +UVM_TESTNAME=apb_uart_tx_rx_write_read_with_cmd_test +data_bit=5 +baudrate=3000000 +parity=1 +stp_bit=2





#	vsim -novopt apb_top +UVM_TESTNAME=apb_uart_tx_rx_write_read_with_cmd_test +data_bit=8 +baudrate=128000 +parity=0 +stp_bit=2
#	vsim -novopt apb_top +UVM_TESTNAME=apb_uart_rx_read_with_cmd_test +data_bit=8 +baudrate=128000 +parity=1 +stp_bit=2
#	vsim -novopt apb_top +UVM_TESTNAME=apb_uart_tx_write_with_cmd_test +data_bit=8 +baudrate=128000 +parity=1 +stp_bit=2
#	vsim -novopt apb_top +UVM_TESTNAME=apb_uart_tx_write_tx_fifo_clear_test +data_bit=8 +baudrate=128000 +parity=1 +stp_bit=2


sim:
	vsim -novopt apb_top +UVM_TESTNAME=apb_uart_tx_rx_write_read_with_cmd_test +data_bit=8 +baudrate=128000 +parity=0 +stp_bit=2
	vsim -novopt apb_top +UVM_TESTNAME=apb_uart_rx_read_with_cmd_test +data_bit=8 +baudrate=128000 +parity=1 +stp_bit=2
	vsim -novopt apb_top +UVM_TESTNAME=apb_uart_tx_write_with_cmd_test +data_bit=8 +baudrate=128000 +parity=1 +stp_bit=2
	vsim -novopt apb_top +UVM_TESTNAME=apb_uart_tx_write_tx_fifo_clear_test +data_bit=8 +baudrate=128000 +parity=1 +stp_bit=2


comp_cov:
	vlog -coveropt 3 +cover +acc $(RTL) $(TB)

regression:
	vsim -coverage -vopt apb_top -c -do "coverage save -onexit -directive -cvg -codeall TX_RX_TEST.ucdb; run -all; exit" +apb_uart_tx_rx_write_read_with_cmd_test +data_bit=8 +baudrate=9600 +parity=0 +stp_bit=2
	
	vsim -coverage -vopt apb_top -c -do "coverage save -onexit -directive -cvg -codeall RX_TEST.ucdb; run -all; exit" +apb_uart_rx_read_with_cmd_test +data_bit=8 +baudrate=128000 +parity=1 +stp_bit=2
	
	vsim -coverage -vopt apb_top -c -do "coverage save -onexit -directive -cvg -codeall TX_TEST.ucdb; run -all; exit" +apb_uart_tx_write_with_cmd_test +data_bit=8 +baudrate=54000 +parity=1 +stp_bit=2
	
	vsim -coverage -vopt apb_top -c -do "coverage save -onexit -directive -cvg -codeall TX_FIFO_CLR_TEST.ucdb; run -all; exit" +apb_uart_tx_write_tx_fifo_clear_test +data_bit=8 +baudrate=2400 +parity=1 +stp_bit=1


sim_all_test:
	vcover merge ven_merge_cov.ucdb TX_RX_TEST.ucdb RX_TEST.ucdb TX_TEST.ucdb TX_FIFO_CLR_TEST.ucdb

html:
	vcover report -html -htmldir Merge_Report ven_merge_cov.ucdb















	
