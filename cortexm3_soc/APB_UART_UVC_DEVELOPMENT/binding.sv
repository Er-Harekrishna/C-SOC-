`include "assertion.sv"
module binding;
initial begin
    $display("debug_1");
  end
  bind apb_uart assertion dut(
    .clk(pclk),
    .resetn(presetn),
    .wdata(pwdata),
    .addr(paddr),
    .selx(pselx),
    .enable(penable),
    .write(pwrite),
    .rdata(prdata),
    .ready(pready),
    .slverr(pslverr)
  ); 
  
endmodule
