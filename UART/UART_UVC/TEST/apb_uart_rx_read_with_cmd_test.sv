//BASIC TEST

class apb_uart_rx_read_with_cmd_test extends uart_base_test;
`uvm_component_utils(apb_uart_rx_read_with_cmd_test);
   uart_slave_write_seqs seq_h;
   //uart_slave_read_seqs sseq_h;  //write sequence handle
    uart_reg_config reg_cfg; 
   // dut_reg_config_seq  dut_reg_cfg;

   function new(string name="apb_uart_rx_read_with_cmd_test",uvm_component parent=null);
      super.new(name,parent);
          endfunction

  task configure_phase(uvm_phase phase);
      `uvm_info(get_name(), "configure_phase called", UVM_LOW)
      phase.raise_objection(this);
        //dut_reg_cfg = dut_reg_config_seq::type_id::create("reg_cfg");
        //dut_reg_cfg.start(env_h.apb_muvc_h.agent_h[0].seqr_h);
     
        phase.drop_objection(this);
        `uvm_info(get_name(), "configure_phase returning", UVM_LOW)
  endtask


task main_phase(uvm_phase phase);
    phase.raise_objection(this);
        //fork
        //begin
              seq_h= uart_slave_write_seqs::type_id::create("seq_h");
               seq_h.start(env_hh.uvc_h[0].tx_agent_h.seqr);
		   // end
		    
       // join_any
        phase.phase_done.set_drain_time(this,50000ms);
    phase.drop_objection(this);
endtask
endclass

