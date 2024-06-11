//class uart_slave_write_seqs extends uvm_sequence#(uart_seq_item);
class uart_slave_write_seqs extends uart_reg_config_seqs;
  `uvm_object_utils(uart_slave_write_seqs)
 // `uvm_declare_p_sequencer(uart_sequencer)
  uart_seq_item  seq_item_h;
  uart_reg_config reg_cfg;

function new(string str = "uart_slave_write_seqs");
  super.new(str);
  
  seq_item_h=new();

endfunction


task body();
 

  repeat(`NO_OF_WR_TRANS) begin
    //if(seq_item_h.kind_e == WRITE_ON)begin
       start_item(seq_item_h);
       assert(seq_item_h.randomize())
       `uvm_info(get_name(),$sformatf("[SEQS] data is generated in seq is %0d, and parity data is %0d",seq_item_h.tx_shifter,seq_item_h.parity_data),UVM_LOW);
	  finish_item(seq_item_h);
      // end // if write_on
    end // repeat


endtask //task

endclass //uart_slave_write_seqs
