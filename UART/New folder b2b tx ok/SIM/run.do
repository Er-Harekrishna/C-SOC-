vlog ../UART_UVC/TB/uart_top.sv +incdir+../UART_UVC/TB +incdir+../UART_UVC/ENV +incdir+../UART_UVC/TEST +incdir+../UART_UVC/UART_TX_AGENT +incdir+../UART_UVC/UART_RX_AGENT +incdir+../UART_UVC/SEQS +incdir+../UART_UVC/SRC +define+THR_SIZE=8 +define+PWDATA_WIDTH=8 +UVM_OBJECTION_TRACE



vsim -novopt uart_top -l uart_txrx_cmd_case.log +UVM_TESTNAME=apb_uart_rx_read_with_cmd_test +data_bit=8 +baudrate=128000 +parity=1 +stp_bit=2

do wave.do
run -all



