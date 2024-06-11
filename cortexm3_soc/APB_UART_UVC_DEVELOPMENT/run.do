vlog top.sv -l comp_run2.log
#vlog top.sv 
#vsim work.top -l sim_run2.log
vsim -novopt -suppress 12110 top -sv_lib C:/questasim64_10.7c/uvm-1.2/win64/uvm_dpi -l sim_run.log
#add wave -position insertpoint sim:/top/*
do wave.do
run -all


