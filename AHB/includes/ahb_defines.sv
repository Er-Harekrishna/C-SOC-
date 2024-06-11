////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  NAME      :- Pradip Prajapati
//  FILE_NAME :- ahb_defines.svh
//  EDITED_BY :- Rajvi Padaria
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////

`include "svt_ahb_user_defines.svi"
`define AHB_MASTER_DRIVER_IF_SETUP_TIME  0
`define AHB_MASTER_DRIVER_IF_HOLD_TIME   0
`define AHB_SLAVE_DRIVER_IF_SETUP_TIME   0
`define AHB_SLAVE_DRIVER_IF_HOLD_TIME    0
`define AHB_MASTER_MONITOR_IF_SETUP_TIME 0
`define AHB_MASTER_MONITOR_IF_HOLD_TIME  0
`define AHB_SLAVE_MONITOR_IF_SETUP_TIME  0
`define AHB_SLAVE_MONITOR_IF_HOLD_TIME   0
`define MEM_DEAPTH                       4096
`define INCR_LENGTH                      5
`define AHB_MAX_NUM_MASTERS              5              
`define AHB_MAX_NUM_SLAVES               5
`define TIME_PERIOD                      10
//`define ENABLE_MASTER_ASSERTION   
`define ALIGNED_SIZE                     8

`include "ahb_port_defines.sv"
`include "ahb_common_defines.sv" 
