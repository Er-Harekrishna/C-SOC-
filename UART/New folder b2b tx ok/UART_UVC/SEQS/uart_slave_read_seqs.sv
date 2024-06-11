//class uart_slave_read_seqs extends uvm_sequence#(uart_seq_item);
class uart_slave_read_seqs extends uart_reg_config_seqs;
  `uvm_object_utils(uart_slave_read_seqs)
  `uvm_declare_p_sequencer(uart_sequencer)
  uart_seq_item  seq_item_h;
  uart_reg_config reg_cfg;

function new(string str = "uart_slave_read_seqs");
  super.new(str);
endfunction


task body();
forever begin
  p_sequencer.get_port.get(seq_item_h);  
  `uvm_info(get_name(),$sformatf("sequence item get direction is %s and @ time reg cfg rw is %s",seq_item_h.kind_e,reg_cfg.rw),UVM_LOW);  
  repeat(`NO_OF_WR_TRANS) begin
    if(seq_item_h.kind_e == WRITE_ON)begin
       if(!seq_item_h.randomize())
         `uvm_fatal(get_name()," sequence data NOT GENERATED ");
	 `uvm_info(get_name(),$sformatf("[SEQS] data is generated in seq is %0d, and parity data is %0d",seq_item_h.tx_shifter,seq_item_h.parity_data),UVM_LOW);
	  `uvm_send(seq_item_h);
       end // if write_on
    end // repeat
end//forever

endtask //task

endclass //uart_slave_read_seqs
