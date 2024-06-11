//BASIC TEST

class uart_tx_rx_write_read_with_cmd_test extends uart_base_test;
`uvm_component_utils(uart_tx_rx_write_read_with_cmd_test);
   //apb_uart_tx_rx_write_read_with_cmd_seqs seq_h;
   uart_slave_write_seqs seq_h;
   uart_slave_write_seqs sseq_h;  //write sequence handle
    uart_reg_config reg_cfg;
    
 //dut_reg_config_seq  dut_reg_cfg;


   function new(string name="uart_tx_rx_write_read_with_cmd_test",uvm_component parent=null);
      super.new(name,parent);
          
    endfunction

  task configure_phase(uvm_phase phase);
      `uvm_info(get_name(), "configure_phase called", UVM_LOW)
      phase.raise_objection(this);
        //dut_reg_cfg = dut_reg_config_seq::type_id::create("reg_cfg");
        //dut_reg_cfg.start(env_h.apb_muvc_h.agent_h[0].seqr_h);
        //agcfg[0].is_agent = BOTH_AGENT;
        //agcfg[1].is_agent = BOTH_AGENT;
        phase.drop_objection(this);
        `uvm_info(get_name(), "configure_phase returning", UVM_LOW)
  endtask


task main_phase(uvm_phase phase);
    phase.raise_objection(this);
        fork
        begin
              seq_h= uart_slave_write_seqs::type_id::create("seq_h");
	     reg_cfg.rw=WRITE_ON;
	     // `uvm_info("[FROM TEST]",$sformatf(" env handle is %0d ",env_hh),UVM_LOW)
               seq_h.start(env_hh.uvc_h[0].tx_agent_h.seqr);
		    end
		    join
		    #9000;
		    begin
                sseq_h =  uart_slave_write_seqs::type_id::create("sseq_h");      //create sequence    
                `uvm_info("SEQ_CHECK","slave_sequance start after a write zero",UVM_LOW)
                reg_cfg.rw = WRITE_ON; 
                sseq_h.start(env_hh.uvc_h[1].tx_agent_h.seqr);            //start write sequence
		    end 
        //join_any
        phase.phase_done.set_drain_time(this,50000ms);
    phase.drop_objection(this);
endtask

//------ REPORT PHASE ------//

function void report_phase(uvm_phase phase);
   // handle of report server             
   uvm_report_server svr;
   //super.report_phase(phase);

   // get server in svr handle 
   svr = uvm_report_server::get_server();
 
   // if both count is zero than test case success  
    if((svr.get_severity_count(UVM_ERROR) + svr.get_severity_count(UVM_FATAL) ) == 0)begin
           $display("/////////////////////////////////");
           $display("    #####  #####  ##### #####    ");
           $display("    #   #  #   #  #     #        ");
           $display("    #   #  #   #  #     #        ");
           $display("    #####  #####  ##### #####    ");
           $display("    #      #   #      #     #    ");
           $display("    #      #   #      #     #    ");
           $display("    #      #   #  ##### #####    ");
       $display("/////////////////////////////////");
        end
        else begin
           $display("///////////////////////////////////////");
           $display("    #####  #####  #####  #        ");
           $display("    #      #   #    #    #        ");
           $display("    #      #   #    #    #        ");
           $display("    #####  #####    #    #        ");
           $display("    #      #   #    #    #        ");
           $display("    #      #   #    #    #        ");
           $display("    #      #   #  #####  ######   ");
           $display("///////////////////////////////////////");
           end
   endfunction 
endclass
