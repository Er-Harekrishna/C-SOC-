class demoter extends uvm_report_catcher;
	
  function new(string name = "demoter");
    
    super.new(name);
  
  endfunction : new

  function action_e catch();
		
    //demote error to warning

    if((get_severity == UVM_ERROR) & (get_id == "BUSY_TO_NONSEQ_IDLE_INVALID_CHANGE")) begin
     
      set_severity(UVM_INFO);
      set_id("ERROR_DEMOTED");
      set_message("Configuration error demoted::");
     
    end
     
    return THROW;
	
  endfunction : catch

endclass : demoter


