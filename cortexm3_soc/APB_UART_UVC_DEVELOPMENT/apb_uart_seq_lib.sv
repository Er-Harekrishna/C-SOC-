
class apb_uart_seq extends uvm_sequence#(apb_uart_tx);
  `uvm_object_utils(apb_uart_seq)
  uvm_phase phase;
  function new(string name="");
  super.new(name);
  endfunction
  task pre_body();
    //phase=get_starting_phase();
    if(starting_phase!=null)
    phase.raise_objection(this);
//	phase.phase_done.set_drain_time(this,1000);
  endtask
  task post_body();
   if(starting_phase!=null)
   phase.drop_objection(this);
  endtask 
endclass

//write operation
class apb_uart_wr_seq extends apb_uart_seq;
  `uvm_object_utils (apb_uart_wr_seq)
  function new(string name=" ");
  super.new(name);
  endfunction  
task body();
  repeat(20)begin
    `uvm_do_with(req,{req.pwrite==1;})
  end
    endtask   
endclass


////Read operation
class apb_uart_rd_seq extends apb_uart_seq;
  `uvm_object_utils (apb_uart_rd_seq)
  function new(string name=" ");
  super.new(name);
  endfunction  
task body();
  repeat(20)begin
    `uvm_do_with(req,{req.pwrite==0;})
  end
    endtask   
endclass

//WRITE READ REGISTER
//Write after read operation to a specific address location
//INTERUUPT ENABLE REGISTER
//output FF
class apb_uart_wr_rd_spec_seq4 extends apb_uart_seq;
  `uvm_object_utils(apb_uart_wr_rd_spec_seq4)
  function new(string name=" ");
  super.new(name);
  endfunction  
task body();
  repeat(1)begin
    `uvm_do_with(req,{req.pwrite==1;req.paddr==12'h121;req.pwdata==32'h000321FF;})
  end
  repeat(1)begin
    `uvm_do_with(req,{req.pwrite==0;req.paddr==12'h121;})
  end
    endtask   
endclass

//WRITE READ REGISTER
//Write after read operation to a specific address location
//LINE CONTROL REGISTER
//output FF
class apb_uart_wr_rd_spec_seq5 extends apb_uart_seq;
  `uvm_object_utils(apb_uart_wr_rd_spec_seq5)
  function new(string name=" ");
  super.new(name);
  endfunction  
task body();
  repeat(1)begin
    `uvm_do_with(req,{req.pwrite==1;req.paddr==12'h123;req.pwdata==32'h000321FF;})
  end
  repeat(1)begin
    `uvm_do_with(req,{req.pwrite==0;req.paddr==12'h123;})
  end
    endtask   
endclass


//WRITE ONLY REGISTER
//Write after read operation to a specific address location
//FIFO CONTROL REGISTER
//output is equal to WDATA VLAUE
//from read it gives IIR VALUE
class apb_uart_wr_rd_spec_seq6 extends apb_uart_seq;
  `uvm_object_utils(apb_uart_wr_rd_spec_seq6)
  function new(string name=" ");
  super.new(name);
  endfunction  
task body();
  repeat(1)begin
    `uvm_do_with(req,{req.pwrite==1;req.paddr==12'h122;req.pwdata==32'h000321FF;})
  end
//  repeat(1)begin
//    `uvm_do_with(req,{req.pwrite==0;req.paddr==12'h122;})
//  end
    endtask   
endclass




//READ ONLY REGISTER
//Write after read operation to a specific address location
//INTERUUPT IDENTIFICATION REGISTER
//output C1
class apb_uart_wr_rd_spec_seq7 extends apb_uart_seq;
  `uvm_object_utils(apb_uart_wr_rd_spec_seq7)
  function new(string name=" ");
  super.new(name);
  endfunction  
task body();
//  repeat(1)begin
//    `uvm_do_with(req,{req.pwrite==1;req.paddr==12'h122;req.pwdata==32'h000321FF;})
//  end
  repeat(1)begin
    `uvm_do_with(req,{req.pwrite==0;req.paddr==12'h122;})
  end
    endtask   
endclass



//READ ONLY REGISTER
//Write after read operation to a specific address location
//LINE STATUS REGISTER
//output 
class apb_uart_wr_rd_spec_seq8 extends apb_uart_seq;
  `uvm_object_utils(apb_uart_wr_rd_spec_seq8)
  function new(string name=" ");
  super.new(name);
  endfunction  
task body();
  repeat(1)begin
    `uvm_do_with(req,{req.pwrite==1;req.paddr==12'h125;req.pwdata==32'h000321FF;})
  end
  repeat(1)begin
    `uvm_do_with(req,{req.pwrite==0;req.paddr==12'h125;})
  end
    endtask   
endclass


//READ ONLY REGISTER
//Write after read operation to a specific address location
//RECIEVER BUFFERABLE REGISTER
//output DEFAULT VALUE
class apb_uart_wr_rd_spec_seq9 extends apb_uart_seq;
  `uvm_object_utils(apb_uart_wr_rd_spec_seq9)
  function new(string name=" ");
  super.new(name);
  endfunction  
task body();
//  repeat(1)begin
//    `uvm_do_with(req,{req.pwrite==1;req.paddr==12'h125;req.pwdata==32'h000321FF;})
//  end
  repeat(1)begin
    `uvm_do_with(req,{req.pwrite==0;req.paddr==12'h120;})
  end
    endtask   
endclass



////READ ONLY REGISTER
////Write after read operation to a specific address location
////MODEM CONTROL REGISTER
////output DEFAULT VALUE 00
class apb_uart_wr_rd_spec_seq10 extends apb_uart_seq;
  `uvm_object_utils(apb_uart_wr_rd_spec_seq10)
  function new(string name=" ");
  super.new(name);
  endfunction  
task body();
//   repeat(1)begin
//    `uvm_do_with(req,{req.pwrite==1;req.paddr==12'h124;req.pwdata==32'h000321FF;})
//  end
  repeat(1)begin
    `uvm_do_with(req,{req.pwrite==0;req.paddr==12'h124;})
  end
    endtask   
endclass

////READ ONLY REGISTER
////Write after read operation to a specific address location
////MODEM STATUS REGISTER
////output DEFAULT VALUE 00
class apb_uart_wr_rd_spec_seq11 extends apb_uart_seq;
  `uvm_object_utils(apb_uart_wr_rd_spec_seq11)
  function new(string name=" ");
  super.new(name);
  endfunction  
task body();
//   repeat(1)begin
//    `uvm_do_with(req,{req.pwrite==1;req.paddr==12'h126;req.pwdata==32'h000321FF;})
//  end
  repeat(1)begin
    `uvm_do_with(req,{req.pwrite==0;req.paddr==12'h126;})
  end
    endtask   
endclass


////READ ONLY REGISTER
////Write after read operation to a specific address location
////SCRATCH REGISTER
////output DEFAULT VALUE 00
class apb_uart_wr_rd_spec_seq12 extends apb_uart_seq;
  `uvm_object_utils(apb_uart_wr_rd_spec_seq12)
  function new(string name=" ");
  super.new(name);
  endfunction  
task body();
//   repeat(1)begin
//    `uvm_do_with(req,{req.pwrite==1;req.paddr==12'h127;req.pwdata==32'h000321FF;})
//  end
  repeat(1)begin
    `uvm_do_with(req,{req.pwrite==0;req.paddr==12'h127;})
  end
    endtask   
endclass

//FUNCTIONAL TESTCASES
//BASIC WRITE_READ SEQUENCE
class apb_uart_wr_rd_spec_seq13 extends apb_uart_seq;
  `uvm_object_utils(apb_uart_wr_rd_spec_seq13)
  function new(string name=" ");
  super.new(name);
  endfunction  
task body();
   repeat(1)begin
    `uvm_do_with(req,{req.pwrite==1;req.paddr==12'h120;req.pwdata==32'h12345678;})
  end
  repeat(1)begin
    `uvm_do_with(req,{req.pwrite==0;req.paddr==12'h120;})
  end
    endtask   
endclass
//TX_RX FSM SEQUENCE
//To check the functionality for the divisor latch pin to enable tx and rx pin
//and check the LCR 7th bit
class apb_uart_wr_rd_spec_seq14 extends apb_uart_seq;
  `uvm_object_utils(apb_uart_wr_rd_spec_seq14)
  function new(string name=" ");
  super.new(name);
  endfunction  
task body();
   repeat(1)begin
    `uvm_do_with(req,{req.pwrite==1;req.paddr==12'h123;req.pwdata==32'h1234567F;})
  end
  repeat(1)begin
    `uvm_do_with(req,{req.pwrite==0;req.paddr==12'h123;})
  end
   repeat(1)begin
    `uvm_do_with(req,{req.pwrite==1;req.paddr==12'h120;req.pwdata==32'h1234567F;})
  end
  repeat(1)begin
    `uvm_do_with(req,{req.pwrite==0;req.paddr==12'h120;})
  end
    endtask   
endclass
//BAUD_RATE_SEQUENCE
//To check the data transefer for a perticular interval of time.
class apb_uart_wr_rd_spec_seq15 extends apb_uart_seq;
  `uvm_object_utils(apb_uart_wr_rd_spec_seq15)
  function new(string name=" ");
  super.new(name);
  endfunction  
task body();
   repeat(1)begin
    `uvm_do_with(req,{req.pwrite==1;req.paddr==12'h123;req.pwdata==32'h1234567F;})
  end
  repeat(1)begin
    `uvm_do_with(req,{req.pwrite==0;req.paddr==12'h123;})
  end
   repeat(1)begin
    `uvm_do_with(req,{req.pwrite==1;req.paddr==12'h120;req.pwdata==32'h12345601;})
  end
  repeat(1)begin
    `uvm_do_with(req,{req.pwrite==0;req.paddr==12'h120;})
  end
    endtask   
endclass


////Write_Error_cases
//class apb_uart_wr_error_seq extends apb_uart_seq;
//  `uvm_object_utils(apb_uart_wr_error_seq)
//  function new(string name=" ");
//  super.new(name);
//  endfunction  
//task body();
//  repeat(1)begin
//    `uvm_do_with(req,{req.paddr==270;req.pwrite==1;req.pwdata==32'h000000FF;})
//  end
//  endtask   
//endclass
//
//
////Read_Error_cases
//class apb_uart_rd_error_seq extends apb_uart_seq;
//  `uvm_object_utils(apb_uart_rd_error_seq)
//  function new(string name=" ");
//  super.new(name);
//  endfunction  
//task body();
//  repeat(1)begin
//    `uvm_do_with(req,{req.paddr==270;req.pwrite==0;req.pwdata==32'h000000FF;})
//  end
//    endtask   
//endclass
//

















































































































////write after read operation
//class apb_uart_wr_rd_seq extends apb_uart_seq;
//  `uvm_object_utils(apb_uart_wr_rd_seq)
//  function new(string name=" ");
//  super.new(name);
//  endfunction  
//task body();
//apb_uart_tx tx;
//apb_uart_tx txQ[$];
//repeat(1) begin
//	`uvm_do_with(req, {req.penable == 1;req.pselx==1;req.pwrite==1;})  //write tx
//  $display($time,"write sequence::req.penable=%0d ,req.pselx=%0d;req.pwrite=%0d,req.paddr=%0d,req.pwdata=%0h",req.penable,req.pselx,req.pwrite,req.paddr,req.pwdata);
//	tx = new req;	//Shallow copy
//	txQ.push_back(tx);// storing tx in a queue can be used during the tx
//end
////read from same location
//repeat(1) begin
//	tx=txQ.pop_front();//get the tx from the queue
//	`uvm_do_with(req, {req.pwrite == 0;req.penable == 1;req.pselx==1;req.paddr == tx.paddr;})
//  $display($time,"read sequence::req.penable=%0d ,req.pselx=%0d;req.addr=%0d,pwrite=%0d",req.penable,req.pselx,tx.paddr,req.pwrite);
//  end
//    endtask   
//endclass














































//
////read after write operation
//class apb_uart_rd_wr_seq extends apb_uart_seq;
//  `uvm_object_utils(apb_uart_rd_wr_seq)
//  function new(string name=" ");
//  super.new(name);
//  endfunction  
//task body();
//  repeat(1)begin
//    `uvm_do_with(req,{req.pwrite==1;req.paddr==8'h80;req.pwdata==32'h004321FF;})
//  end
//  repeat(1)begin
//    `uvm_do_with(req,{req.pwrite==0;req.paddr==8'h80;})
//  end
//  repeat(1)begin
//    `uvm_do_with(req,{req.pwrite==1;req.paddr==8'h70;req.pwdata==32'h000321FF;})
//  end
//    endtask   
//endclass
//
////Write_Error_cases
//class apb_uart_wr_error_seq extends apb_uart_seq;
//  `uvm_object_utils(apb_uart_wr_error_seq)
//  function new(string name=" ");
//  super.new(name);
//  endfunction  
//task body();
//  repeat(1)begin
//    `uvm_do_with(req,{req.paddr==270;req.pwrite==1;req.pwdata==32'h000000FF;})
//  end
//  endtask   
//endclass
//
//
////Read_Error_cases
//class apb_uart_rd_error_seq extends apb_uart_seq;
//  `uvm_object_utils(apb_uart_rd_error_seq)
//  function new(string name=" ");
//  super.new(name);
//  endfunction  
//task body();
//  repeat(1)begin
//    `uvm_do_with(req,{req.paddr==270;req.pwrite==0;req.pwdata==32'h000000FF;})
//  end
//    endtask   
//endclass
//
////n_write after n_read operation
//class apb_uart_n_wr_n_rd_seq extends apb_uart_seq;
//  `uvm_object_utils(apb_uart_n_wr_n_rd_seq)
//  function new(string name=" ");
//  super.new(name);
//  endfunction  
//task body();
//apb_uart_tx tx;
//apb_uart_tx txQ[$];
//int count=50;
//   // if(!(uvm_config_db#(int)::get(get_type(),get_name(),"count",count)))
//    //  `uvm_fatal("MY_ERR","Erron in virtual interface in driver");
//	for(int i=0;i<count;i++)begin//write tx
//		`uvm_do_with(req, {req.pwrite==1;req.paddr==8'h00+4*i;})
//		tx = new req; //Shallow copy
//    txQ.push_back(tx);// storing tx in a queue can be used during the tx
//	end
//   $display($time,"write sequence::req.penable=%0d ,req.pselx=%0d;req.pwrite=%0d,req.paddr=%0d,req.pwdata=%0h",req.penable,req.pselx,req.pwrite,req.paddr,req.pwdata);
//	for(int i=0;i<count;i++)begin
//        tx = txQ.pop_front();//get the tx from the queue
//		`uvm_do_with(req, {req.pwrite==0; 
//						   req.paddr==tx.paddr;})
//	end
//    $display($time,"read sequence::req.penable=%0d ,req.pselx=%0d;req.addr=%0d,pwrite=%0d",req.penable,req.pselx,tx.paddr,req.pwrite);
//endtask
//endclass
//
//
////Byte aligned transfer
//class apb_uart_wr_rd_byte_seq extends apb_uart_seq;
//  `uvm_object_utils(apb_uart_wr_rd_byte_seq)
//  function new(string name=" ");
//  super.new(name);
//  endfunction  
//task body();
//apb_uart_tx tx;
//apb_uart_tx txQ[$];
//repeat(1) begin
//	`uvm_do_with(req, {req.pwrite==1;req.paddr==8'h50;req.pstrb[0]==1'b1;req.pwdata==32'h000000FF;})  //write tx
//  $display($time,"write sequence::req.penable=%0d ,req.pselx=%0d;req.pwrite=%0d,req.paddr=%0d,req.pwdata=%0h",req.penable,req.pselx,req.pwrite,req.paddr,req.pwdata);
//	tx = new req;	//Shallow copy
//	txQ.push_back(tx);// storing tx in a queue can be used during the tx
//end
////read from same location
//repeat(1) begin
//	tx=txQ.pop_front();//get the tx from the queue
//	`uvm_do_with(req, {req.pwrite == 0;req.paddr == tx.paddr;req.pstrb==tx.pstrb;})
//  $display($time,"read sequence::req.penable=%0d ,req.pselx=%0d;req.addr=%0d,pwrite=%0d",req.penable,req.pselx,tx.paddr,req.pwrite);
//  end
//    endtask   
//endclass



