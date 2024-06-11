class apb_uart_agent extends uvm_agent;
  `uvm_component_utils(apb_uart_agent)
  function new(string name = " ", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  apb_uart_sqr sqr;
  apb_uart_drv drv;
  apb_uart_mon mon;
  apb_uart_cov cov;
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sqr = apb_uart_sqr::type_id::create("sqr", this);
    drv = apb_uart_drv::type_id::create("drv", this);
    mon = apb_uart_mon::type_id::create("mon", this);
    cov = apb_uart_cov::type_id::create("cov", this);
  endfunction


   function void connect_phase(uvm_phase phase);
     drv.seq_item_port.connect(sqr.seq_item_export);
     mon.ap_port.connect(cov.analysis_export);
   endfunction 
  
  
endclass
  
