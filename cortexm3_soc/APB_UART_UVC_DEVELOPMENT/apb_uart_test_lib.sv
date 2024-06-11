class apb_uart_test extends uvm_test;
`uvm_component_utils(apb_uart_test)
apb_uart_env env; 
  function new(string name =" ",uvm_component parent);
  super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
   super.build_phase(phase);
   env=apb_uart_env::type_id::create("env",this);
  endfunction  
  
  function void end_of_elaboration_phase(uvm_phase phase);
  uvm_top.print_topology();
  endfunction  
endclass 

//write and read location
//class apb_uart_wr_rd_test extends apb_uart_test;
//  `uvm_component_utils(apb_uart_wr_rd_test)
// 
//  function new(string name=" ",uvm_component parent);
//  super.new(name,parent);
//  endfunction 
//  task run_phase(uvm_phase phase);
//    apb_uart_wr_rd_seq seq1;
//    seq1=apb_uart_wr_rd_seq::type_id::create("seq1");
//    phase.raise_objection(this);
//    //phase.phase_done.set_drain_time(this,100);
//    seq1.start(env.agent.sqr);
//    phase.drop_objection(this);
//    //$display("apb_uart_test_library");
//  endtask
//endclass
//
////only write location
class apb_uart_wr_test extends apb_uart_test;
  `uvm_component_utils(apb_uart_wr_test)

  function new(string name=" ",uvm_component parent);
  super.new(name,parent);
  endfunction
  
  task run_phase(uvm_phase phase);
    apb_uart_wr_seq seq2;
    seq2=apb_uart_wr_seq::type_id::create("seq2");
    phase.raise_objection(this);
    //phase.phase_done.set_drain_time(this,100);
    seq2.start(env.agent.sqr);
    phase.drop_objection(this);
    //$display("apb_uart_test_library");
  endtask
endclass
 
//only read location 
class apb_uart_rd_test extends apb_uart_test;
  `uvm_component_utils(apb_uart_rd_test)

  function new(string name=" ",uvm_component parent);
  super.new(name,parent);
  endfunction
  
  task run_phase(uvm_phase phase);
    apb_uart_rd_seq seq3;
    seq3=apb_uart_rd_seq::type_id::create("seq3");
    phase.raise_objection(this);
    //phase.phase_done.set_drain_time(this,100);
    seq3.start(env.agent.sqr);
    phase.drop_objection(this);
    //$display("apb_uart_test_library");
  endtask
endclass

//WRITE READ REGISTER
//Write and read operation to a specific address location
class apb_uart_wr_rd_spec_test4 extends apb_uart_test;
  `uvm_component_utils(apb_uart_wr_rd_spec_test4)

  function new(string name=" ",uvm_component parent);
  super.new(name,parent);
  endfunction
  
  task run_phase(uvm_phase phase);
    apb_uart_wr_rd_spec_seq4 seq4;
    seq4=apb_uart_wr_rd_spec_seq4::type_id::create("seq4");
    phase.raise_objection(this);
    //phase.phase_done.set_drain_time(this,100);
    seq4.start(env.agent.sqr);
    phase.drop_objection(this);
    //$display("apb_uart_test_library");
  endtask
endclass


//WRITE READ REGISTER
//Write and read operation to a specific address location
class apb_uart_wr_rd_spec_test5 extends apb_uart_test;
  `uvm_component_utils(apb_uart_wr_rd_spec_test5)

  function new(string name=" ",uvm_component parent);
  super.new(name,parent);
  endfunction
  
  task run_phase(uvm_phase phase);
    apb_uart_wr_rd_spec_seq5 seq5;
    seq5=apb_uart_wr_rd_spec_seq5::type_id::create("seq5");
    phase.raise_objection(this);
    //phase.phase_done.set_drain_time(this,100);
    seq5.start(env.agent.sqr);
    phase.drop_objection(this);
    //$display("apb_uart_test_library");
  endtask
endclass



//WRITE READ REGISTER
//Write and read operation to a specific address location
class apb_uart_wr_rd_spec_test6 extends apb_uart_test;
  `uvm_component_utils(apb_uart_wr_rd_spec_test6)

  function new(string name=" ",uvm_component parent);
  super.new(name,parent);
  endfunction
  
  task run_phase(uvm_phase phase);
    apb_uart_wr_rd_spec_seq6 seq6;
    seq6=apb_uart_wr_rd_spec_seq6::type_id::create("seq6");
    phase.raise_objection(this);
    //phase.phase_done.set_drain_time(this,100);
    seq6.start(env.agent.sqr);
    phase.drop_objection(this);
    //$display("apb_uart_test_library");
  endtask
endclass




//WRITE READ REGISTER
//Write and read operation to a specific address location
class apb_uart_wr_rd_spec_test7 extends apb_uart_test;
  `uvm_component_utils(apb_uart_wr_rd_spec_test7)

  function new(string name=" ",uvm_component parent);
  super.new(name,parent);
  endfunction
  
  task run_phase(uvm_phase phase);
    apb_uart_wr_rd_spec_seq7 seq7;
    seq7=apb_uart_wr_rd_spec_seq7::type_id::create("seq7");
    phase.raise_objection(this);
    //phase.phase_done.set_drain_time(this,100);
    seq7.start(env.agent.sqr);
    phase.drop_objection(this);
    //$display("apb_uart_test_library");
  endtask
endclass




//WRITE READ REGISTER
//Write and read operation to a specific address location
class apb_uart_wr_rd_spec_test8 extends apb_uart_test;
  `uvm_component_utils(apb_uart_wr_rd_spec_test8)

  function new(string name=" ",uvm_component parent);
  super.new(name,parent);
  endfunction
  
  task run_phase(uvm_phase phase);
    apb_uart_wr_rd_spec_seq8 seq8;
    seq8=apb_uart_wr_rd_spec_seq8::type_id::create("seq8");
    phase.raise_objection(this);
    //phase.phase_done.set_drain_time(this,100);
    seq8.start(env.agent.sqr);
    phase.drop_objection(this);
    //$display("apb_uart_test_library");
  endtask
endclass



//WRITE READ REGISTER
//Write and read operation to a specific address location
class apb_uart_wr_rd_spec_test9 extends apb_uart_test;
  `uvm_component_utils(apb_uart_wr_rd_spec_test9)

  function new(string name=" ",uvm_component parent);
  super.new(name,parent);
  endfunction
  
  task run_phase(uvm_phase phase);
    apb_uart_wr_rd_spec_seq9 seq9;
    seq9=apb_uart_wr_rd_spec_seq9::type_id::create("seq9");
    phase.raise_objection(this);
    //phase.phase_done.set_drain_time(this,100);
    seq9.start(env.agent.sqr);
    phase.drop_objection(this);
    //$display("apb_uart_test_library");
  endtask
endclass



//WRITE READ REGISTER
//Write and read operation to a specific address location
class apb_uart_wr_rd_spec_test10 extends apb_uart_test;
  `uvm_component_utils(apb_uart_wr_rd_spec_test10)

  function new(string name=" ",uvm_component parent);
  super.new(name,parent);
  endfunction
  
  task run_phase(uvm_phase phase);
    apb_uart_wr_rd_spec_seq10 seq10;
    seq10=apb_uart_wr_rd_spec_seq10::type_id::create("seq10");
    phase.raise_objection(this);
    //phase.phase_done.set_drain_time(this,100);
    seq10.start(env.agent.sqr);
    phase.drop_objection(this);
    //$display("apb_uart_test_library");
  endtask
endclass


//WRITE READ REGISTER
//Write and read operation to a specific address location
class apb_uart_wr_rd_spec_test11 extends apb_uart_test;
  `uvm_component_utils(apb_uart_wr_rd_spec_test11)

  function new(string name=" ",uvm_component parent);
  super.new(name,parent);
  endfunction
  
  task run_phase(uvm_phase phase);
    apb_uart_wr_rd_spec_seq11 seq11;
    seq11=apb_uart_wr_rd_spec_seq11::type_id::create("seq11");
    phase.raise_objection(this);
    //phase.phase_done.set_drain_time(this,100);
    seq11.start(env.agent.sqr);
    phase.drop_objection(this);
    //$display("apb_uart_test_library");
  endtask
endclass



//WRITE READ REGISTER
//Write and read operation to a specific address location
class apb_uart_wr_rd_spec_test12 extends apb_uart_test;
  `uvm_component_utils(apb_uart_wr_rd_spec_test12)

  function new(string name=" ",uvm_component parent);
  super.new(name,parent);
  endfunction
  
  task run_phase(uvm_phase phase);
    apb_uart_wr_rd_spec_seq12 seq12;
    seq12=apb_uart_wr_rd_spec_seq12::type_id::create("seq12");
    phase.raise_objection(this);
    //phase.phase_done.set_drain_time(this,100);
    seq12.start(env.agent.sqr);
    phase.drop_objection(this);
    //$display("apb_uart_test_library");
  endtask
endclass

//FUNCTIONAL TESTCASES
//WRITE READ REGISTER
//Write and read operation to a specific address location
class apb_uart_wr_rd_spec_test13 extends apb_uart_test;
  `uvm_component_utils(apb_uart_wr_rd_spec_test13)

  function new(string name=" ",uvm_component parent);
  super.new(name,parent);
  endfunction
  
  task run_phase(uvm_phase phase);
    apb_uart_wr_rd_spec_seq13 seq13;
    seq13=apb_uart_wr_rd_spec_seq13::type_id::create("seq13");
    phase.raise_objection(this);
    //phase.phase_done.set_drain_time(this,100);
    seq13.start(env.agent.sqr);
    phase.drop_objection(this);
    //$display("apb_uart_test_library");
  endtask
endclass

//WRITE READ REGISTER
//Write and read operation to a specific address location
class apb_uart_wr_rd_spec_test14 extends apb_uart_test;
  `uvm_component_utils(apb_uart_wr_rd_spec_test14)

  function new(string name=" ",uvm_component parent);
  super.new(name,parent);
  endfunction
  
  task run_phase(uvm_phase phase);
    apb_uart_wr_rd_spec_seq14 seq14;
    seq14=apb_uart_wr_rd_spec_seq14::type_id::create("seq14");
    phase.raise_objection(this);
    //phase.phase_done.set_drain_time(this,100);
    seq14.start(env.agent.sqr);
    phase.drop_objection(this);
    //$display("apb_uart_test_library");
  endtask
endclass

//WRITE READ REGISTER
//Write and read operation to a specific address location
class apb_uart_wr_rd_spec_test15 extends apb_uart_test;
  `uvm_component_utils(apb_uart_wr_rd_spec_test15)

  function new(string name=" ",uvm_component parent);
  super.new(name,parent);
  endfunction
  
  task run_phase(uvm_phase phase);
    apb_uart_wr_rd_spec_seq15 seq15;
    seq15=apb_uart_wr_rd_spec_seq15::type_id::create("seq15");
    phase.raise_objection(this);
    //phase.phase_done.set_drain_time(this,100);
    seq15.start(env.agent.sqr);
    phase.drop_objection(this);
    //$display("apb_uart_test_library");
  endtask
endclass


//regression operation
class apb_uart_regression_test extends apb_uart_test;
  `uvm_component_utils(apb_uart_regression_test)
  function new(string name=" ",uvm_component parent);
  super.new(name,parent);
  endfunction
  task run_phase(uvm_phase phase);
    apb_uart_wr_seq seq2;
    apb_uart_rd_seq seq3;
    apb_uart_wr_rd_spec_seq4 seq4;   
    apb_uart_wr_rd_spec_seq5 seq5; 
    apb_uart_wr_rd_spec_seq6 seq6;
    apb_uart_wr_rd_spec_seq7 seq7;
    apb_uart_wr_rd_spec_seq8 seq8;
    apb_uart_wr_rd_spec_seq9 seq9;
    apb_uart_wr_rd_spec_seq10 seq10; 
    apb_uart_wr_rd_spec_seq11 seq11;
    apb_uart_wr_rd_spec_seq12 seq12;
    seq2=apb_uart_wr_seq::type_id::create("seq2");
    seq3=apb_uart_rd_seq::type_id::create("seq3");
    seq4=apb_uart_wr_rd_spec_seq4::type_id::create("seq4");
    seq5=apb_uart_wr_rd_spec_seq5::type_id::create("seq5");
    seq6=apb_uart_wr_rd_spec_seq6::type_id::create("seq6");
    seq7=apb_uart_wr_rd_spec_seq7::type_id::create("seq7");
    seq8=apb_uart_wr_rd_spec_seq8::type_id::create("seq8");
    seq9=apb_uart_wr_rd_spec_seq9::type_id::create("seq9");
    seq10=apb_uart_wr_rd_spec_seq10::type_id::create("seq10");
    seq11=apb_uart_wr_rd_spec_seq11::type_id::create("seq11");
    seq12=apb_uart_wr_rd_spec_seq12::type_id::create("seq12");
    phase.raise_objection(this);
    phase.phase_done.set_drain_time(this,100);
    seq2.start(env.agent.sqr);
    seq3.start(env.agent.sqr);
    seq4.start(env.agent.sqr);
    seq5.start(env.agent.sqr);
    seq6.start(env.agent.sqr);
    seq7.start(env.agent.sqr);
    seq8.start(env.agent.sqr);
    seq9.start(env.agent.sqr);
    seq10.start(env.agent.sqr);
    seq11.start(env.agent.sqr);
    seq12.start(env.agent.sqr);
    phase.drop_objection(this);
  endtask
endclass























































































//read after write location 
//class apb_uart_rd_wr_test extends apb_uart_test;
//  `uvm_component_utils(apb_uart_rd_wr_test)
//
//  function new(string name=" ",uvm_component parent);
//  super.new(name,parent);
//  endfunction
//  
//  task run_phase(uvm_phase phase);
//    apb_uart_rd_wr_seq seq5;
//    seq5=apb_uart_rd_wr_seq::type_id::create("seq5");
//    phase.raise_objection(this);
//    //phase.phase_done.set_drain_time(this,100);
//    seq5.start(env.agent.sqr);
//    phase.drop_objection(this);
//    //$display("apb_uart_test_library");
//  endtask
//endclass
//
////Write error cases 
//class apb_uart_wr_error_test extends apb_uart_test;
//  `uvm_component_utils(apb_uart_wr_error_test)
//
//  function new(string name=" ",uvm_component parent);
//  super.new(name,parent);
//  endfunction
//  
//  task run_phase(uvm_phase phase);
//    apb_uart_wr_error_seq seq6;
//    seq6=apb_uart_wr_error_seq::type_id::create("seq6");
//    phase.raise_objection(this);
//    phase.phase_done.set_drain_time(this,100);
//    seq6.start(env.agent.sqr);
//    phase.drop_objection(this);
//    //$display("apb_uart_test_library");
//  endtask
//endclass
//
////Read error cases 
//class apb_uart_rd_error_test extends apb_uart_test;
//  `uvm_component_utils(apb_uart_rd_error_test)
//
//  function new(string name=" ",uvm_component parent);
//  super.new(name,parent);
//  endfunction
//  
//  task run_phase(uvm_phase phase);
//    apb_uart_rd_error_seq seq7;
//    seq7=apb_uart_rd_error_seq::type_id::create("seq7");
//    phase.raise_objection(this);
//    phase.phase_done.set_drain_time(this,10);
//    seq7.start(env.agent.sqr);
//    phase.drop_objection(this);
//    //$display("apb_uart_test_library");
//  endtask
//endclass
//
//
//
////regression operation
//class apb_uart_regression_test extends apb_uart_test;
//  `uvm_component_utils(apb_uart_regression_test)
//  function new(string name=" ",uvm_component parent);
//  super.new(name,parent);
//  endfunction
//  task run_phase(uvm_phase phase);
//    apb_uart_n_wr_n_rd_seq seq8;
//    apb_uart_rd_error_seq seq7;
//    apb_uart_wr_error_seq seq6;
//    seq8=apb_uart_n_wr_n_rd_seq::type_id::create("seq8");
//    seq7=apb_uart_rd_error_seq::type_id::create("seq7");
//    seq6=apb_uart_wr_error_seq::type_id::create("seq6");
//    phase.raise_objection(this);
//    phase.phase_done.set_drain_time(this,100);
//    seq8.start(env.agent.sqr);
//    seq7.start(env.agent.sqr);
//    seq6.start(env.agent.sqr);
//    phase.drop_objection(this);
//  endtask
//endclass
//
////n_write after n_read operation
//class apb_uart_n_wr_n_rd_test extends apb_uart_test;
//  `uvm_component_utils(apb_uart_n_wr_n_rd_test)
//  function new(string name=" ",uvm_component parent);
//  super.new(name,parent);
//  endfunction
////function void build_phase(uvm_phase phase);
////		super.build_phase(phase);
////		uvm_resource_db#(int)::set("GLOBAL","COUNT",50,this);
////  endfunction
//  task run_phase(uvm_phase phase);
//    apb_uart_n_wr_n_rd_seq seq8;
//    seq8=apb_uart_n_wr_n_rd_seq::type_id::create("seq8");
//    phase.raise_objection(this);
//    phase.phase_done.set_drain_time(this,100);
//    seq8.start(env.agent.sqr);
//    phase.drop_objection(this);
//    //$display("apb_uart_test_library");
//  endtask
//endclass
//
//
////Byte aligned operation
//class apb_uart_wr_rd_byte_test extends apb_uart_test;
//  `uvm_component_utils(apb_uart_wr_rd_byte_test)
//  function new(string name=" ",uvm_component parent);
//  super.new(name,parent);
//  endfunction
//
//  task run_phase(uvm_phase phase);
//    apb_uart_wr_rd_byte_seq seq9;
//    seq9=apb_uart_wr_rd_byte_seq::type_id::create("seq9");
//    phase.raise_objection(this);
//    phase.phase_done.set_drain_time(this,100);
//    seq9.start(env.agent.sqr);
//    phase.drop_objection(this);
//    //$display("apb_uart_test_library");
//  endtask
//endclass



 
