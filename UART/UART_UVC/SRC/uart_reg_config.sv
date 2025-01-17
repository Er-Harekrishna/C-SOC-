/////////////////////////////////////////////////////////////////////////
// Company        : SCALEDGE 
// Engineer       : SIDDHARTH 
// Create Date    : 10-10-2023
// File Name   	  : uart_reg_config.sv
// Class Name 	  : uart_reg_config
// Project Name	  : UART_UVC 
// Description	  : 
//////////////////////////////////////////////////////////////////////////

//--------------------------------------------------------------------------
// class  : uart_reg_config
//--------------------------------------------------------------------------


class uart_reg_config  extends uvm_object;
    
    //factory register
    `uvm_object_utils(uart_reg_config);
    static   write_read                 rw;
    //stop bit   1 = 2 stop bit and if this bit is 0 = 1 stop bit
 static   stop_bit                tx_stop_bit,rx_stop_bit;

 static   start_bit               tx_start_bit,rx_start_bit;

 static   shifting                tx_data_shift,rx_data_shift;
   //word length select   00 = 5 bit  01 = 6 bit 10 = 7 bit 11 = 8 bit 
 static   word_length             tx_word_length,rx_word_length;

   //parity bit disable this bit is 1 = parity on and 0 =  off    
 static   parity                  tx_parity,rx_parity;
    
    //EVEN OR ODD PAITY if this bit is 1 = even parity and 0 means odd 
   //but this applicable only if parity is enable a stick parity is off when LCR's
   //5th bit low and it's    on when it 5th bit 1 but this is true only when parity bit is enable which is LCR's 3rd bit
 static   parity_types            tx_parity_types,rx_parity_types;

   //DLAB Disable so we can Acess RBR THR IER if this bit is 1 means DLL we have which is important is baud rate
 static   dlab_bit                tx_dlab,rx_dlab;

  //LSR 0th bit 0 menas reciever buffer is empty and this bit is 1 means that reciever buffer is full this request to please read  
 static   rbr_buffer              is_data_ready;

  // it check  transmiton holding register is empty or not if yes then 
  // intrupt will be generated and that will be given by making LSR's 6th bit 1 and IER's appropiate bit enable
  // Monitoring purpose please set according whenever it need
 static   thr_buffer              is_thr_buffer_full;

   // 0 over run is never detected if this bit is 1 than over run error can occure
   // when rx buffer is full still data not read and it is override from shift register
 static   is_over_run_error       is_tx_over_run_error,is_rx_over_run_error;

    // if this bit is 1 than and if parity calculation if error occure than this will generate intrupt if IER respective bit 1 if. 
 static   is_parity_error         is_tx_parity_error,is_rx_parity_error;
 static   is_break_error          is_tx_break_error , is_rx_break_error;
 static   is_framing_error        is_tx_framing_error , is_rx_framing_error;
 static   rx_tx_data_available    is_rx_tx_data_available;
 static   any_error               is_any_error;

    //if this bit is 1 only if when RBR reg is FULL. after that intrupt has to be generate that will indicate system to read data.
    //if this bit is not set than intrupt will not be generate
 static   intrupt_for_rbr         is_intrupt_for_rbr;
  
    //if this bit is 1 than  if thr reg is empty than intrupt generate that will indicate system
    //to fill next data. if this bit is not set than intrupt will not be generate
 static   intrupt_for_thr         is_intrupt_for_thr;
 
    // ELSI bit of ier it will enable or disble lsr's error intrupts //LSR error like parity,framing,break. if this error is 
    // generated. then error intrupt will be only generated when this elsi bit   set 
 static lsr_error_intrupt       tx_lsr_error_intrupt , rx_lsr_error_intrupt;
 static fifo_mode               tx_fifo_mode_enable,rx_fifo_mode_enable;
 static bit[7:0] TX_DLL,TX_DLM,RX_DLL,RX_DLM;
    
    //dynamic arry if for looping. 
   static int tx_char_len[];
   static int rx_char_len[];
   static int tx_start_len[];
   static int rx_start_len[];
   static int tx_stop_len[];
   static int rx_stop_len[];
   static int tx_total_bit;
   static int rx_total_bit;
 
  function new(string str = "uart_reg_config");
        super.new(str);
    endfunction

   `SPRINT

endclass




