class slv_drv_callback extends uvm_callback;

  `uvm_object_utils(slv_drv_callback)

   function new(string name="slv_drv_callback");
     super.new(name);
   endfunction 
  

virtual task hresp_cycle_count(ahb_slv_trans trans_h);
endtask

endclass 

