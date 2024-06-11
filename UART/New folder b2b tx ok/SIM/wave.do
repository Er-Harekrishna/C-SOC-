onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group MAS /uart_top/uinf_master/rstn
add wave -noupdate -expand -group MAS /uart_top/uinf_master/txd
add wave -noupdate -expand -group MAS /uart_top/uinf_master/rxd
add wave -noupdate -expand -group MAS /uart_top/uinf_master/take_data
add wave -noupdate -expand -group MAS /uart_top/uinf_master/count
add wave -noupdate -expand -group SLV /uart_top/uinf_slave/clk
add wave -noupdate -expand -group SLV /uart_top/uinf_slave/rstn
add wave -noupdate -expand -group SLV /uart_top/uinf_slave/txd
add wave -noupdate -expand -group SLV /uart_top/uinf_slave/take_data
add wave -noupdate -expand -group SLV /uart_top/uinf_slave/count
add wave -noupdate /uart_top/uinf_master/clk
add wave -noupdate /uart_top/uinf_master/rstn
add wave -noupdate /uart_top/uinf_master/txd
add wave -noupdate /uart_top/uinf_slave/rxd
add wave -noupdate /uart_top/uinf_master/count
add wave -noupdate /uart_top/uinf_master/tx_shift
add wave -noupdate /uart_top/uinf_slave/rx_shift
add wave -noupdate -radix unsigned /uart_top/uinf_master/tx_shifter
add wave -noupdate -radix unsigned -childformat {{{/uart_top/uinf_slave/rx_shifter[7]} -radix unsigned} {{/uart_top/uinf_slave/rx_shifter[6]} -radix unsigned} {{/uart_top/uinf_slave/rx_shifter[5]} -radix unsigned} {{/uart_top/uinf_slave/rx_shifter[4]} -radix unsigned} {{/uart_top/uinf_slave/rx_shifter[3]} -radix unsigned} {{/uart_top/uinf_slave/rx_shifter[2]} -radix unsigned} {{/uart_top/uinf_slave/rx_shifter[1]} -radix unsigned} {{/uart_top/uinf_slave/rx_shifter[0]} -radix unsigned}} -subitemconfig {{/uart_top/uinf_slave/rx_shifter[7]} {-height 15 -radix unsigned} {/uart_top/uinf_slave/rx_shifter[6]} {-height 15 -radix unsigned} {/uart_top/uinf_slave/rx_shifter[5]} {-height 15 -radix unsigned} {/uart_top/uinf_slave/rx_shifter[4]} {-height 15 -radix unsigned} {/uart_top/uinf_slave/rx_shifter[3]} {-height 15 -radix unsigned} {/uart_top/uinf_slave/rx_shifter[2]} {-height 15 -radix unsigned} {/uart_top/uinf_slave/rx_shifter[1]} {-height 15 -radix unsigned} {/uart_top/uinf_slave/rx_shifter[0]} {-height 15 -radix unsigned}} /uart_top/uinf_slave/rx_shifter
add wave -noupdate /uart_top/uinf_slave/RX_STATE
add wave -noupdate /uart_top/uinf_master/TX_STATE
add wave -noupdate /uart_top/uinf_master/tx_parity
add wave -noupdate /uart_top/uinf_master/tx_valid
add wave -noupdate /uart_top/uinf_master/RX_STATE
add wave -noupdate /uart_top/uinf_master/tx_gated_clk
add wave -noupdate /uart_top/uinf_master/rx_gated_clk
add wave -noupdate /uart_top/uinf_slave/clk
add wave -noupdate /uart_top/uinf_slave/rstn
add wave -noupdate /uart_top/uinf_slave/txd
add wave -noupdate /uart_top/uinf_slave/take_data
add wave -noupdate /uart_top/uinf_slave/count
add wave -noupdate /uart_top/uinf_slave/tx_count
add wave -noupdate /uart_top/uinf_slave/rx_count
add wave -noupdate /uart_top/uinf_slave/tx_shift
add wave -noupdate /uart_top/uinf_slave/tx_frame_count
add wave -noupdate /uart_top/uinf_slave/tx_shifter
add wave -noupdate /uart_top/uinf_slave/tx_parity
add wave -noupdate /uart_top/uinf_slave/rxd
add wave -noupdate /uart_top/uinf_slave/tx_valid
add wave -noupdate /uart_top/uinf_master/clk
add wave -noupdate -radix unsigned /uart_top/uinf_master/tx_count
add wave -noupdate -radix unsigned /uart_top/uinf_master/rx_count
add wave -noupdate /uart_top/uinf_slave/TX_STATE
add wave -noupdate /uart_top/uinf_slave/tx_gated_clk
add wave -noupdate /uart_top/uinf_slave/rx_gated_clk
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1389274 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {600112 ps} {1800336 ps}
