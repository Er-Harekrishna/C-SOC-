class apb_uart_cov extends uvm_subscriber#(apb_uart_tx);
`uvm_component_utils(apb_uart_cov)
apb_uart_tx tx;

covergroup apb_uart_cg;
  ADDR:coverpoint tx.paddr{
    bins addr0={[0:63]};
    bins addr1={[64:127]};
    bins addr2={[128:191]};
    bins addr3={[192:255]};
  }
 //  WDATA:coverpoint tx.pwdata{
 //   bins s0={[0:1000]};
 //   bins s1={[1001:10000]};
 //   bins s2={[10001:100000]};
 //   bins s3={[100000:$]};
  WRITE:coverpoint tx.pwrite{
   bins w0={1'b0};
   bins w1={1'b1};
  }
  ENABLE:coverpoint tx.penable{
   bins s1={1'b1};
   }
  SLVERR:coverpoint tx.pslverr{
   bins sve0={1'b0};
   //bins sve1={1'b1};
   }
wr_coverage:cross ADDR,WRITE;
wr_rd_enable:cross ADDR,ENABLE;
wr_rd_slverr:cross ADDR,SLVERR;
endgroup
  function new(string name="",uvm_component parent);
  super.new(name,parent);
  apb_uart_cg =new();
endfunction
  function void write(T t);
    $cast(tx,t);
    $display("coverage");
    tx.print();
    apb_uart_cg.sample();
  endfunction
  function void extract_phase(uvm_phase phase); `uvm_info("coverage",$sformatf("total_coverage=%0d",apb_uart_cg.get_coverage()),UVM_MEDIUM); 
  endfunction
endclass
