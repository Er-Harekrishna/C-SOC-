class apb_uart_drv extends uvm_driver#(apb_uart_tx);
 `uvm_component_utils(apb_uart_drv)
  virtual apb_uart_intf vif;
  apb_uart_tx tx;
`define vif_mast_cb vif.mast_cb; 
   function new(string name="",uvm_component parent);
   super.new(name,parent);
   endfunction
  
  function void build_phase(uvm_phase phase);
   super.build_phase(phase);
   //uvm_config_db #(virtual apb_uart_intf)::get(this," ","vif",vif);
    if(!(uvm_config_db#(virtual apb_uart_intf)::get(this,"","vif",vif)))
      `uvm_fatal("MY_ERR","Erron in virtual interface in driver");
   endfunction   
   task run_phase(uvm_phase phase);
    forever begin
    seq_item_port.get_next_item(req);
    drive_tx(req);
    req.print();
    seq_item_port.item_done();
    end
   endtask
    
task drive_tx(apb_uart_tx tx);
wait(vif.preset==1);
 @(posedge vif.pclk);
 //vif.pclk=tx.pclk;
 //vif.preset=tx.preset;
 vif.pselx<=1;
 vif.penable<=0;
 @(posedge vif.pclk);
 vif.paddr<=tx.paddr;
 vif.pwrite<=tx.pwrite;
 vif.pwdata<=tx.pwdata;
 //vif.rx_i<=tx.rx;
 @(posedge vif.pclk);
 vif.pselx<=1;
 vif.penable<=1;
 wait(vif.pready==1);
 repeat(20)@(posedge vif.pclk);
 reset();
 @(posedge vif.pclk);
 `uvm_info("driver",$sformatf("pclk=%0d,preset=%0d,paddr=%0d,pwrite=%0d,pwdata=%0d,prdata=%0d,pselx=%0d,penable=%0d",vif.pclk,vif.preset, vif.paddr,vif.pwrite,vif.pwdata,vif.prdata,vif.pselx,vif.penable),UVM_MEDIUM);  
endtask

//task drive_tx(apb_uart_tx tx);
//    wait(vif.preset==1);
//    @(posedge vif.pclk);
//    vif.pselx <= 1;
//    vif.penable <= 0;
//    @(posedge vif.pclk);
//    vif.paddr <= tx.paddr;
//    vif.pwrite <= tx.pwrite;
//    vif.pwdata <= tx.pwdata;
//    @(posedge vif.pclk);
//    vif.penable <= 1;
//    wait(vif.pready==1);
//    @(posedge vif.pclk);
//    reset();
//    @(posedge vif.pclk);
//  endtask
task reset();
 @(posedge vif.pclk);
 vif.paddr<=0;
 vif.pwdata<=0;
 vif.pwrite<=0;
 vif.pselx <= 0;
 vif.penable <= 0;
 //vif.pstrb <= 0;
endtask

endclass
