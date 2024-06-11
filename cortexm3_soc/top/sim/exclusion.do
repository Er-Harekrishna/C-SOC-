coverage exclude -src ../../UART/uart_interrupt.sv -code s -line 78
coverage exclude -src ../../UART/uart_interrupt.sv -code b -line 77
coverage exclude -src ../../UART/uart_interrupt.sv -code c -line 77
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/mem_ip -togglenode {i[0]} \
{i[1]} {i[2]} {i[3]} {i[4]} {i[5]} {i[6]} {i[7]} {i[8]} {i[9]}
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/mem_ip -togglenode {i[10]} \
{i[11]} {i[12]} {i[13]} {i[14]} {i[15]} {i[16]} {i[17]} {i[18]} {i[19]}
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/mem_ip -togglenode {i[20]} \
{i[21]} {i[22]} {i[23]} {i[24]} {i[25]} {i[26]} {i[27]} {i[28]} {i[29]}
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/mem_ip -togglenode {i[30]} \
{i[31]}
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_interrupt_i \
-togglenode CTI_i
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/cmsdk_fpga_sram_S -togglenode \
{addr_q1[10]} {addr_q1[11]} {i[0]} {i[1]} {i[2]} {i[3]} {i[4]} {i[5]} {i[6]} {i[7]}
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/cmsdk_fpga_sram_S -togglenode \
{i[8]} {i[9]} {i[10]} {i[11]} {i[12]} {i[13]} {i[14]} {i[15]} {i[16]} {i[17]}
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/cmsdk_fpga_sram_S -togglenode \
{i[18]} {i[19]} {i[20]} {i[21]} {i[22]} {i[23]} {i[24]} {i[25]} {i[26]} {i[27]}
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/cmsdk_fpga_sram_S -togglenode \
{i[28]} {i[29]} {i[30]} {i[31]}
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0 -togglenode {ADDR_SRAMS[10]} \
{ADDR_SRAMS[11]}

coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode {PRDATA[8]} {PRDATA[9]} {PRDATA[10]} {PRDATA[11]} {PRDATA[12]} {PRDATA[13]} {PRDATA[14]} {PRDATA[15]} {PRDATA[16]} {PRDATA[17]} -comment "Uart only response with 8 bit data" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode {PRDATA[18]} {PRDATA[19]} {PRDATA[20]} {PRDATA[21]} {PRDATA[22]} {PRDATA[23]} {PRDATA[24]} {PRDATA[25]} {PRDATA[26]} {PRDATA[27]} -comment "Uart only response with 8 bit data" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode {PRDATA[28]} {PRDATA[29]} {PRDATA[30]} {PRDATA[31]} -comment "Uart only response with 8 bit data" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode {IIR_o[1]} -comment "character timeout indication imterrupt execution code has bug (CTI_i is hardcoded to 0)" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode {PRDATA[8]} {PRDATA[9]} {PRDATA[10]} {PRDATA[11]} {PRDATA[12]} {PRDATA[13]} {PRDATA[14]} {PRDATA[15]} {PRDATA[16]} {PRDATA[17]} -comment "Uart only response with 8 bit data" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode {PRDATA[18]} {PRDATA[19]} {PRDATA[20]} {PRDATA[21]} {PRDATA[22]} {PRDATA[23]} {PRDATA[24]} {PRDATA[25]} {PRDATA[26]} {PRDATA[27]} -comment "Uart only response with 8 bit data" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode {PRDATA[28]} {PRDATA[29]} {PRDATA[30]} {PRDATA[31]} -comment "Uart only response with 8 bit data" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode PREADY -comment "Pready assigned with hardcode 1'b1" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode PSLVERR -comment "Pslverr assigned hardcoded with 1'b0" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode apb_rx_ready -comment "hardcoded value" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode {clr_int[0]} {clr_int[1]} -comment "Interrupt clearing variable has only four values 4'b1000, 4'b0100, 4'b1100, 4'b0001." 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode {IIR_o[1]} -comment "character timeout indication imterrupt execution code has bug (CTI_i is hardcoded to 0)" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode {PRDATA[8]} {PRDATA[9]} {PRDATA[10]} {PRDATA[11]} {PRDATA[12]} {PRDATA[13]} {PRDATA[14]} {PRDATA[15]} {PRDATA[16]} {PRDATA[17]} -comment "Uart only response with 8 bit data" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode {PRDATA[18]} {PRDATA[19]} {PRDATA[20]} {PRDATA[21]} {PRDATA[22]} {PRDATA[23]} {PRDATA[24]} {PRDATA[25]} {PRDATA[26]} {PRDATA[27]} -comment "Uart only response with 8 bit data" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode {PRDATA[28]} {PRDATA[29]} {PRDATA[30]} {PRDATA[31]} -comment "Uart only response with 8 bit data" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode PREADY -comment "Pready assigned with hardcode 1'b1" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode PSLVERR -comment "Pslverr assigned hardcoded with 1'b0" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode apb_rx_ready -comment "hardcoded value" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode {clr_int[0]} {clr_int[1]} -comment "Interrupt clearing variable has only four values 4'b1000, 4'b0100, 4'b1100, 4'b0001." 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_i -src ../../UART/uart_rx.sv -code s -line 185 -comment "cfg_en_i is harcoded to 1. That's why CS goes only to NS." 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_i -src ../../UART/uart_rx.sv -code s -line 199 -comment "cfg_en_i is hardcoded to 1." 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_i -src ../../UART/uart_rx.sv -code b -line 184 -comment "cfg_en_i is harcoded to 1." 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_i -src ../../UART/uart_rx.sv -code b -line 198 -comment "cfg_en_i is harcoded to 1." 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_i -togglenode cfg_en_i -comment "hardcoded to 1" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode {IIR_o[1]} -comment "character timeout indication imterrupt execution code has bug (CTI_i is hardcoded to 0)" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode {PRDATA[8]} {PRDATA[9]} {PRDATA[10]} {PRDATA[11]} {PRDATA[12]} {PRDATA[13]} {PRDATA[14]} {PRDATA[15]} {PRDATA[16]} {PRDATA[17]} -comment "Uart only response with 8 bit data" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode {PRDATA[18]} {PRDATA[19]} {PRDATA[20]} {PRDATA[21]} {PRDATA[22]} {PRDATA[23]} {PRDATA[24]} {PRDATA[25]} {PRDATA[26]} {PRDATA[27]} -comment "Uart only response with 8 bit data" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode {PRDATA[28]} {PRDATA[29]} {PRDATA[30]} {PRDATA[31]} -comment "Uart only response with 8 bit data" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode PREADY -comment "Pready assigned with hardcode 1'b1" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode PSLVERR -comment "Pslverr assigned hardcoded with 1'b0" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode apb_rx_ready -comment "hardcoded value" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode {clr_int[0]} {clr_int[1]} -comment "Interrupt clearing variable has only four values 4'b1000, 4'b0100, 4'b1100, 4'b0001." 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_i -src ../../UART/uart_rx.sv -code s -line 185 -comment "cfg_en_i is harcoded to 1. That's why CS goes only to NS." 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_i -src ../../UART/uart_rx.sv -code s -line 199 -comment "cfg_en_i is hardcoded to 1." 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_i -src ../../UART/uart_rx.sv -code b -line 184 -comment "cfg_en_i is harcoded to 1." 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_i -src ../../UART/uart_rx.sv -code b -line 198 -comment "cfg_en_i is harcoded to 1." 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_i -togglenode cfg_en_i -comment "hardcoded to 1" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_i -togglenode err_clr_i -comment "hardcode to 1" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_tx_i -togglenode cfg_en_i -comment "hardcoded to 1" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode {IIR_o[1]} -comment "character timeout indication imterrupt execution code has bug (CTI_i is hardcoded to 0)" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode {PRDATA[8]} {PRDATA[9]} {PRDATA[10]} {PRDATA[11]} {PRDATA[12]} {PRDATA[13]} {PRDATA[14]} {PRDATA[15]} {PRDATA[16]} {PRDATA[17]} -comment "Uart only response with 8 bit data" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode {PRDATA[18]} {PRDATA[19]} {PRDATA[20]} {PRDATA[21]} {PRDATA[22]} {PRDATA[23]} {PRDATA[24]} {PRDATA[25]} {PRDATA[26]} {PRDATA[27]} -comment "Uart only response with 8 bit data" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode {PRDATA[28]} {PRDATA[29]} {PRDATA[30]} {PRDATA[31]} -comment "Uart only response with 8 bit data" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode PREADY -comment "Pready assigned with hardcode 1'b1" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode PSLVERR -comment "Pslverr assigned hardcoded with 1'b0" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode apb_rx_ready -comment "hardcoded value" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode {clr_int[0]} {clr_int[1]} -comment "Interrupt clearing variable has only four values 4'b1000, 4'b0100, 4'b1100, 4'b0001." 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_i -src ../../UART/uart_rx.sv -code s -line 185 -comment "cfg_en_i is harcoded to 1. That's why CS goes only to NS." 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_i -src ../../UART/uart_rx.sv -code s -line 199 -comment "cfg_en_i is hardcoded to 1." 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_i -src ../../UART/uart_rx.sv -code b -line 184 -comment "cfg_en_i is harcoded to 1." 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_i -src ../../UART/uart_rx.sv -code b -line 198 -comment "cfg_en_i is harcoded to 1." 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_i -togglenode cfg_en_i -comment "hardcoded to 1" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_i -togglenode err_clr_i -comment "hardcode to 1" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_tx_i -togglenode CS -comment "hardcoded" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_tx_i -togglenode cfg_en_i -comment "hardcoded to 1" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_interrupt_i -togglenode CTI_i -comment "hardcoded to 1" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_interrupt_i -togglenode {clr_int_i[0]} {clr_int_i[1]} {clr_int_i[2]} {clr_int_i[3]} -comment "only 2 upper bits valid for mapping" 
coverage exclude -src ../../UART/uart_interrupt.sv -code s -line 78
coverage exclude -src ../../UART/uart_interrupt.sv -code b -line 77
coverage exclude -src ../../UART/uart_interrupt.sv -code c -line 77
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0 -togglenode {ADDR_SRAMS[10]} {ADDR_SRAMS[11]}
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/cmsdk_fpga_sram_S -togglenode {addr_q1[10]} {addr_q1[11]} {i[0]} {i[1]} {i[2]} {i[3]} {i[4]} {i[5]} {i[6]} {i[7]}
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/cmsdk_fpga_sram_S -togglenode {i[8]} {i[9]} {i[10]} {i[11]} {i[12]} {i[13]} {i[14]} {i[15]} {i[16]} {i[17]}
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/cmsdk_fpga_sram_S -togglenode {i[18]} {i[19]} {i[20]} {i[21]} {i[22]} {i[23]} {i[24]} {i[25]} {i[26]} {i[27]}
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/cmsdk_fpga_sram_S -togglenode {i[28]} {i[29]} {i[30]} {i[31]}
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode {IIR_o[1]} -comment "character timeout indication imterrupt execution code has bug (CTI_i is hardcoded to 0)" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode {PRDATA[8]} {PRDATA[9]} {PRDATA[10]} {PRDATA[11]} {PRDATA[12]} {PRDATA[13]} {PRDATA[14]} {PRDATA[15]} {PRDATA[16]} {PRDATA[17]} -comment "Uart only response with 8 bit data" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode {PRDATA[18]} {PRDATA[19]} {PRDATA[20]} {PRDATA[21]} {PRDATA[22]} {PRDATA[23]} {PRDATA[24]} {PRDATA[25]} {PRDATA[26]} {PRDATA[27]} -comment "Uart only response with 8 bit data" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode {PRDATA[28]} {PRDATA[29]} {PRDATA[30]} {PRDATA[31]} -comment "Uart only response with 8 bit data" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode PREADY -comment "Pready assigned with hardcode 1'b1" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode PSLVERR -comment "Pslverr assigned hardcoded with 1'b0" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode apb_rx_ready -comment "hardcoded value" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode {clr_int[0]} {clr_int[1]} -comment "Interrupt clearing variable has only four values 4'b1000, 4'b0100, 4'b1100, 4'b0001." 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_i -src ../../UART/uart_rx.sv -code s -line 185 -comment "cfg_en_i is harcoded to 1. That's why CS goes only to NS." 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_i -src ../../UART/uart_rx.sv -code s -line 199 -comment "cfg_en_i is hardcoded to 1." 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_i -src ../../UART/uart_rx.sv -code b -line 184 -comment "cfg_en_i is harcoded to 1." 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_i -src ../../UART/uart_rx.sv -code b -line 198 -comment "cfg_en_i is harcoded to 1." 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_i -togglenode cfg_en_i -comment "hardcoded to 1" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_i -togglenode err_clr_i -comment "hardcode to 1" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_i -togglenode {s_target_bits[2]} -comment "s_target_bits[2] will always be 1 as assigned values are 4,5,6,7 in case statement" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_tx_i -togglenode CS -comment "hardcoded" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_tx_i -togglenode cfg_en_i -comment "hardcoded to 1" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_tx_i -togglenode {s_target_bits[2]} -comment "can have value from 4 to 7 hence no toggle for MSB bit" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_interrupt_i -togglenode CTI_i -comment "hardcoded to 1" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_interrupt_i -togglenode {clr_int_i[0]} {clr_int_i[1]} {clr_int_i[2]} {clr_int_i[3]} -comment "only 2 upper bits valid for mapping" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/mem_ip -togglenode {i[0]} {i[1]} {i[2]} {i[3]} {i[4]} {i[5]} {i[6]} {i[7]} {i[8]} {i[9]}
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/mem_ip -togglenode {i[10]} {i[11]} {i[12]} {i[13]} {i[14]} {i[15]} {i[16]} {i[17]} {i[18]} {i[19]}
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/mem_ip -togglenode {i[20]} {i[21]} {i[22]} {i[23]} {i[24]} {i[25]} {i[26]} {i[27]} {i[28]} {i[29]}
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/mem_ip -togglenode {i[30]} {i[31]}
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_interrupt_i -togglenode CTI_i -comment "hardcoded to 1" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_interrupt_i -togglenode {clr_int_i[0]} {clr_int_i[1]} -comment "hardcoded value" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_fifo_i -togglenode {data_i[8]} {data_o[8]} -comment "due to parity bit" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_fifo_i -togglenode {loop1[0]} {loop1[1]} {loop1[2]} {loop1[3]} {loop1[4]} {loop1[5]} {loop1[6]} {loop1[7]} {loop1[8]} {loop1[9]} -comment "loops are not being toggled" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_fifo_i -togglenode {loop1[10]} {loop1[11]} {loop1[12]} {loop1[13]} {loop1[14]} {loop1[15]} {loop1[16]} {loop1[17]} {loop1[18]} {loop1[19]} -comment "loops are not being toggled" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_fifo_i -togglenode {loop1[20]} {loop1[21]} {loop1[22]} {loop1[23]} {loop1[24]} {loop1[25]} {loop1[26]} {loop1[27]} {loop1[28]} {loop1[29]} -comment "loops are not being toggled" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_fifo_i -togglenode {loop1[30]} {loop1[31]} -comment "loops are not being toggled" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_fifo_i -togglenode {data_i[8]} {data_o[8]} -comment "due to parity bit" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_fifo_i -togglenode {loop1[0]} {loop1[1]} {loop1[2]} {loop1[3]} {loop1[4]} {loop1[5]} {loop1[6]} {loop1[7]} {loop1[8]} {loop1[9]} -comment "loops are not being toggled" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_fifo_i -togglenode {loop1[10]} {loop1[11]} {loop1[12]} {loop1[13]} {loop1[14]} {loop1[15]} {loop1[16]} {loop1[17]} {loop1[18]} {loop1[19]} -comment "loops are not being toggled" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_fifo_i -togglenode {loop1[20]} {loop1[21]} {loop1[22]} {loop1[23]} {loop1[24]} {loop1[25]} {loop1[26]} {loop1[27]} {loop1[28]} {loop1[29]} -comment "loops are not being toggled" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_fifo_i -togglenode {loop1[30]} {loop1[31]} -comment "loops are not being toggled" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_tx_fifo_i -togglenode {loop1[0]} {loop1[1]} {loop1[2]} {loop1[3]} {loop1[4]} {loop1[5]} {loop1[6]} {loop1[7]} {loop1[8]} {loop1[9]} -comment "loops are not being toggled" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_tx_fifo_i -togglenode {loop1[10]} {loop1[11]} {loop1[12]} {loop1[13]} {loop1[14]} {loop1[15]} {loop1[16]} {loop1[17]} {loop1[18]} {loop1[19]} -comment "loops are not being toggled" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_tx_fifo_i -togglenode {loop1[20]} {loop1[21]} {loop1[22]} {loop1[23]} {loop1[24]} {loop1[25]} {loop1[26]} {loop1[27]} {loop1[28]} {loop1[29]} -comment "loops are not being toggled" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_tx_fifo_i -togglenode {loop1[30]} {loop1[31]} -comment "loops are not being toggled" 
coverage exclude -src ../../UART/uart_interrupt.sv -code s -line 78
coverage exclude -src ../../UART/uart_interrupt.sv -code b -line 77
coverage exclude -src ../../UART/uart_interrupt.sv -code c -line 77
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0 -togglenode {ADDR_SRAMS[10]} {ADDR_SRAMS[11]}
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/cmsdk_fpga_sram_S -togglenode {addr_q1[10]} {addr_q1[11]} {i[0]} {i[1]} {i[2]} {i[3]} {i[4]} {i[5]} {i[6]} {i[7]}
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/cmsdk_fpga_sram_S -togglenode {i[8]} {i[9]} {i[10]} {i[11]} {i[12]} {i[13]} {i[14]} {i[15]} {i[16]} {i[17]}
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/cmsdk_fpga_sram_S -togglenode {i[18]} {i[19]} {i[20]} {i[21]} {i[22]} {i[23]} {i[24]} {i[25]} {i[26]} {i[27]}
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/cmsdk_fpga_sram_S -togglenode {i[28]} {i[29]} {i[30]} {i[31]}
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode {IIR_o[1]} -comment "character timeout indication imterrupt execution code has bug (CTI_i is hardcoded to 0)" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode {PRDATA[8]} {PRDATA[9]} {PRDATA[10]} {PRDATA[11]} {PRDATA[12]} {PRDATA[13]} {PRDATA[14]} {PRDATA[15]} {PRDATA[16]} {PRDATA[17]} -comment "Uart only response with 8 bit data" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode {PRDATA[18]} {PRDATA[19]} {PRDATA[20]} {PRDATA[21]} {PRDATA[22]} {PRDATA[23]} {PRDATA[24]} {PRDATA[25]} {PRDATA[26]} {PRDATA[27]} -comment "Uart only response with 8 bit data" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode {PRDATA[28]} {PRDATA[29]} {PRDATA[30]} {PRDATA[31]} -comment "Uart only response with 8 bit data" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode PREADY -comment "Pready assigned with hardcode 1'b1" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode PSLVERR -comment "Pslverr assigned hardcoded with 1'b0" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode apb_rx_ready -comment "hardcoded value" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode {clr_int[0]} {clr_int[1]} -comment "Interrupt clearing variable has only four values 4'b1000, 4'b0100, 4'b1100, 4'b0001." 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode {fifo_rx_data[8]} -comment "assigned with parity error bit and its hardcoded" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode parity_error -comment "hardcoded with err_o bit which is assigned to 1" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_i -src ../../UART/uart_rx.sv -code s -line 185 -comment "cfg_en_i is harcoded to 1. That's why CS goes only to NS." 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_i -src ../../UART/uart_rx.sv -code s -line 199 -comment "cfg_en_i is hardcoded to 1." 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_i -src ../../UART/uart_rx.sv -code s -line 253 -comment "enabling bit for this is hardcoded hence never executes this statement" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_i -src ../../UART/uart_rx.sv -code b -line 184 -comment "cfg_en_i is harcoded to 1." 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_i -src ../../UART/uart_rx.sv -code b -line 198 -comment "cfg_en_i is harcoded to 1." 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_i -togglenode cfg_en_i -comment "hardcoded to 1" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_i -togglenode err_clr_i -comment "hardcode to 1" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_i -togglenode err_o -comment "hardcoded" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_i -togglenode {s_target_bits[2]} -comment "s_target_bits[2] will always be 1 as assigned values are 4,5,6,7 in case statement" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_tx_i -src ../../UART/uart_tx.sv -code s -line 179 -comment "cfg_en_i is hardcoded hence this will never execute" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_tx_i -togglenode CS -comment "hardcoded" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_tx_i -togglenode cfg_en_i -comment "hardcoded to 1" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_tx_i -togglenode {s_target_bits[2]} -comment "can have value from 4 to 7 hence no toggle for MSB bit" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_fifo_i -togglenode {data_i[8]} {data_o[8]} -comment "due to parity bit" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_fifo_i -togglenode {loop1[0]} {loop1[1]} {loop1[2]} {loop1[3]} {loop1[4]} {loop1[5]} {loop1[6]} {loop1[7]} {loop1[8]} {loop1[9]} -comment "loops are not being toggled" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_fifo_i -togglenode {loop1[10]} {loop1[11]} {loop1[12]} {loop1[13]} {loop1[14]} {loop1[15]} {loop1[16]} {loop1[17]} {loop1[18]} {loop1[19]} -comment "loops are not being toggled" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_fifo_i -togglenode {loop1[20]} {loop1[21]} {loop1[22]} {loop1[23]} {loop1[24]} {loop1[25]} {loop1[26]} {loop1[27]} {loop1[28]} {loop1[29]} -comment "loops are not being toggled" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_fifo_i -togglenode {loop1[30]} {loop1[31]} -comment "loops are not being toggled" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_tx_fifo_i -togglenode {loop1[0]} {loop1[1]} {loop1[2]} {loop1[3]} {loop1[4]} {loop1[5]} {loop1[6]} {loop1[7]} {loop1[8]} {loop1[9]} -comment "loops are not being toggled" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_tx_fifo_i -togglenode {loop1[10]} {loop1[11]} {loop1[12]} {loop1[13]} {loop1[14]} {loop1[15]} {loop1[16]} {loop1[17]} {loop1[18]} {loop1[19]} -comment "loops are not being toggled" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_tx_fifo_i -togglenode {loop1[20]} {loop1[21]} {loop1[22]} {loop1[23]} {loop1[24]} {loop1[25]} {loop1[26]} {loop1[27]} {loop1[28]} {loop1[29]} -comment "loops are not being toggled" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_tx_fifo_i -togglenode {loop1[30]} {loop1[31]} -comment "loops are not being toggled" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_interrupt_i -togglenode CTI_i -comment "hardcoded to 1" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_interrupt_i -togglenode {clr_int_i[0]} {clr_int_i[1]} -comment "hardcoded value" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_interrupt_i -togglenode {clr_int_i[2]} {clr_int_i[3]} -comment "only 2 upper bits valid for mapping" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/mem_ip -togglenode {i[0]} {i[1]} {i[2]} {i[3]} {i[4]} {i[5]} {i[6]} {i[7]} {i[8]} {i[9]}
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/mem_ip -togglenode {i[10]} {i[11]} {i[12]} {i[13]} {i[14]} {i[15]} {i[16]} {i[17]} {i[18]} {i[19]}
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/mem_ip -togglenode {i[20]} {i[21]} {i[22]} {i[23]} {i[24]} {i[25]} {i[26]} {i[27]} {i[28]} {i[29]}
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/mem_ip -togglenode {i[30]} {i[31]}
coverage exclude -src ../../UART/uart_interrupt.sv -code s -line 78
coverage exclude -src ../../UART/uart_interrupt.sv -code b -line 77
coverage exclude -src ../../UART/uart_interrupt.sv -code c -line 77
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0 -togglenode {ADDR_SRAMS[10]} {ADDR_SRAMS[11]}
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/cmsdk_fpga_sram_S -togglenode {addr_q1[10]} {addr_q1[11]} {i[0]} {i[1]} {i[2]} {i[3]} {i[4]} {i[5]} {i[6]} {i[7]}
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/cmsdk_fpga_sram_S -togglenode {i[8]} {i[9]} {i[10]} {i[11]} {i[12]} {i[13]} {i[14]} {i[15]} {i[16]} {i[17]}
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/cmsdk_fpga_sram_S -togglenode {i[18]} {i[19]} {i[20]} {i[21]} {i[22]} {i[23]} {i[24]} {i[25]} {i[26]} {i[27]}
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/cmsdk_fpga_sram_S -togglenode {i[28]} {i[29]} {i[30]} {i[31]}
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode {IIR_o[1]} -comment "character timeout indication imterrupt execution code has bug (CTI_i is hardcoded to 0)" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode {PRDATA[8]} {PRDATA[9]} {PRDATA[10]} {PRDATA[11]} {PRDATA[12]} {PRDATA[13]} {PRDATA[14]} {PRDATA[15]} {PRDATA[16]} {PRDATA[17]} -comment "Uart only response with 8 bit data" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode {PRDATA[18]} {PRDATA[19]} {PRDATA[20]} {PRDATA[21]} {PRDATA[22]} {PRDATA[23]} {PRDATA[24]} {PRDATA[25]} {PRDATA[26]} {PRDATA[27]} -comment "Uart only response with 8 bit data" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode {PRDATA[28]} {PRDATA[29]} {PRDATA[30]} {PRDATA[31]} -comment "Uart only response with 8 bit data" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode PREADY -comment "Pready assigned with hardcode 1'b1" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode PSLVERR -comment "Pslverr assigned hardcoded with 1'b0" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode apb_rx_ready -comment "hardcoded value" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode {clr_int[0]} {clr_int[1]} -comment "Interrupt clearing variable has only four values 4'b1000, 4'b0100, 4'b1100, 4'b0001." 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode {fifo_rx_data[8]} -comment "assigned with parity error bit and its hardcoded" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip -togglenode parity_error -comment "hardcoded with err_o bit which is assigned to 1" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_i -src ../../UART/uart_rx.sv -code s -line 185 -comment "cfg_en_i is harcoded to 1. That's why CS goes only to NS." 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_i -src ../../UART/uart_rx.sv -code s -line 199 -comment "cfg_en_i is hardcoded to 1." 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_i -src ../../UART/uart_rx.sv -code s -line 253 -comment "enabling bit for this is hardcoded hence never executes this statement" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_i -src ../../UART/uart_rx.sv -code b -line 184 -comment "cfg_en_i is harcoded to 1." 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_i -src ../../UART/uart_rx.sv -code b -line 198 -comment "cfg_en_i is harcoded to 1." 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_i -togglenode cfg_en_i -comment "hardcoded to 1" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_i -togglenode err_clr_i -comment "hardcode to 1" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_i -togglenode err_o -comment "hardcoded" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_i -togglenode {s_target_bits[2]} -comment "s_target_bits[2] will always be 1 as assigned values are 4,5,6,7 in case statement" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_tx_i -src ../../UART/uart_tx.sv -code s -line 179 -comment "cfg_en_i is hardcoded hence this will never execute" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_tx_i -src ../../UART/uart_tx.sv -code b -line 75 -comment "hardcoded" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_tx_i -src ../../UART/uart_tx.sv -code b -line 178 -comment "hardcoded" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_tx_i -togglenode CS -comment "hardcoded" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_tx_i -togglenode cfg_en_i -comment "hardcoded to 1" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_tx_i -togglenode {s_target_bits[2]} -comment "can have value from 4 to 7 hence no toggle for MSB bit" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_fifo_i -togglenode {data_i[8]} {data_o[8]} -comment "due to parity bit" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_fifo_i -togglenode {loop1[0]} {loop1[1]} {loop1[2]} {loop1[3]} {loop1[4]} {loop1[5]} {loop1[6]} {loop1[7]} {loop1[8]} {loop1[9]} -comment "loops are not being toggled" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_fifo_i -togglenode {loop1[10]} {loop1[11]} {loop1[12]} {loop1[13]} {loop1[14]} {loop1[15]} {loop1[16]} {loop1[17]} {loop1[18]} {loop1[19]} -comment "loops are not being toggled" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_fifo_i -togglenode {loop1[20]} {loop1[21]} {loop1[22]} {loop1[23]} {loop1[24]} {loop1[25]} {loop1[26]} {loop1[27]} {loop1[28]} {loop1[29]} -comment "loops are not being toggled" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_rx_fifo_i -togglenode {loop1[30]} {loop1[31]} -comment "loops are not being toggled" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_tx_fifo_i -togglenode {loop1[0]} {loop1[1]} {loop1[2]} {loop1[3]} {loop1[4]} {loop1[5]} {loop1[6]} {loop1[7]} {loop1[8]} {loop1[9]} -comment "loops are not being toggled" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_tx_fifo_i -togglenode {loop1[10]} {loop1[11]} {loop1[12]} {loop1[13]} {loop1[14]} {loop1[15]} {loop1[16]} {loop1[17]} {loop1[18]} {loop1[19]} -comment "loops are not being toggled" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_tx_fifo_i -togglenode {loop1[20]} {loop1[21]} {loop1[22]} {loop1[23]} {loop1[24]} {loop1[25]} {loop1[26]} {loop1[27]} {loop1[28]} {loop1[29]} -comment "loops are not being toggled" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_tx_fifo_i -togglenode {loop1[30]} {loop1[31]} -comment "loops are not being toggled" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_interrupt_i -src ../../UART/uart_interrupt.sv -code s -line 71 -comment "err_i dependent on parity which is hardcoded" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_interrupt_i -src ../../UART/uart_interrupt.sv -code b -line 70 -comment "hardcoded" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_interrupt_i -src ../../UART/uart_interrupt.sv -code c -line 70 -comment "hardcoded" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_interrupt_i -togglenode CTI_i -comment "hardcoded to 1" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_interrupt_i -togglenode {clr_int_i[0]} {clr_int_i[1]} -comment "hardcoded value" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_interrupt_i -togglenode {clr_int_i[2]} {clr_int_i[3]} -comment "only 2 upper bits valid for mapping" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/uart_ip/uart_interrupt_i -togglenode error_i -comment "Hardcoded" 
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/mem_ip -togglenode {i[0]} {i[1]} {i[2]} {i[3]} {i[4]} {i[5]} {i[6]} {i[7]} {i[8]} {i[9]}
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/mem_ip -togglenode {i[10]} {i[11]} {i[12]} {i[13]} {i[14]} {i[15]} {i[16]} {i[17]} {i[18]} {i[19]}
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/mem_ip -togglenode {i[20]} {i[21]} {i[22]} {i[23]} {i[24]} {i[25]} {i[26]} {i[27]} {i[28]} {i[29]}
coverage exclude -scope /cortexm3_soc_tb/cortexm3_soc_i0/mem_ip -togglenode {i[30]} {i[31]}
