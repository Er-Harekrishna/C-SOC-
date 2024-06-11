class uart_reg_config_seqs extends uvm_sequence#(uvm_sequence_item);
    `uvm_object_utils(uart_reg_config);
     uart_seq_item uart_trans_h;
     uart_reg_config  reg_cfg;

     int baud_rate;
     bit[7:0] dlab,dlm,dll,bit_no,parity_arg,bit_set,lcr_set,baud_set,stp_bit_set,stop_bit;
     bit enable;
     bit[15:0] baud;

    function new(string str = "uart_reg_config_seqs");
        super.new(str);
        uart_trans_h=uart_seq_item::type_id::create("uart_trans_h");
        reg_cfg = new();
    endfunction


task pre_start();
begin
            //--------  BIT NUMBER  --------//
            if($value$plusargs("data_bit=%0d",bit_no))
            begin
                if(bit_no == 5)begin
                    bit_set=8'b0000_0000;
                   // PWDATA_WIDTH 5;
                    reg_cfg.tx_word_length = FIVE_BIT;
                    reg_cfg.rx_word_length = FIVE_BIT;
                    reg_cfg.tx_char_len    = new[reg_cfg.tx_word_length+5];
                    reg_cfg.rx_char_len    = new[reg_cfg.rx_word_length+5];

            end 
                else if(bit_no == 6)begin
                    bit_set=8'b0000_0001;
                    //PWDATA_WIDTH  6;
                    reg_cfg.tx_word_length = SIX_BIT;
                    reg_cfg.rx_word_length = SIX_BIT;
                    reg_cfg.tx_char_len    = new[reg_cfg.tx_word_length+5];
                    reg_cfg.rx_char_len    = new[reg_cfg.rx_word_length+5];

                end
                else if(bit_no == 7)begin
                    bit_set=8'b0000_0010;
                    //PWDATA_WIDTH 7;
                    reg_cfg.tx_word_length =SEVEN_BIT;
                    reg_cfg.rx_word_length =SEVEN_BIT;
                    reg_cfg.tx_char_len    = new[reg_cfg.tx_word_length+5];
                    reg_cfg.rx_char_len    = new[reg_cfg.rx_word_length+5];
                end
                else if(bit_no == 8)begin
                    bit_set=8'b0000_0011;
                    //PWDATA_WIDTH 8;
                    reg_cfg.tx_word_length =EIGHT_BIT;
                    reg_cfg.rx_word_length =EIGHT_BIT;
                    reg_cfg.tx_char_len    = new[reg_cfg.tx_word_length+5];
                    reg_cfg.rx_char_len    = new[reg_cfg.rx_word_length+5];
                end
            end
            //-------  END BIT NUMBER  ------//
            
            //-------   BAUD RATE   ------//
            
            if($value$plusargs("baudrate=%d",baud_rate))begin
                if(baud_rate == 9600)begin
                    calc();
                    dlab=8'b1000_0000;
                    dlm=baud[15:8];
                    dll=baud[7:0];
                    
		    reg_cfg.RX_DLL = baud[7:0];
                    reg_cfg.RX_DLM = baud[15:8];
                    reg_cfg.TX_DLL = baud[7:0];
                    reg_cfg.TX_DLM = baud[15:8];
                end
                
                if(baud_rate == 56000)begin
                    calc();
                    dlab=8'b1000_0000;
                    dlm=baud[15:8];
                    dll=baud[7:0];
                    reg_cfg.RX_DLL = baud[7:0];
                    reg_cfg.RX_DLM = baud[15:8];
                    reg_cfg.TX_DLL = baud[7:0];
                    reg_cfg.TX_DLM = baud[15:8];
                    `uvm_info(get_name(),$sformatf("THE baud rate value is %0d  and dll value is %0d and dlm value is %0d rx dll is %0d and rx dlm is %0d and tx dll is %0d and tx dlm is %0d combine rx value is %0d and tx value is %0d",baud,dll,dlm,reg_cfg.RX_DLL,reg_cfg.RX_DLM,reg_cfg.TX_DLL,reg_cfg.TX_DLM,{reg_cfg.RX_DLM,reg_cfg.RX_DLL},{reg_cfg.TX_DLM,reg_cfg.TX_DLL}),UVM_LOW);
                end
                if(baud_rate == 2400)begin
                   calc();
                    dlab=8'b1000_0000;
                    dlm=baud[15:8];
                    dll=baud[7:0];
                    reg_cfg.RX_DLL = baud[7:0];
                    reg_cfg.RX_DLM = baud[15:8];
                    reg_cfg.TX_DLL = baud[7:0];
                    reg_cfg.TX_DLM = baud[15:8];
                    `uvm_info(get_name(),$sformatf("THE baud rate value is %0d  and dll value is %0d and dlm value is %0d rx dll is %0d and rx dlm is %0d and tx dll is %0d and tx dlm is %0d combine rx value is %0d and tx value is %0d",baud,dll,dlm,reg_cfg.RX_DLL,reg_cfg.RX_DLM,reg_cfg.TX_DLL,reg_cfg.TX_DLM,{reg_cfg.RX_DLM,reg_cfg.RX_DLL},{reg_cfg.TX_DLM,reg_cfg.TX_DLL}),UVM_LOW);
                end
                if(baud_rate == 4800)begin
                   calc();
                    dlab=8'b1000_0000;
                    dlm=baud[15:8];
                    dll=baud[7:0];
                    reg_cfg.RX_DLL = baud[7:0];
                    reg_cfg.RX_DLM = baud[15:8];
                    reg_cfg.TX_DLL = baud[7:0];
                    reg_cfg.TX_DLM = baud[15:8];
                    `uvm_info(get_name(),$sformatf("THE baud rate value is %0d  and dll value is %0d and dlm value is %0d rx dll is %0d and rx dlm is %0d and tx dll is %0d and tx dlm is %0d combine rx value is %0d and tx value is %0d",baud,dll,dlm,reg_cfg.RX_DLL,reg_cfg.RX_DLM,reg_cfg.TX_DLL,reg_cfg.TX_DLM,{reg_cfg.RX_DLM,reg_cfg.RX_DLL},{reg_cfg.TX_DLM,reg_cfg.TX_DLL}),UVM_LOW);
                end
                if(baud_rate == 19200)begin
                  calc();
                    dlab=8'b1000_0000;
                    dlm=baud[15:8];
                    dll=baud[7:0];
                    reg_cfg.RX_DLL = baud[7:0];
                    reg_cfg.RX_DLM = baud[15:8];
                    reg_cfg.TX_DLL = baud[7:0];
                    reg_cfg.TX_DLM = baud[15:8];
                    `uvm_info(get_name(),$sformatf("THE baud rate value is %0d  and dll value is %0d and dlm value is %0d rx dll is %0d and rx dlm is %0d and tx dll is %0d and tx dlm is %0d combine rx value is %0d and tx value is %0d",baud,dll,dlm,reg_cfg.RX_DLL,reg_cfg.RX_DLM,reg_cfg.TX_DLL,reg_cfg.TX_DLM,{reg_cfg.RX_DLM,reg_cfg.RX_DLL},{reg_cfg.TX_DLM,reg_cfg.TX_DLL}),UVM_LOW);
                end
                if(baud_rate == 38400)begin
                   calc();
                    dlab=8'b1000_0000;
                    dlm=baud[15:8];
                    dll=baud[7:0];
                    reg_cfg.RX_DLL = baud[7:0];
                    reg_cfg.RX_DLM = baud[15:8];
                    reg_cfg.TX_DLL = baud[7:0];
                    reg_cfg.TX_DLM = baud[15:8];
                    `uvm_info(get_name(),$sformatf("THE baud rate value is %0d  and dll value is %0d and dlm value is %0d rx dll is %0d and rx dlm is %0d and tx dll is %0d and tx dlm is %0d combine rx value is %0d and tx value is %0d",baud,dll,dlm,reg_cfg.RX_DLL,reg_cfg.RX_DLM,reg_cfg.TX_DLL,reg_cfg.TX_DLM,{reg_cfg.RX_DLM,reg_cfg.RX_DLL},{reg_cfg.TX_DLM,reg_cfg.TX_DLL}),UVM_LOW);
                end
                if(baud_rate == 128000)begin
                  calc();
                    dlab=8'b1000_0000;
                    dlm=baud[15:8];
                    dll=baud[7:0];
                    reg_cfg.RX_DLL = baud[7:0];
                    reg_cfg.RX_DLM = baud[15:8];
                    reg_cfg.TX_DLL = baud[7:0];
                    reg_cfg.TX_DLM = baud[15:8];
                    `uvm_info(get_name(),$sformatf("THE baud rate value is %0d  and dll value is %0d and dlm value is %0d rx dll is %0d and rx dlm is %0d and tx dll is %0d and tx dlm is %0d combine rx value is %0d and tx value is %0d",baud,dll,dlm,reg_cfg.RX_DLL,reg_cfg.RX_DLM,reg_cfg.TX_DLL,reg_cfg.TX_DLM,{reg_cfg.RX_DLM,reg_cfg.RX_DLL},{reg_cfg.TX_DLM,reg_cfg.TX_DLL}),UVM_LOW);
                end
                if(baud_rate == 3000000)begin
                  calc();
                    dlab=8'b1000_0000;
                    dlm=baud[15:8];
                    dll=baud[7:0];
                    reg_cfg.RX_DLL = baud[7:0];
                    reg_cfg.RX_DLM = baud[15:8];
                    reg_cfg.TX_DLL = baud[7:0];
                    reg_cfg.TX_DLM = baud[15:8];
                    `uvm_info(get_name(),$sformatf("THE baud rate value is %0d  and dll value is %0d and dlm value is %0d rx dll is %0d and rx dlm is %0d and tx dll is %0d and tx dlm is %0d combine rx value is %0d and tx value is %0d",baud,dll,dlm,reg_cfg.RX_DLL,reg_cfg.RX_DLM,reg_cfg.TX_DLL,reg_cfg.TX_DLM,{reg_cfg.RX_DLM,reg_cfg.RX_DLL},{reg_cfg.TX_DLM,reg_cfg.TX_DLL}),UVM_LOW);
                end
            end
            //-------  END BAUDRATE  --------//

            
            //-------  PARITY  ------//
            
            if($value$plusargs("parity=%d",enable))begin
                if(enable)begin        
                parity_arg=8'b0000_1000;
                reg_cfg.tx_parity       = PARITY_ENABLE;
                reg_cfg.tx_parity_types = EVEN_PARITY;
                reg_cfg.rx_parity       = PARITY_ENABLE;
                reg_cfg.rx_parity_types = EVEN_PARITY;
             end
            else
            begin
                reg_cfg.tx_parity = PARITY_DISABLE;
                reg_cfg.rx_parity = PARITY_DISABLE;
            end
            end
            //-------  END PARITY  ------//
            
            //-------  STOP BIT  ------//

            if($value$plusargs("stp_bit=%d",stop_bit))begin
                if(stop_bit==1.5 | stop_bit ==1)begin
                    //if(bit_no == 5)begin
                    stp_bit_set=8'b0000_0100;
                    reg_cfg.tx_stop_bit = ONE_STOP_BIT;
                    reg_cfg.rx_stop_bit = ONE_STOP_BIT;
                    reg_cfg.tx_stop_len = new[reg_cfg.tx_stop_bit+1];
                    reg_cfg.rx_stop_len = new[reg_cfg.rx_stop_bit+1];
                 // end 
                 // else begin
                   //   $fatal("PLEASE ENTER VALID STOP BIT");end
                end
                else if(stop_bit==2)begin
                    //if(bit_no==6 || bit_no==7 || bit_no==8)begin
                    stp_bit_set=8'b0000_0100;
                    reg_cfg.tx_stop_bit  = TWO_STOP_BIT;
                     reg_cfg.rx_stop_bit = TWO_STOP_BIT;
                     reg_cfg.tx_stop_len = new[reg_cfg.tx_stop_bit+1];
                     reg_cfg.rx_stop_len = new[reg_cfg.rx_stop_bit+1];
                    // end 
                    // else begin
                    // $fatal("PLEASE ENTER VALID STOP BIT");
                    // end
                end
                else
                    stp_bit_set=8'b0000_0000;
            end
            //------- END STOP BIT  ------//
            begin
                baud_set=dlab | bit_set;
                $display("baud_set=%b",baud_set);
            end
            begin
                lcr_set=parity_arg | bit_set |stp_bit_set;
                $display("lcr_set_reg=%b",lcr_set);
            end
            begin
                reg_cfg.tx_data_shift  = LSB_2_MSB;
                reg_cfg.rx_data_shift  = LSB_2_MSB;

                reg_cfg.tx_start_bit   = ONE_START_BIT;
                reg_cfg.rx_start_bit   = ONE_START_BIT;
                reg_cfg.tx_start_len   = new[reg_cfg.tx_start_bit+1];
                reg_cfg.rx_start_len   = new[reg_cfg.rx_start_bit+1];
                reg_cfg.tx_total_bit   = ((reg_cfg.tx_start_bit + 1) +  (reg_cfg.tx_word_length+5) + reg_cfg.tx_parity +(reg_cfg.tx_stop_bit+1));
                reg_cfg.rx_total_bit   = ((reg_cfg.rx_start_bit + 1) +  (reg_cfg.rx_word_length+5) + reg_cfg.rx_parity +(reg_cfg.rx_stop_bit+1));     
            end
    `uvm_info(get_full_name(),{"using uvm_default_printer show reg_configs\n",reg_cfg.sprint()},UVM_LOW);
 
end
endtask

function void calc();
    baud = (`FREQUANCY)*(`HZ)/(baud_rate*16);
    $display("Baud is %6f",baud);
endfunction



endclass
