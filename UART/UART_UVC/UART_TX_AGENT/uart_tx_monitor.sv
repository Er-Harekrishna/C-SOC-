
/////////////////////////////////////////////////////////////////////////
// Company        : SCALEDGE 
// Engineer       : SIDDHARTH 
// Create Date    : 10-10-2023
// File Name   	  : uart_monitor.sv
// Class Name 	  : uart_monitor
// Project Name	  : UART_UVC 
// Description	  : 
//////////////////////////////////////////////////////////////////////////


class uart_tx_monitor extends uvm_monitor;

    //factory registration macro 
    `uvm_component_utils(uart_tx_monitor);
         uart_seq_item trans_h; 
    //virtual interface
    virtual uart_interface uif;

    uvm_blocking_get_imp #(uart_seq_item,uart_tx_monitor) get_imp;


    //reg configuration
      uart_reg_config  reg_cfg; 
    
    //uart_transaction class
    int tx_count,rx_count;
    
    // tx and rx parity calculate in this register. 
    bit [`DATA_WIDTH:0] tx_parity,rx_parity;

    //analysis port item collected for transmiting packet monitor to scoreboard
    uvm_analysis_port#(uart_seq_item) item_collected_port;

    //monitor constructor
    function new(string name = "uart_monitor",uvm_component parent);
        super.new(name,parent);
        //assigning memry to analysis port 
        item_collected_port = new("item_collected_port",this);
        get_imp = new("get_imp",this);
        //uart transaction class got memory
        trans_h = new();
              //register configure class got memory and it will automatically configure the register
        reg_cfg = new("reg_cfg");
         `uvm_info(get_full_name(),{"using uvm_default_printer show reg_configs\n",reg_cfg.sprint()},UVM_DEBUG);
    endfunction:new
        

    task reset_phase(uvm_phase phase);
        `uvm_info(get_name()," tx monitor reset phase is arrived",UVM_LOW)
        trans_h.tx_shifter = 'b0;
    endtask

       task main_phase(uvm_phase phase);
        `uvm_info(get_full_name()," ENTER INSIDE THE Monitor RUN PHASE ",UVM_DEBUG)
                 //monitor the txd line
                 tx_monitor();
        `uvm_info(get_full_name()," EXIT INSIDE THE RUN PHASE ",UVM_DEBUG)
    endtask:main_phase

    task tx_monitor();
        forever
            @(negedge `MON_CB.txd && trans_h.TX_STATE ==IDLEE)
            begin
                wait(trans_h.TX_STATE == START) begin
                    foreach(`TX_START)begin
                        trans_h.START = `MON_CB.txd;
                        @(posedge trans_h.tx_shift);
                    end// foreach tx start

                end // wait tx state ==start
                `uvm_info(get_name(),"time in monitor before wait",UVM_LOW)
                @(posedge trans_h.tx_shift);
                wait(trans_h.TX_STATE == DATA) begin
                `uvm_info(get_name(),"time in monitor after wait",UVM_LOW)
                    //acording tx_word_length we set that much time loop iterate
                    foreach(`TX_CHAR_LEN)begin
                        //shift 1 bit data msb 2 lsb
                       case(reg_cfg.tx_data_shift) 
                          
                           MSB_2_LSB:
                               begin
                                   reg_cfg.is_thr_buffer_full = reg_cfg.is_thr_buffer_full.last();
                                   trans_h.tx_shifter = trans_h.tx_shifter << 1;
                                   uif.tx_shifter = uif.tx_shifter << 1;
                                   trans_h.tx_shifter[0] = `MON_CB.txd;
                                   uif.tx_shifter[0] = `MON_CB.txd;
                                   `uvm_info(get_name(),$sformatf(" txd value is %0d and tx shifter is %0d",`MON_CB.txd,uif.tx_shifter[`THR_SIZE-1]),UVM_DEBUG);
                                   `uvm_info(get_name(),{" [TX]  monitor sample bit from msb 2 lsb \n",trans_h.sprint()},UVM_DEBUG);                                
                                   @(posedge trans_h.tx_shift);
                               end // begin MSB 2 LSB
                         
                           LSB_2_MSB:
                               begin
                                   `uvm_info(get_name(),"time in monitor @ wait",UVM_LOW)
                                   reg_cfg.is_thr_buffer_full = reg_cfg.is_thr_buffer_full.last();
                                   trans_h.tx_shifter = trans_h.tx_shifter >> 1;
                                   uif.tx_shifter = uif.tx_shifter >> 1;
                                   trans_h.tx_shifter[`THR_SIZE-1] = `MON_CB.txd;
                                   uif.tx_shifter[`THR_SIZE-1] = `MON_CB.txd;
                                   `uvm_info(get_name(),$sformatf(" txd value is %0d and tx shifter is %0d",`MON_CB.txd,uif.tx_shifter[`THR_SIZE-1]),UVM_DEBUG);
                                   `uvm_info(get_name(),{" [TX] monitor sample bit from lsb 2 msb \n",trans_h.sprint()},UVM_DEBUG);                                
                                   @(posedge trans_h.tx_shift);
                               end // LSB 2 MSB
                       endcase
                    end // foreach_TX_CHAR
                end// wait tx_sate == data
                                           
                if(reg_cfg.tx_parity == PARITY_ENABLE)begin
                   @(posedge trans_h.tx_shift);
                      case(reg_cfg.tx_parity_types)
                          EVEN_PARITY: even_parity();
                          ODD_PARITY: odd_parity();
                      endcase         
                end // if(parity enable)
            
              wait(trans_h.TX_STATE == STOP)begin
                  foreach(`TX_STOP_LEN)
                  begin
                        trans_h.TX_STOP = `MON_CB.txd;
                        @(posedge trans_h.tx_shift);
                    end//foreach tx_stop_len
                      trans_h.wr = 1; 
                `uvm_info(get_name(),{" [BEFORE] Tx monitor samples transaction is \n",trans_h.sprint()},UVM_LOW);    
                      item_collected_port.write(trans_h);
              end // wait
       end  // forever
    
    endtask:tx_monitor
    
       task even_parity();
     begin
      tx_parity =  {`MON_CB.txd , trans_h.tx_shifter};
      tx_parity = ^ tx_parity;
      if(tx_parity == 0)begin
          reg_cfg.is_tx_parity_error = PARITY_ERROR_OCCURE ;
      end //if begin
      else begin
          reg_cfg.is_tx_parity_error  = NO_PARITY_ERROR_OCCURE;

      end //else begin
 end // case even parity begin
 endtask

 task odd_parity();
 begin
   tx_parity =  {`MON_CB.txd,trans_h.tx_shifter};
   tx_parity = ^ tx_parity;
   if(tx_parity == 1) begin
       reg_cfg.is_tx_parity_error  = NO_PARITY_ERROR_OCCURE;

   end //if begin
   else begin
       reg_cfg.is_tx_parity_error = PARITY_ERROR_OCCURE ;

   end // else begin
  end //case odd parity begin

 endtask

 task get(output uart_seq_item seq_item_h);
     begin
         wait (reg_cfg.rw == WRITE_ON)
         reg_cfg.rw = WRITE_OF;
         reg_cfg.is_thr_buffer_full = reg_cfg.is_thr_buffer_full.first();
         seq_item_h = new();
         seq_item_h.kind_e = WRITE_ON;
         `uvm_info(get_name(),$sformatf("sequence item get direction is %s and @ time reg cfg rw is %s",seq_item_h.kind_e,reg_cfg.rw),UVM_DEBUG);
    end
     
 endtask

 

    


endclass:uart_tx_monitor
