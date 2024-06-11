`define ADDR_WIDTH 9
`define DATA_WIDTH 32

module assertion(
  input clk,
  input resetn,
  input [`DATA_WIDTH-1:0]wdata,
  input [`ADDR_WIDTH-1:0]addr,
  input selx,
  input enable,
  input write,
  input [`DATA_WIDTH-1:0]rdata,
  input ready,
  input slverr
  );

property p1;
   disable iff(!resetn)
   @(posedge clk) selx |=> enable |-> ready;
 endproperty

 property p2;
   disable iff(!resetn)
   @(posedge clk) write |-> !$isunknown(wdata);
 endproperty

// property p3;
//   disable iff(!resetn)
//   @(posedge clk) !write |-> (enable && ready) |-> !slverr |-> ##[0:50]!$isunknown(rdata);
//   endproperty
//
//  property p4;
//   disable iff(!resetn)
//   @(posedge clk) !write |-> slverr |-> $isunknown(rdata);
//   endproperty

 // property p5;
 //  disable iff(!resetn)
 //  @(posedge clk) !write |-> slverr |-> $isunknown(wdata);
 //  endproperty

 //property p4;
 //disable iff(!resetn)
 //@(posedge clk) if(addr==270) (enable && ready && selx) |-> slverr;
 //else enable |-> ready; 
 ////@(posedge clk) $rose (write && selx) |-> ($stable(addr && wdata)[*2]) ##1 $rose (enable && ready) ##1 $fell (write && selx && enable && ready);
 //endproperty

 // property p2;
 //   disable iff(!resetn)
 //   @(posedge clk) selx |=> $stable(write);
 // endproperty


 // property p3;
 //   disable iff(!resetn)
 //   @(posedge clk) selx |=> $stable(addr);
 // endproperty
 // 
 // property p4;
 //   disable iff(!resetn)
 //   @(posedge clk) selx |=> $stable(wdata);
 // endproperty
 // 
 // property p5;
 //   disable iff(!resetn)
 //   @(posedge clk) enable |=> $stable(write);
 // endproperty

 // property p6;
 //   disable iff(!resetn)
 //   @(posedge clk) enable |=> $stable(addr);
 // endproperty
 // 
 // property p7;
 //   disable iff(!resetn)
 //   @(posedge clk) enable |=> $stable(wdata);
 // endproperty
 // 
 // property p8;
 //   disable iff(!resetn)
 //   @(posedge clk) ready |-> !$isunknown(slverr);
 // endproperty

 // property p9;
 //   disable iff(!resetn)
 //   @(posedge clk) (!write && ready) |-> !$isunknown(rdata);
 // endproperty
 // 
 // property p10;
 //   disable iff(!resetn)
 //   @(posedge clk) write |-> !$isunknown(addr);
 // endproperty
 // 
 // property p11;
 //   disable iff(!resetn)
 //   @(posedge clk) !write |-> !$isunknown(addr);
 // endproperty
 // 
 // property p12;
 //   disable iff(!resetn)
 //   @(posedge clk) write |-> !$isunknown(wdata);
 // endproperty
 // 
 // property p13;
 //   disable iff(!resetn)
 //   @(posedge clk) write |-> $isunknown(wdata);
 // endproperty

 //  property p14;
//    disable iff(!resetn)
//    @(posedge clk) selx |-> (!ready) |-> ##1 enable;
//  endproperty


  assert property (p1)
   `uvm_info("assertion_module","p1:assertion passed",UVM_LOW)
    else `uvm_error("assertion_module","p1:assertion failed")

  assert property (p2)
    `uvm_info("assertion_module","p2:assertion passed",UVM_LOW)
     else `uvm_error("assertion_module","p2:assertion failed")
  
//   assert property (p3)
//    `uvm_info("assertion_module","p3:assertion passed",UVM_LOW)
//     else `uvm_error("assertion_module","p3:assertion failed")
//
//   assert property (p4)
//    `uvm_info("assertion_module","p4:assertion passed",UVM_LOW)
//     else `uvm_error("assertion_module","p4:assertion failed")

 // assert property (p5)
 //   `uvm_info("assertion_module","p5:assertion passed",UVM_LOW)
 //   else `uvm_error("assertion_module","p5:assertion failed")
    
 // assert property (p6)
 //   `uvm_info("assertion_module","p6:assertion passed",UVM_LOW)
 //   else `uvm_error("assertion_module","p6:assertion failed")
 //   
 // assert property (p7)
 //   `uvm_info("assertion_module","p7:assertion passed",UVM_LOW)
 //   else `uvm_error("assertion_module","p7:assertion failed")

 // assert property (p8)
 //   `uvm_info("assertion_module","p8:assertion passed",UVM_LOW)
 //   else `uvm_error("assertion_module","p8:assertion failed")
 //   
 // assert property (p9)
 //   `uvm_info("assertion_module","p9:assertion passed",UVM_LOW)
 //   else `uvm_error("assertion_module","p9:assertion failed")
 //   
 // assert property (p10)
 //   `uvm_info("assertion_module","p10:assertion failed",UVM_LOW)
 //   else `uvm_error("assertion_module","p10:assertion failed")

 // assert property (p11)
 //   `uvm_info("assertion_module","p11:assertion passed",UVM_LOW)
 //   else `uvm_error("assertion_module","p11:assertion failed")
 //   
 // assert property (p12)
 //   `uvm_info("assertion_module","p12:assertion passed",UVM_LOW)
 //   else `uvm_error("assertion_module","p12:assertion failed")

 // assert property (p13)
 //   `uvm_info("assertion_module","p13:assertion passed",UVM_LOW)
 //   else `uvm_error("assertion_module","p13:assertion failed")


endmodule
