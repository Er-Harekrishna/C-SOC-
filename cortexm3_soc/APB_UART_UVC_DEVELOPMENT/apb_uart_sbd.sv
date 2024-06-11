`uvm_analysis_imp_decl(_actual)
`uvm_analysis_imp_decl(_expected)
class apb_uart_sbd extends uvm_scoreboard;
  `uvm_component_utils(apb_uart_sbd)
  apb_uart_tx tx,tx_a,tx_e,tx_aq[$],tx_eq[$];
  uvm_analysis_imp_actual#(apb_uart_tx ,apb_uart_sbd) ap_actual;
  uvm_analysis_imp_expected#(apb_uart_tx ,apb_uart_sbd) ap_expected;
  
  function new(string name="",uvm_component parent);
  super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
  super.build_phase(phase);
    ap_actual=new("ap_actual",this);
    ap_expected=new("ap_expected",this);
   endfunction
  
  function void write_actual(apb_uart_tx tx);
  tx_aq.push_back(tx);
  endfunction
  function void write_expected(apb_uart_tx tx);
  tx_eq.push_back(tx);
  endfunction
  
  task run_phase(uvm_phase phase);
  forever begin
    wait (tx_aq.size()>0);
    wait (tx_eq.size()>0);
    tx_a = (tx_aq.pop_front());
    tx_e = (tx_eq.pop_front());
    if(tx_a.compare(tx_e))
      `uvm_info("id","matching",UVM_NONE)
    else
      `uvm_info("id","not_matching",UVM_NONE)   
  end
   endtask
endclass  
