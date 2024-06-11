class apb_uart_mon extends uvm_monitor;
`uvm_component_utils(apb_uart_mon)
 virtual apb_uart_intf vif;
 apb_uart_tx tx;
 uvm_analysis_port#(apb_uart_tx)ap_port;
 function new(string name="",uvm_component parent);
  super.new(name,parent);
 endfunction
function void build_phase(uvm_phase phase);
   super.build_phase(phase);
   //uvm_config_db#(virtual apb_uart_intf)::get(this," ","vif",vif);
   if(!(uvm_config_db#(virtual apb_uart_intf)::get(this,"","vif",vif)))
  `uvm_fatal("MY_ERR","Erron in virtual interface in monitor");     
   ap_port=new("ap_port",this);
 endfunction

task run_phase(uvm_phase phase);
 //tx=apb_uart_tx::type_id::create("tx");
  tx=new();
  forever begin
  wait(vif.preset==1);
  @(posedge vif.pclk)
  if(vif.pselx==1) begin
         tx.pselx = vif.pselx;

    if(vif.penable==1) begin
         tx.penable = vif.penable;
     wait(vif.pready==1);
     //Write operation
     if(vif.pwrite==1) begin
      if(vif.pslverr==1) begin
      //`uvm_error("monitor","pslverr");
      end
      else begin
         tx.paddr = vif.paddr;
         tx.pwrite = vif.pwrite;
         tx.pwdata = vif.pwdata;
         tx.pslverr = vif.pslverr;
      end 
     end
     //Read operation
     else if(vif.pwrite==0) begin
            if(vif.pslverr==1) begin
              //`uvm_error("monitor","pslverr");
            end
            else begin
              tx.paddr  = vif.paddr;
              tx.pwrite = vif.pwrite;
              tx.prdata  = vif.prdata;
              tx.pslverr = vif.pslverr;
            end 
          end
            ap_port.write(tx);
          end
          end
          end

 `uvm_info("Monitor",$sformatf("pclk=%0d,preset=%0d,paddr=%0d,pwrite=%0d,pwdata=%0d,prdata=%0d,pselx=%0d,penable=%0d",vif.pclk,vif.preset, vif.paddr,vif.pwrite,vif.pwdata,vif.prdata,vif.pselx,vif.penable),UVM_MEDIUM);  
endtask
endclass

