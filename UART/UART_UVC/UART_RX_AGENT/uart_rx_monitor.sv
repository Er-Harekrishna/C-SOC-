/////////////////////////////////////////////////////////////////////////
// Company        : SCALEDGE 
// Engineer       : SIDDHARTH 
// Create Date    : 10-10-2023
// File Name   	  : uart_monitor.sv
// Class Name 	  : uart_monitor
// Project Name	  : UART_UVC 
// Description	  : 
//////////////////////////////////////////////////////////////////////////


class uart_rx_monitor extends uvm_monitor;

    //factory registration macro 
    `uvm_component_utils(uart_rx_monitor);

    //virtual interface
    virtual uart_interface uif;

    //reg configuration
      uart_reg_config  reg_cfg; 
    
    //uart_transaction class
    uart_seq_item trans_h;
    int rx_count;
    // tx and rx parity calculate in this register. 
    bit [`DATA_WIDTH:0] rx_parity;

    //analysis port item collected for transmiting packet monitor to scoreboard
    uvm_analysis_port#(uart_seq_item) item_collected_port;

    //monitor constructor
    function new(string name = "uart_rx_monitor",uvm_component parent);
        super.new(name,parent);
        //assigning memry to analysis port 
        item_collected_port = new("item_collected_port",this);

        //uart transaction class got memory
        trans_h = new();
        
        //register configure class got memory and it will automatically configure the register
        reg_cfg = new("reg_cfg");
         `uvm_info(get_full_name(),{"using uvm_default_printer show reg_configs\n",reg_cfg.sprint()},UVM_LOW);
    endfunction:new
        

    task reset_phase(uvm_phase phase);
        `uvm_info(get_name(),"-----------------------------------------------------  RX MONITOR RESET PHASE CALLED ------------------------------------------------------------------------",UVM_LOW)
        trans_h.rx_shifter = 'b0;
        trans_h.RX_STATE  = trans_h.RX_STATE.first();
        trans_h.rx_gated_clk = 'b0;
        rx_count = 'b0;
        `uvm_info(get_name(), "reset_phase returning", UVM_HIGH)
      endtask

    task main_phase(uvm_phase phase);
        `uvm_info(get_full_name()," ENTER INSIDE THE Monitor MAIN PHASE ",UVM_DEBUG)
         super.main_phase(phase); 
         forever begin 
             fork
                 //monitor the rxd line
                 rx_monitor();
                 baud_clk();
             join

         end // forever begin
        `uvm_info(get_full_name()," EXIT INSIDE THE MAIN PHASE ",UVM_DEBUG)
        
    endtask:main_phase
    
    task rx_monitor();
        forever 
            @(negedge uif.rxd && trans_h.RX_STATE == IDLEE)begin
	            trans_h.rx_gated_clk = 1'b1;
                uif.rx_gated_clk    = 1'b1;
                //rx_shifter is shift register[SIPO]. here we clear the shift register when ever data state arrive of the rx line
                trans_h.rx_shifter = 'b0;
		uif.rx_shifter = 'b0;
		rx_count = 0;
		uif.rx_count = 0;
                trans_h.rx_gated_clk = 1'b1;
                reg_cfg.is_data_ready = reg_cfg.is_data_ready.first();
                trans_h.RX_STATE = trans_h.RX_STATE.next(); // START
                uif.RX_STATE = uif.RX_STATE.next(); // START
                
                foreach(`RX_START)begin
                    trans_h.START = `MON_CB.rxd;
                    @(posedge trans_h.rx_shift);
                end // foreach rx_state
               
                @(posedge trans_h.tx_shift);
                
                trans_h.RX_STATE = trans_h.RX_STATE.next(); // DATA
                uif.RX_STATE = uif.RX_STATE.next(); // DATA
                
                //acording rx_word_length we set that much time loop iterate forever wait (trans_h.tx_gated_clk)
         
                foreach(`RX_CHAR_LEN)begin
                    case(reg_cfg.rx_data_shift)
                        MSB_2_LSB:begin
                                     //1 bit data shift msb 2 lsb
                                     trans_h.rx_shifter = trans_h.rx_shifter << 1;
				     uif.rx_shifter = uif.rx_shifter <<1;
                                     trans_h.rx_shifter[0] = `MON_CB.rxd;
				     uif.rx_shifter[0] = `MON_CB.rxd;
                                     `uvm_info(get_name(),{" [RX] MSB2LSB monitor sample bit from msb 2 lsb \n",trans_h.sprint()},UVM_DEBUG);                                
 				    @(posedge trans_h.rx_shift);
                                   end // begin
                        LSB_2_MSB: begin
                                    //1 bit data shift msb 2 lsb
                                     trans_h.rx_shifter = trans_h.rx_shifter >> 1;
				     uif.rx_shifter = uif.rx_shifter >>1;
                                     trans_h.rx_shifter[`THR_SIZE-1] = `MON_CB.rxd;
                                     uif.rx_shifter[`THR_SIZE-1] = `MON_CB.rxd;
                                    `uvm_info(get_name(),{" [RX]  LSB2MSB monitor sample bit from lsb 2 msb \n",trans_h.sprint()},UVM_DEBUG);                                
 				    @(posedge trans_h.rx_shift);

                                  end // begin
                    endcase
                   end //foreach begin
                
                reg_cfg.is_data_ready = reg_cfg.is_data_ready.next();
                //here calculate parity acording reg config register rx_parity
                if(reg_cfg.rx_parity == PARITY_ENABLE)begin
                    trans_h.RX_STATE = trans_h.RX_STATE.next(); // PARITY
                    uif.RX_STATE = uif.RX_STATE.next(); // PARITY
                    @(posedge trans_h.rx_shift);
                      case(reg_cfg.rx_parity_types)
                          EVEN_PARITY: even_parity();
                          ODD_PARITY:  odd_parity();
                      endcase         
                end // if(parity _enable)              
                  
             foreach(`RX_STOP_LEN)
                  begin
                        trans_h.RX_STOP = `MON_CB.rxd;
                        trans_h.RX_STATE = trans_h.RX_STATE.last(); // STOP
                        uif.RX_STATE = uif.RX_STATE.last(); // STOP
                        @(posedge trans_h.rx_shift);
                  end//foreach tx_stop_len
                trans_h.wr = 0;        
                `uvm_info(get_name(),{"[BEFORE] recived transaction is \n",trans_h.sprint()},UVM_LOW);
                item_collected_port.write(trans_h);
                trans_h.RX_STATE = trans_h.RX_STATE.first(); //IDLEE
                uif.RX_STATE = uif.RX_STATE.first(); //IDLEE
                @(posedge trans_h.rx_shift);
	            trans_h.rx_gated_clk =0;
                uif.rx_gated_clk =0;
    end // forever

    endtask:rx_monitor

    task baud_clk();
            forever wait (trans_h.rx_gated_clk)
            begin
              //when rx_count is equal to DLL AND DLH then one tx shift pulse generate acording that pulse data serially shifted
               if(rx_count == {reg_cfg.RX_DLM,reg_cfg.RX_DLL})    
               begin
                   trans_h.rx_shift = 1'b1;
                   uif.rx_shift    = 1'b1;
                   rx_count = 0;
                   uif.rx_count = 0;
                   #1;
                   trans_h.rx_shift = 0;
                   uif.rx_shift    = 1'b0;

               end // if 
               else begin
                   trans_h.rx_shift = 0;
                   uif.rx_shift    = 1'b0;
               rx_count = rx_count + 1;
               uif.rx_count = uif.rx_count + 1;
               @(`MON_CB);
               end
           end // wait

 endtask

 task even_parity();
      begin
            rx_parity =  {`MON_CB.rxd,trans_h.rx_shifter};
            `uvm_info(get_name(),$sformatf("EVEN PARITY rx_parity is %b",rx_parity),UVM_DEBUG);
            rx_parity = ^ rx_parity;
            `uvm_info(get_name(),$sformatf("EVEN PARITY[AFTER_CALC] rx_parity is %b",rx_parity),UVM_DEBUG);
            if(rx_parity == 0)begin
                reg_cfg.is_rx_parity_error  = NO_PARITY_ERROR_OCCURE;
            end // if begin
            else begin
                reg_cfg.is_rx_parity_error  = PARITY_ERROR_OCCURE;
            end // else begin
        end // case even parity begin
 endtask
 task odd_parity();
     begin
         rx_parity =  {`MON_CB.rxd,trans_h.rx_shifter};
        `uvm_info(get_name(),$sformatf("ODD PARITY rx_parity is %b",rx_parity),UVM_DEBUG);
         rx_parity = ^ rx_parity;
        `uvm_info(get_name(),$sformatf("ODD PARITY[AFTER_CALC] rx_parity is %b",rx_parity),UVM_DEBUG);
         if(rx_parity == 1) begin
             reg_cfg.is_rx_parity_error  = NO_PARITY_ERROR_OCCURE;
         end //if begin
         else begin
             reg_cfg.is_rx_parity_error  = PARITY_ERROR_OCCURE;

         end // else begin
   end //case odd parity begin

 endtask

endclass:uart_rx_monitor
