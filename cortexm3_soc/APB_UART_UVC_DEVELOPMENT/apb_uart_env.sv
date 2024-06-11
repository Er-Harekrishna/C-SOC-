class apb_uart_env extends uvm_env;
  `uvm_component_utils(apb_uart_env)
  function new(string name = " ", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  apb_uart_agent agent;
  apb_uart_sbd sbd;
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent = apb_uart_agent::type_id::create("agent", this);
    sbd = apb_uart_sbd::type_id::create("sbd", this);
  endfunction

   function void connect_phase(uvm_phase phase);
    agent.mon.ap_port.connect(sbd.ap_actual);
    agent.mon.ap_port.connect(sbd.ap_expected);
   endfunction  
endclass
  
