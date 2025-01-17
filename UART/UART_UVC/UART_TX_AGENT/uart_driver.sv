
/////////////////////////////////////////////////////////////////////////
// Company        : SCALEDGE 
// Engineer       : SIDDHARTH 
// Create Date    : 10-10-2023
// File Name   	  : uart_driver.sv
// Class Name 	  : uart_driver
// Project Name	  : UART_UVC 
// Description	  : 
//////////////////////////////////////////////////////////////////////////


class uart_driver extends uvm_driver#(uart_seq_item);

    //factory registration macro
    
    `uvm_component_utils(uart_driver);

    //virtual interface
    virtual uart_interface uif;
    uart_seq_item  req_que[$];
    uart_seq_item  req_h,trans_h;
    uart_reg_config  reg_cfg;
    int tx_count;

    function new(string name = "uart_driver",uvm_component parent);
        super.new(name,parent);
        reg_cfg = new("reg_cfg");
         `uvm_info(get_full_name(),{"using uvm_default_printer show reg_configs\n",reg_cfg.sprint()},UVM_DEBUG);
        trans_h = new();
        
    endfunction



    task reset_phase(uvm_phase phase);
        `uvm_info(get_name(), " ********************************************** reset_phase called ***************************************************************", UVM_MEDIUM)
        `DRV_CB.txd <= 1'b1;
        req_que.delete();
        trans_h.tx_shifter = 'b0;
        trans_h.TX_STATE  = trans_h.TX_STATE.first();
        trans_h.tx_gated_clk = 'b0;
        tx_count = 'b0;

        while(req != null)begin
            if(seq_item_port.has_do_available())begin
                seq_item_port.get_next_item(req);
                seq_item_port.item_done();
                `uvm_info(get_name(),$sformatf("seq_item_port is clearing"),UVM_LOW)
            end
            else
                req = null;
        end   
        `uvm_info(get_name(), "reset_phase returning", UVM_HIGH)
      endtask


    task main_phase(uvm_phase phase);
        
        super.main_phase(phase);
        forever begin
            fork
                forever @ (`DRV_CB) begin
                    //if(!reg_cfg.rst)
                   seq_item_port.get_next_item(req);
                   req_h = new req;
                   req_que.push_front(req_h);
                   `uvm_info(get_name(),$sformatf("req_que size is %0d and req_h location is %0d",req_que.size(),req_h),UVM_DEBUG);                    

                   seq_item_port.item_done();
                    
                 end
                transmit();
                baud_clk();
                count();
            join
        end
    endtask   

    task transmit();
        forever @(`DRV_CB)begin
            while(req_que.size() !=0 && trans_h.TX_STATE == IDLEE)begin
                 trans_h          = req_que.pop_back();
                  trans_h.tx_gated_clk = 1'b1;
                 trans_h.tx_shifter   ='b0;
                 uif.tx_shifter       ='b0;
                @(posedge trans_h.tx_shift)
                 `DRV_CB.txd          <= 1'b0;
                 trans_h.TX_STATE = trans_h.TX_STATE.next(); //start
                 uif.TX_STATE     = uif.TX_STATE.next(); 
                                `uvm_info(get_name(),{" Tx driver got the data in tx fifo is \n",trans_h.sprint()},UVM_LOW);                                
                foreach(`TX_START)begin
                    trans_h.TX_START = `DRV_CB.txd;
                    @(posedge trans_h.tx_shift);
                end // foreach tx start
                
                trans_h.TX_STATE = trans_h.TX_STATE.next(); //data
                uif.TX_STATE = uif.TX_STATE.next(); //data
                `uvm_info(get_name(),"time in driver before wait",UVM_LOW)
                
                foreach(`TX_CHAR_LEN)begin
                    case(reg_cfg.tx_data_shift)
                        MSB_2_LSB:
                        begin
                            `DRV_CB.txd <= trans_h.tx_fifo[`THR_SIZE-1];
                            trans_h.tx_fifo =  trans_h.tx_fifo << 1;
                            @(posedge trans_h.tx_shift);
                          end // begin
                       
                        LSB_2_MSB: 
                        begin
                            `DRV_CB.txd <= trans_h.tx_fifo[0:0];
                             trans_h.tx_fifo =  trans_h.tx_fifo >> 1;
                             @(posedge trans_h.tx_shift);
                        end // begin
                    endcase
                    
                end // foreach tx char len
               // #1; // for checker
                if(reg_cfg.tx_parity == PARITY_ENABLE)begin
                    trans_h.TX_STATE = trans_h.TX_STATE.next();
                     uif.TX_STATE = uif.TX_STATE.next();
                    case(reg_cfg.tx_parity_types)
                        EVEN_PARITY: even_parity();
                        ODD_PARITY: odd_parity();
                    endcase
                end //if  parity
               // #1; // for checker

                foreach(`TX_STOP_LEN)begin
                    `DRV_CB.txd <= 1'b1;
                    trans_h.TX_STATE = trans_h.TX_STATE.last();
                     uif.TX_STATE = uif.TX_STATE.last();
                    @(posedge trans_h.tx_shift);
                end // foreach(tx stop len)
                
               // #1; // for checker
                trans_h.TX_STATE = trans_h.TX_STATE.first();
                uif.TX_STATE = uif.TX_STATE.first();
                @(posedge trans_h.tx_shift);
                trans_h.tx_gated_clk = 1'b0;
            end // while

        end // forever
    endtask // transmit

    task even_parity();  
        
        trans_h.parity_data = ^ trans_h.parity_data;
        if(trans_h.parity_data == 0)begin
            `DRV_CB.txd <= 1'b0;
            @(posedge trans_h.tx_shift);
        end
        else if(trans_h.parity_data ==1)begin
            `DRV_CB.txd <= 1'b1;
            @(posedge trans_h.tx_shift);
        end

    endtask // even_parity

    task odd_parity();
    trans_h.parity_data = ^ trans_h.parity_data;
        
        if(trans_h.parity_data == 0)begin
            `DRV_CB.txd <= 1'b1;        
            @(posedge trans_h.tx_shift);

        end
        else if(trans_h.parity_data ==1)begin
            `DRV_CB.txd <= 1'b0;
            @(posedge trans_h.tx_shift);

        end


    endtask // odd_parity

      task baud_clk();

        forever wait (trans_h.tx_gated_clk)
            begin
              //when tx_count is equal to DLL AND DLH then one tx shift pulse generate acording that pulse data serially shifted
               if(tx_count == {reg_cfg.TX_DLM,reg_cfg.TX_DLL})    
               begin
                   trans_h.tx_shift = 1'b1;
                   uif.tx_shift    = 1'b1;
                   tx_count = 0;
                   uif.tx_count = 0;
                   #1;
                   trans_h.tx_shift = 0;
                   uif.tx_shift    = 1'b0;

               end // if 
               else begin
                   trans_h.tx_shift = 0;
                   uif.tx_shift    = 1'b0;
		   tx_count = tx_count + 1;
                   uif.tx_count = uif.tx_count + 1;
                   @(`DRV_CB);
               end
           end // wait

        //waiting for rx start conditon 
 endtask//baud_clk

  task count();
     forever begin
         wait(trans_h.TX_STATE == START)
         forever begin
             @(`DRV_CB)
             uif.count = uif.count + 1;
             if(trans_h.TX_STATE == IDLEE)begin
                 uif.count = 0;
                 break;
            end
         end
     end
 endtask

 
endclass
