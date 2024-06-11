RTL = ../HDL_interconnect/ahb_rtl.sv
TOP = ../tb/ahb_top.sv
TC_NAME = ${TEST}
VERBOSITY  = ${VERBOS}
DATE = $(shell date +'%d_%m_%H_%M_%S')
DAY = $(shell date +'%d_%m')
SEED = $(seed)
TRANSCRIPT_FILE = "$(TC_NAME)_$(DATE).log"
TRANSCRIPT = "transcript_$(UVM_TESTNAME)_$(DATE).log"
vlog :
	vlib work
# for compiling and view output on command prompt

comp :
	vlog ../tb/ahb_pkg.sv $(TOP) +incdir+../mas_agent +incdir+../slv_agent  +incdir+../uvc +incdir+../env +incdir+../includes +incdir+../src +incdir+../test +incdir+../seq +incdir+../tb +incdir+../HDL_interconnect

comp_cov :
	vlog -coveropt 3 +cover +acc $(TOP) +incdir+../mas_agent +incdir+../slv_agent +incdir+../uvc +incdir+../env +incdir+../includes +incdir+../src +incdir+../test +incdir+../seq

test_run :
	vsim -novopt ahb_top -c -do "run -all;exit" -l log/$(TC_NAME).log +UVM_TESTNAME=$(TEST) +UVM_VERBOSITY=UVM_DEBUG

test_sim :
	vsim -novopt ahb_top +UVM_TESTNAME=${TEST} +UVM_VERBOSITY=$(VERBOS)

ERR_CNT = $(sh grep -sc UVM_ERROR   ${TEST}_sim.log)
ERR_COUNT=$(sh grep -sc UVM_ERROR transcript_$(TC_NAME)_$(DATE).log)
WRN_CNT = $(shell grep -sc UVM_WARNING ${TEST}_sim.log)

log_data:
	echo "THIS IS NUMBER OF UVM_WARNING"
	grep -inr UVM_WARNING $(DAY)_log
	echo "THIS IS NUMBER OF FAIL"
	grep -inr FAIL $(DAY)_log
	grep -inr UVM_PASS $(DAY)_log
	grep -inr PASS $(DAY)_log
	echo "THIS IS NUMBER OF UVM_ERROR"
	grep -inr UVM_ERROR $(DAY)_log
	echo "THIS IS NUMBER OF UVM_WARNING"
	grep -inr UVM_WARNING $(DAY)_log
	echo "THIS IS NUMBER OF UVM_FATAL"
	grep -inr UVM_FATAL $(DAY)_log

regression :
	vlog ../tb/ahb_pkg.sv $(TOP) +incdir+../mas_agent +incdir+../slv_agent  +incdir+../uvc +incdir+../env +incdir+../includes +incdir+../src +incdir+../test +incdir+../seq +incdir+../tb +incdir+../HDL_interconnect
	mkdir log
	vsim ahb_top -c -do "run -all;exit" -l log/"ahb_sanity_test.log" +UVM_TESTNAME=ahb_sanity_test
	vsim ahb_top -c -do "run -all;exit" -l log/"ahb_b2b_test.log" +UVM_TESTNAME=ahb_b2b_test
	vsim ahb_top -c -do "run -all;exit" -l log/"ahb_rst_test.log" +UVM_TESTNAME=ahb_rst_test
	vsim ahb_top -c -do "run -all;exit" -l log/"ahb_wrap_test.log" +UVM_TESTNAME=ahb_wrap_test
	vsim ahb_top -c -do "run -all;exit" -l log/"ahb_incr_test.log" +UVM_TESTNAME=ahb_incr_test
	vsim ahb_top -c -do "run -all;exit" -l log/"ahb_waited_busy_test.log" +UVM_TESTNAME=ahb_waited_busy_test
	vsim ahb_top -c -do "run -all;exit" -l log/"ahb_waited_trans_change_test.log" +UVM_TESTNAME=ahb_waited_trans_change_test
	vsim ahb_top -c -do "run -all;exit" -l log/"ahb_error_test.log" +UVM_TESTNAME=ahb_error_test
	vsim ahb_top -c -do "run -all;exit" -l log/"ahb_nowait_nobusy_test.log" +UVM_TESTNAME=ahb_nowait_nobusy_test

vip_compile : 
	vlog ../tb/ahb_pkg.sv ../tb/ahb_top.sv +incdir+../mas_agent +incdir+../slv_agent +incdir+../uvc +incdir+../env +incdir+../includes +incdir+../src +incdir+../test +incdir+../seq +incdir+$DESIGNWARE_HOME/design_dir/include/sverilog +incdir+$DESIGNWARE_HOME/design_dir/src/sverilog/mti +define+SVT_UVM_TECHNOLOGY +define+UVM_PACKER_MAX_BYTES=1500000 +define+UVM_DISABLE_AUTO_ITEM_RECORDING +define+SYNOPSYS_VCS +incdir+$UVM_HOME/src +define+SVT_VENDOR_LC=mti

vip_run : 
	vsim ahb_top -permit_unmatched_virtual_intf -suppress 3534 -sv_lib ${DESIGNWARE_HOME}/vip/common/latest/C/lib/amd64/VipCommonNtb -sv_lib uvm_dpi -c -do "run -all;exit" +UVM_TESTNAME=ahb_sanity_test

coverage:
	vlog -coveropt 3 +cover +acc../tb/ahb_pkg.sv $(TOP) +incdir+../mas_agent +incdir+../slv_agent  +incdir+../uvc +incdir+../env +incdir+../includes +incdir+../src +incdir+../test +incdir+../seq
	vsim -coverage -vopt ahb_top -c -do "coverage save -onexit -directive -cvg -codeall sanity_test.ucdb; run -all; exit" +UVM_TESTNAME=ahb_sanity_test
	vsim -coverage -vopt ahb_top -c -do "coverage save -onexit -directive -cvg -codeall b2b_test.ucdb; run -all; exit" +UVM_TESTNAME=ahb_b2b_test
	vsim -coverage -vopt ahb_top -c -do "coverage save -onexit -directive -cvg -codeall rst_test.ucdb; run -all; exit" +UVM_TESTNAME=ahb_rst_test
	vsim -coverage -vopt ahb_top -c -do "coverage save -onexit -directive -cvg -codeall wrap_test.ucdb; run -all; exit" +UVM_TESTNAME=ahb_wrap_test
	vsim -coverage -vopt ahb_top -c -do "coverage save -onexit -directive -cvg -codeall incr_test.ucdb; run -all; exit" +UVM_TESTNAME=ahb_incr_test
	vsim -coverage -vopt ahb_top -c -do "coverage save -onexit -directive -cvg -codeall waited_busy_test.ucdb; run -all; exit" +UVM_TESTNAME=ahb_waited_busy_test
	vsim -coverage -vopt ahb_top -c -do "coverage save -onexit -directive -cvg -codeall waited_trans_change_test.ucdb; run -all; exit" +UVM_TESTNAME=ahb_waited_trans_change_test
	vsim -coverage -vopt ahb_top -c -do "coverage save -onexit -directive -cvg -codeall nowait_nobusy_test.ucdb; run -all; exit" +UVM_TESTNAME=ahb_nowait_nobusy_test
	vcover merge ahb_merge_cvg.ucdb sanity_test.ucdb b2b_test.ucdb wrap_test.ucdb incr_test.ucdb rst_test.ucdb waited_busy_test.ucdb waited_trans_change_test.ucdb nowait_nobusy_test.ucdb
	vcover report -html -htmldir AHB_MERGE_CVG ahb_merge_cvg.ucdb

