////////////////////////////////////////////////
// File:          uart_scoreboard.sv
// Version:       v1
// Developer:     JAYDEEP
// Project Name:  APB_UART Protocol
// Discription:   APB scoreboard file 
/////////////////////////////////////////////////
//
// Class Description:
//
//
`ifndef UART_SCOREBOARD_SV
`define UART_SCOREBOARD_SV
class uart_scoreboard extends uvm_scoreboard;
   // UVM Factory Registration Macro
   //   
   `uvm_component_utils(uart_scoreboard);
    static int pass_read_count,pass_write_count;
   //Analysis implementation for the master monitor
   //
   `uvm_analysis_imp_decl(_mas_mon)
   `uvm_analysis_imp_decl(_slv_mon)
  

   //Analysis implementation port declaration
   //
   uvm_analysis_imp_mas_mon#(uart_seq_item,uart_scoreboard) mmon_imp;
   uvm_analysis_imp_slv_mon#(uart_seq_item,uart_scoreboard) umon_imp;

   //Master transaction and Slave transaction class instance
   //
   //apb_master_trans uart_trans_h1;
   uart_seq_item uart_trans_h1; 
   uart_seq_item uart_trans_h2;
   //////////////////////////////////////////////
   
   bit[`DATA_WIDTH : 0]  act_data_write_q[$];                          //actual data collect queue from apb(TX)
   bit[`DATA_WIDTH : 0]  exp_data_write_q[$];                          //expected data collect queue from uart(TX)
   bit[`DATA_WIDTH : 0]  act_data_read_q[$];                     //actual data collect queue from uart(RX)
   bit[`DATA_WIDTH : 0]  exp_data_read_q[$];                     //expected data collect queue from apb(RX)
   bit wr;

    
   
 //int count;

   bit[`DATA_WIDTH :0 ] write_master_data;                         //local variable for TX apb data compare
   bit[`DATA_WIDTH :0 ] write_slave_data;                        //local variable for TX uart data compare
   bit[`DATA_WIDTH :0 ] read_master_data;                          //local variable for RX apb data compare
   bit[`DATA_WIDTH :0 ] read_slave_data;                         //local variable for RX uart data compare

   int i=0,j=0;                                                 //counter

   //------------------------------------------
   // Methods
   //------------------------------------------

   // Standard UVM Methods:  
   function new(string name = "uart_scoreboard",uvm_component parent);
      super.new(name,parent);
      //constructing the implementation ports
      mmon_imp = new("mmon_imp",this);
      umon_imp = new("umon_imp",this);
   endfunction : new

   //build_phase
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
       
      //Creating the master transaction and salve transaction
     
      uart_trans_h1 = new(); 
      uart_trans_h2 = new(); 

      //getting the virtual interface 
   endfunction : build_phase 




     //////////////////////////////////////////////////////////////////////////////
     
     function void write_mas_mon(uart_seq_item uart_trans_h1);
        `uvm_info(get_name(),$sformatf(" in master wr is =%0d if write mode(wr=1) or read mode(wr=0) ",uart_trans_h1.wr),UVM_LOW);
        if(uart_trans_h1.wr==1)begin                                                  //write mode from uart
         `uvm_info(get_name(),$sformatf("[BEFORE PUSH uart write master]exp_data_write=%p",exp_data_write_q),UVM_LOW);      //display the data of queue 
	
        exp_data_write_q.push_front(uart_trans_h1.tx_shifter);                              //uart write data rx_shifter pushed in exp_data_q
         `uvm_info(get_name(),$sformatf("[AFTER PUSH uart write master]exp_data_write=%p",exp_data_write_q),UVM_LOW);      //display the data of queue 
               end

        if(uart_trans_h1.wr==0) begin                                                 //read mode from uart
         `uvm_info(get_name(),$sformatf("[BEFORE PUSH in read master uart]act_data_read=%p",act_data_read_q),UVM_LOW);      //display the data of queue 
        act_data_read_q.push_front(uart_trans_h1.rx_shifter);
         `uvm_info(get_name(),$sformatf("[AFTER PUSH in read master uart]act_data_read=%p",act_data_read_q),UVM_LOW);      //display the data of queue 
                     
            compare_read();
        end
     endfunction 



     function void write_slv_mon(uart_seq_item uart_trans_h2);
        `uvm_info(get_name(),$sformatf(" in slave wr is =%0d  ",uart_trans_h2.wr),UVM_LOW);
        if(uart_trans_h2.wr==0)begin                                                  //write mode from uart
         `uvm_info(get_name(),$sformatf("[BEFORE PUSH uart write slave side]act_data_write=%p",act_data_write_q),UVM_LOW);      //display the data of queue 
	
        act_data_write_q.push_front(uart_trans_h2.rx_shifter);                              //uart write data rx_shifter pushed in exp_data_q
         `uvm_info(get_name(),$sformatf("[AFTER PUSH uart write slave side]act_data_write=%p",act_data_write_q),UVM_LOW);      //display the data of queue 
        compare_write();
        end

        if(uart_trans_h2.wr==1) begin                                                 //read mode from uart
        exp_data_read_q.push_front(uart_trans_h2.tx_shifter);
         `uvm_info(get_name(),$sformatf("[AFTER PUSH uart read operation]exp_data_read=%p",exp_data_read_q),UVM_LOW);      //display the data of queue 
                   end
     endfunction 


      function void compare_write();
      `uvm_info(get_name(),"INSIDE WRITE COMPARE CONDITION",UVM_LOW);           //write function(TX)
         begin
	   
          `uvm_info(get_name(),$sformatf("[AFTER PUSH uart read operation]exp_data_read=%p and act_data is %p",exp_data_read_q,act_data_write_q),UVM_LOW);      //display the data of queue 
           write_master_data=exp_data_write_q.pop_back();                                     //POP_BACK data from actual queue to local variable
           write_slave_data=act_data_write_q.pop_back();                                    //POP_BACK data from expected queue to local variable
           if (write_master_data==write_slave_data)begin                                 //comparing
              $display("act_data in compare=%p",write_master_data,$time);               //display compared act_data
              $display("exp_data in compare=%p",write_slave_data,$time);              //display compared exp_data
              $display("***********************************||||||||||| PASS WRITE DATA SUCESSFULLY |||||||||********************************\n");
              `uvm_info("passed condition", $sformatf("********---DATA MATCHED --->>>>>PASS<<<<<---********"), UVM_LOW)

              i=i+1;                                                                 //increament when pass
              $display("passed write condition time=%p",i);
              end
           else begin                                                                //in fail condition data print
              $display("act_data in compare=%p",write_master_data,$time);
              $display("exp_data in compare=%p",write_slave_data,$time);
              $display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<||| FAIL WRITE DATA MIS-MATCHED |||>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n");
	      `uvm_info("failed condition", $sformatf("********---DATA MIS-MATCHED ---||||||| FAIL ||||||||---********"), UVM_LOW)
              end
         end
      endfunction 
 
      function void compare_read();
      `uvm_info(get_name(),"INSIDE READ COMPARE CONDITION",UVM_LOW);            //read function(RX)
         begin
            // if(mon2sb_pool.exists(count))begin
                 read_master_data=act_data_read_q.pop_back();                                //POP_BACK data from actual queue to local variable
                 read_slave_data= exp_data_read_q.pop_back();
                 `uvm_info(get_type_name(),$sformatf("read_apb_data is %0d",read_slave_data),UVM_LOW);            
             end // if begin  
             //POP_BACK data from expected queue to local variable
             if (read_master_data==read_slave_data)begin
              $display("act_read_data in compare=%p",read_master_data,$time);          //display compared act_data
              $display("exp_read_data in compare=%p",read_slave_data,$time);           //display compared exp_data
              $display("***********************************||||||||||| PASS READ DATA SUCESSFULLY |||||||||********************************\n");
              `uvm_info("passed condition", $sformatf("********---DATA MATCHED --->>>>>PASS<<<<<---********"), UVM_LOW);

              j=j+1;
              $display("passed condition time=%p",j);
             end // if begin
           else begin                                                                //in fail condition data print
              $display("act_read_data in compare=%p",read_master_data,$time);
              $display("exp_read_data in compare=%p",read_slave_data,$time);
              $display("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<||| FAIL READ DATA MIS-MATCHED |||>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n");
	      `uvm_info("failed condition", $sformatf("********---DATA MIS-MATCHED ---||||||| FAIL ||||||||---********"), UVM_LOW)
	     
           end // else begin
          // end // begin
      endfunction 


      
endclass : uart_scoreboard
`endif //: APB_SCOREBOARD













