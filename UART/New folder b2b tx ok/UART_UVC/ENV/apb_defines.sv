////////////////////////////////////////////////
// File:          apb_defines.sv
// Version:       v1
// Developer:     Mayank
// Project Name:  APB3 Protocol
// Discription:   Defines File 
/////////////////////////////////////////////////

//
// APB Define file:
//
//
`ifndef  APB_DEFINES_SV
`define APB_DEFINES_SV
   //Enum that indicates the transaction type
   typedef enum bit {READ,WRITE} trans_kind_e;
   typedef enum bit[2:0]{IDLE,START,DATA,PARITY,STOP} state;

//---------------------------------------------------------- LCR CONFIGURATION ----------------------------------------------------------------------
  
    //word length select   00 = 5 bit  01 = 6 bit 10 = 7 bit 11 = 8 bit 
    typedef enum int {FIVE_BIT,SIX_BIT,SEVEN_BIT,EIGHT_BIT}word_length;

    //stop bit   1 = 2 stop bit and if this bit is 0 = 1 stop bit

    typedef enum bit{ONE_STOP_BIT,TWO_STOP_BIT} stop_bit;

    typedef enum bit {MSB_2_LSB,LSB_2_MSB} shifting;

    typedef enum bit{ONE_START_BIT,TWO_START_BIT} start_bit;
    //parity bit disable this bit is 1 = parity on and 0 =  off
    typedef enum bit {PARITY_DISABLE,PARITY_ENABLE} parity;
    

    //EVEN OR ODD PAITY if this bit is 1 = even parity and 0 means odd 
    //but this applicable only if parity is enable a stick parity is off when LCR's
    //5th bit low and it's    on when it 5th bit 1 but this is true only when parity bit is enable which is LCR's 3rd bit
    typedef enum bit {EVEN_PARITY,ODD_PARITY} parity_types;


    //DLAB Disable so we can Acess RBR THR IER if this bit is 1 means DLL we have which is important is baud rate
    typedef enum bit {SET_REG,SET_BAUD_RATE} dlab_bit;

//-------------------------------------------------------------------------------------------------------------------------------------------------------


//---------------------------------------------------------- LSR CONFIGURATION ---------------------------------------------------------------------------
    
    // LSR 0th bit 0 menas reciever buffer is empty and this bit is 1 means that reciever buffer is full this request to please read 
    typedef enum bit {RBR_BUFFER_NOT_EMPTY,RBR_BUFFER_EMPTY} rbr_buffer;
  
    // it check  transmiton holding register is empty or not if yes then 
    // intrupt will be generated and that will be given by making LSR's 6th bit 1 and IER's appropiate bit enable
    // Monitoring purpose please set according whenever it need
    typedef enum bit {THR_BUFFER_NOT_EMPTY,THR_BUFFER_EMPTY} thr_buffer;
    
    // 0 over run is never detected if this bit is 1 than over run error can occure
    // when rx buffer is full still data not read and it is override from shift register
    typedef enum bit {NO_OVER_RUN_ERROR,OVER_RUN_ERROR_OCCURE} is_over_run_error;


    // if this bit is 1 than and if parity calculation if error occure than this will generate intrupt if IER respective bit 1 if. 
    typedef enum bit {NO_PARITY_ERROR_OCCURE,PARITY_ERROR_OCCURE} is_parity_error;
 

    typedef enum bit {NO_FRAMING_ERROR,FRAMING_ERROR_OCCURE} is_framing_error;
    typedef enum bit {NO_BREAK_ERROR,BREAK_ERROR_OCCURE} is_break_error;
    typedef enum bit {ANY_BUFFER_HAVE_DATA,BOTH_BUFFER_EMPTY} rx_tx_data_available;
    typedef enum bit {NO_ERROR_OCCURE,ERROR_OCCURE} any_error;

//---------------------------------------------------------------------------------------------------------------------------------------------------------
    


//---------------------------------------------------------- IER CONFIGURATION ------------------------------------------------------------------------------
    //if this bit is 1 only if when RBR reg is FULL. after that intrupt has to be generate that will indicate system to read data.
    //if this bit is not set than intrupt will not be generate
    typedef enum bit {NO_INTRUPT_FOR_RBR,INTRUPT_FOR_RBR} intrupt_for_rbr;
        
    //if this bit is 1 than  if thr reg is empty than intrupt generate that will indicate system
    //to fill next data. if this bit is not set than intrupt will not be generate
    typedef enum bit {NO_INTRUPT_FOR_THR,INTRUPT_FOR_THR} intrupt_for_thr;
   

    // ELSI bit of ier it will enable or disble lsr's error intrupts //LSR error like parity,framing,break. if this error is 
    // generated. then error intrupt will be only generated when this elsi bit   set 
    typedef enum bit {LSR_ERROR_INTRUPT_ENABLE,LSR_ERROR_INTRUPT_ISABLE} lsr_error_intrupt;  
 //----------------------------------------------------------------------------------------------------------------------------------------------------------


    
//---------------------------------------------------------------- FCR CONFIG -------------------------------------------------------------------------------
  typedef enum bit {FIFO_MODE_ON,FIFO_MODE_OFF} fifo_mode;
  
  

   typedef enum bit[2:0] {WRITE_OF,WRITE_ON,READ_ON,READ_OF,SIM_WR}write_read;
   //Address,Data,register width
   `define FREQUANCY  16
   `define HZ         1000_000
   `define ADDR_WIDTH 32
   `define DATA_WIDTH 32
   `define PWDATA_WIDTH 8
   `define REG_WIDTH  16
    `define THR_SIZE  8
    `define RBR_SIZE  8 
   `define APB_CLK_FREQ (16*(10**6)) //16Mhz 
   `define READY_TIMEOUT 10
   `define PASS_COUNT_FULL 0
   `define DUT 0
   `define DRV_CB uif.uart_drv_cb
   `define MON_CB uif.uart_mon_cb 
   `define MEM uvm_root::get.apb_top.DUT.uart_tx_fifo_i.buffer
   `define RX_VALID uvm_root::get.apb_top.DUT.uart_rx_i.rx_valid_o
   `define RX_FIFO uvm_root::get.apb_top.DUT.uart_rx_fifo_i.buffer
   `define NO_OF_WR_TRANS 20
event READ_SIGNAL;
   `define TX_CHAR_LEN reg_cfg.tx_char_len[i]
   `define RX_CHAR_LEN reg_cfg.rx_char_len[i]
   `define TX_START    reg_cfg.tx_start_len[i]
   `define RX_START    reg_cfg.rx_start_len[i]
   `define TX_STOP_LEN     reg_cfg.tx_stop_len[i]
   `define RX_STOP_LEN     reg_cfg.rx_stop_len[i]
   `define TX_TOTAL_BITS $write("[EXPECTED OF TX]  START bit length\t\t\t\t\tDATA length\t\t\t\t\tPARITY(ENABLE/DISABLE)\t\t\t\t\tSTOP_BIT_LENGTH\t\t\t\t\tTOTAL BIT\n"); \
                      $write   ("                     %s\t\t\t\t\t%s\t\t\t\t\t%s\t\t\t\t\t%s\t\t\t\t\t%0d\n" ,reg_cfg.tx_start_bit.name(),reg_cfg.tx_word_length.name(),reg_cfg.tx_parity.name(),reg_cfg.tx_stop_bit.name(),reg_cfg.tx_total_bit);
    
   `define RX_TOTAL_BITS $write("[EXPECTED OF RX]  START bit length\t\t\t\t\tDATA length\t\t\t\t\tPARITY(ENABLE/DISABLE)\t\t\t\t\tSTOP_BIT_LENGTH\t\t\t\t\tTOTAL BIT\n"); \
                      $write   ("                     %s\t\t\t\t\t%s\t\t\t\t\t%s\t\t\t\t\t%s\t\t\t\t\t%0d\n" ,reg_cfg.rx_start_bit.name(),reg_cfg.rx_word_length.name(),reg_cfg.rx_parity.name(),reg_cfg.rx_stop_bit.name(),reg_cfg.rx_total_bit);

`define SPRINT virtual function void do_print(uvm_printer printer); \
        super.do_print(printer); \
        printer.print_string("tx_word_length",tx_word_length.name()); \
        printer.print_string("rx_word_length",rx_word_length.name()); \
        printer.print_string("tx_start_bit",tx_start_bit.name()); \
        printer.print_string("rx_start_bit",rx_start_bit.name()); \
        printer.print_string("tx_stop_bit",tx_stop_bit.name()); \
        printer.print_string("rx_stop_bit",rx_stop_bit.name()); \
        printer.print_string("tx_start_bit",tx_start_bit.name()); \
        printer.print_string("rx_start_bit",rx_start_bit.name()); \
        printer.print_string("tx_parity",tx_parity.name());  \
        printer.print_string("rx_parity",rx_parity.name()); \
        printer.print_string("tx_parity_type",tx_parity_types.name()); \
        printer.print_string("rx_parity_type",rx_parity_types.name()); \
        printer.print_string("tx_dlab_bit",tx_dlab.name()); \
        printer.print_string("tx_dlab_bit",rx_dlab.name()); \
        printer.print_string("is_rbr_buffer_full",is_data_ready.name()); \
        printer.print_string("is_thr_buffer_full",is_thr_buffer_full.name()); \
        printer.print_string("is_over_run_error",is_tx_over_run_error.name()); \
        printer.print_string("is_over_run_error",is_rx_over_run_error.name()); \
        printer.print_string("is_tx_break_error",is_tx_break_error.name()); \
        printer.print_string("is_rx_break_error",is_rx_break_error.name()); \
        printer.print_string("is_tx_parity_error",is_tx_parity_error.name()); \
        printer.print_string("is_rx_parity_error",is_rx_parity_error.name()); \
        printer.print_string("is_tx_framing_error",is_tx_framing_error.name()); \
        printer.print_string("is_rx_framing_error",is_rx_framing_error.name()); \
        printer.print_string("is_rx_tx_data_available",is_rx_tx_data_available.name()); \
        printer.print_string("is_any_error",is_any_error.name()); \
        printer.print_string("is_intrupt_for_rbr",is_intrupt_for_rbr.name()); \
        printer.print_string("is_intrupt_for_thr",is_intrupt_for_thr.name()); \
        printer.print_string("tx_lsr_error_intrupt",tx_lsr_error_intrupt.name()); \
        printer.print_string("rx_lsr_error_intrupt",rx_lsr_error_intrupt.name()); \
        printer.print_string("fifo_mode_enable",tx_fifo_mode_enable.name()); \
        printer.print_string("fifo_mode_enable",rx_fifo_mode_enable.name()); \
    endfunction     

`endif
