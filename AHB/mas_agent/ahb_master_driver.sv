/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  NAME      :- Pradip Prajapati
//  FILE_NAME :- AHB_master_drviver.sv
//  EDITED_BY :- karan patadiya(27-10-2023)
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/**
*  ABSTRACT : -
*           Driver is responsible to driving signal values to the inf/DUT.
*           We have used UVM driver-sequencer communication mechanism.
*           get_next_item and item_done methods of SEQ_ITEM_PORT is used. */

`ifndef AHB_MASTER_DRIVER
`define AHB_MASTER_DRIVER

`define MAS_DRV_CB mas_vif.ahb_mas_drv_cb
`define MAS_MON_CB mas_vif.ahb_mas_mon_cb

class ahb_mas_drv extends uvm_driver #(ahb_mas_trans);

  /**  factory registration  */
  `uvm_component_param_utils(ahb_mas_drv)
  `uvm_register_cb(ahb_mas_drv,driver_callback)

  /**   virtual interface    */
  virtual ahb_mas_inf mas_vif;

  /**   temporary variable   */
  uvm_master_slave_enum is_master;
  reg [`DATA_WIDTH-1:0] temp_queue[$]; 
  bit rst_flag;
  bit first_trans_wait;
  bit flag;
  htrans_enum trans_queue[$]; 
  int size_of_queue;
 
  /**    extern task and function  */
  extern function new(string name="ahb_mas_drv",uvm_component parent=null);
  extern task run_phase(uvm_phase phase);
  extern task reset();
  extern task send_to_dut();
  extern task addr_phase();
  extern task data_phase();
  extern function void addr_increment();
  extern function void flash_data();
  extern function void slv_error_task();
  extern task before_get_next_item();
  extern function void x_value_signal();
 
endclass : ahb_mas_drv

//*****************************************************************************
//                                METHODS
//*****************************************************************************

/**  new(constructor) method */
function ahb_mas_drv::new(string name="ahb_mas_drv",uvm_component parent=null);

  super.new(name,parent);

endfunction : new

/**                  RUN PHASE
*
*   DESCRIPTION:  -  In the run phase we have implemented driving logic of all
*   signals which are send to inf/DUT. In the RUN PHASE we have different task
*   function for same type of logic.
*   
*   EXPLANATION OF ALL TASK/FUNCTION:-
*   1)RESET TASK          : -  When active low reset asserted then our all signals are
*                              going into initial state as per specification. 
*   2)ADDR_PHASE TASK     : -  This method is used for driving all addr_phase signal.
*   3)DATA_PHASE TASK     : -  This method is used for driving wr_data to the
*   inf/dut.
*   4)SLV_ERROR  METHOD     : - When slave assert error then our driver call this
*                             task for going into IDLE state at second cycle of error along with this we
*                             are deleting our trans_type queue and data_queue.
*   5)ADDR_INCREMENT METHOD : - Our address is increment with the help of HSIZE value so this
*                             task contains that incrementation of address and for wrapping burst we need to wrap
*                             address at address boundary.
*   6)FLASH_DATA METHOD    : - This method contains, As per specification we need to delete trans and
*                             data queue and disable data_phase to complete transfer(iteration).
  * 7)BEFORE GFT_NEXT_ITEM METHOD :- This method used to check previous
  * transaction as per spectification and then move ahead for get_next_item.
    *
*                  */

/**   RUN PHASE   */
task ahb_mas_drv::run_phase(uvm_phase phase);
  
  wait(!mas_vif.hresetn)
    reset();
  
  forever begin
    fork
      forever begin
	
        before_get_next_item();                              //task_method_to check before get_next_item
        if(mas_vif.HRESP && (!mas_vif.HREADY))
          slv_error_task();
 
	else begin

          seq_item_port.get_next_item(req);
          rst_flag=1;
          `uvm_info("MASTER DRIVER","THIS IS INSIDE MASTER DRIVER",UVM_LOW) 
          req.print();
          send_to_dut();
          seq_item_port.item_done();
          size_of_queue=0;
          rst_flag=0;

        end

      end
       
      begin wait(!mas_vif.hresetn); end
          
  join_any

  disable fork;
    
  if(!mas_vif.hresetn)
    reset();
    
 end

endtask : run_phase

/**  reset task  */
task ahb_mas_drv::reset();

  `uvm_info("MASTER DRIVER","THIS IS MASTER SIDE RESET",UVM_LOW)
  
  `MAS_DRV_CB.HADDR     <= `ADDR_WIDTH'b0;
  `MAS_DRV_CB.HTRANS    <= 2'b0;
  `MAS_DRV_CB.HBURST    <= 3'b0;
  `MAS_DRV_CB.HMASTLOCK <= 1'b0;             
  `MAS_DRV_CB.HPROT     <= `HPROT_WIDTH'b0011; 
  `MAS_DRV_CB.HWRITE    <= 1'b0; 
  `MAS_DRV_CB.HMASTER   <= `HMASTER_WIDTH'b0;              
  `MAS_DRV_CB.HNONSEC   <= 1'b0;
  `MAS_DRV_CB.HSIZE     <= 3'b0;
  `MAS_DRV_CB.HWDATA    <= `DATA_WIDTH'b0;
  trans_queue.delete();
  temp_queue.delete();
     
  if(rst_flag==1) begin
    seq_item_port.item_done();
    rst_flag=0;
  end
     
  @(posedge mas_vif.hresetn);
  @(`MAS_DRV_CB);

endtask : reset

/**  send to_dut method  */
task ahb_mas_drv::send_to_dut();
      
  fork
    addr_phase();
    data_phase();
  join_any

endtask : send_to_dut

/**  address phase method  */
task ahb_mas_drv::addr_phase();

  req.calc();

  foreach(req.htrans_type[i])
    trans_queue.push_back(req.htrans_type[i]);
    
  if(req.idle_trans_queue.size>0) begin
    foreach(req.idle_trans_queue[i])
      trans_queue.push_back(req.idle_trans_queue[i]);
    `uvm_info(get_type_name,$sformatf("new transaction queue ===%p",trans_queue),UVM_DEBUG)
  end
  
 /* if(req.busy_trans_queue.size>0 && req.hburst_type!=hburst_enum'(SINGLE)) begin
    foreach(req.busy_trans_queue[i])
      trans_queue.insert(req.index_for_busy_transfer,req.busy_trans_queue[i]);
    `uvm_info(get_type_name,$sformatf("new transaction queue ===%p",trans_queue),UVM_DEBUG)
  end*/
 
  size_of_queue = $size(trans_queue);
  `uvm_info("MASTER DRIVER","THIS IS INSIDE ADDR PHASE",UVM_DEBUG)

  if(`MAS_MON_CB.HRESP && !`MAS_MON_CB.HREADY)
    slv_error_task();
	
  else begin

    if((`MAS_MON_CB.HTRANS!==htrans_enum'(BUSY) && `MAS_MON_CB.HTRANS!==htrans_enum'(IDLE)) && !`MAS_MON_CB.HREADY) begin

      while(!`MAS_MON_CB.HREADY) begin

        @(`MAS_DRV_CB);

        if(`MAS_MON_CB.HRESP && !`MAS_MON_CB.HREADY)
          slv_error_task();
	
      end

    end

    `MAS_DRV_CB.HWRITE <= req.HWRITE;
    if(req.enb_haddr_cross_boundary_cb==1) begin
       `uvm_do_callbacks(ahb_mas_drv,driver_callback,unaligned_haddr_error(req)); end

    `MAS_DRV_CB.HADDR    <= req.HADDR;
    `MAS_DRV_CB.HBURST   <= hburst_enum'(req.hburst_type);
    `MAS_DRV_CB.HTRANS   <= trans_queue.pop_front();
    `MAS_DRV_CB.HPROT    <= req.HPROT;
    `MAS_DRV_CB.HMASTLOCK<= req.HMASTLOCK;

    if(req.enb_hsize_greater_than_width_cb==1)begin 
       `uvm_do_callbacks(ahb_mas_drv,driver_callback,hsize_greater_than_data(req)); 
       `MAS_DRV_CB.HSIZE<=hsize_enum'(req.hsize_type);
    end
    
    else
      `MAS_DRV_CB.HSIZE  <= hsize_enum'(req.hsize_type);

    `uvm_info("MASTER DRIVER","THIS IS INSIDE FIRST NONSEQ",UVM_DEBUG)
        
    do begin	    
      first_trans_wait = 1;
      @(`MAS_DRV_CB);

      if(`MAS_MON_CB.HRESP && !`MAS_MON_CB.HREADY)
        slv_error_task();

    end while(!`MAS_MON_CB.HREADY);
  
   if(req.hburst_type!=hburst_enum'(SINGLE) || req.idle_trans_queue.size>0) begin
     for(int i=0;(i<size_of_queue-1);i++) begin
 
       if(!first_trans_wait)    
         @(`MAS_DRV_CB);
      
       if(first_trans_wait)
         first_trans_wait = 0;

       `uvm_info("MASTER DRIVER",$sformatf("THIS IS AFTER FIRST TRANSECTION OF TRANS TYPE -- %0d",i),UVM_DEBUG)

       if(`MAS_MON_CB.HRESP) begin
         `uvm_info("MASTER DRIVER","THIS IS IN ERROR SCENARION AFTER FIRST TRANSFER IF NOT SINGLE",UVM_DEBUG)
         slv_error_task();
         break;
        					          
        end

        else begin
          if(req.enb_hsize_change_in_between_burst_cb==1) begin
            `MAS_DRV_CB.HSIZE<=hsize_enum'($clog2(`DATA_WIDTH/8));
          end
          if(req.enb_hburst_change_in_between_burst_cb==1) begin
            `MAS_DRV_CB.HBURST<=hburst_enum'($urandom_range(0,7));
          end
         
          if(req.enb_x_value_cb==1) begin
            x_value_signal();
          end

          `uvm_info("MASTER DRIVER","THIS IS IN OKAY SCENARIO AFTER FIRST TRANSFER",UVM_HIGH)
       
          if(`MAS_MON_CB.HTRANS==htrans_enum'(BUSY) && !`MAS_MON_CB.HREADY) begin

            `uvm_info("MASTER DRIVER","THIS IS INSIDE BUSY WAITED SCENARIO",UVM_DEBUG)
          
            if(trans_queue[0]==SEQ && req.hburst_type!=SINGLE) begin

              `uvm_info("MASTER DRIVER","THIS IS INSIDE BUSY WAITED AND TRANS CHANGED TO SEQ FOR FIXED",UVM_DEBUG)
            
              `MAS_DRV_CB.HTRANS <= trans_queue.pop_front(); 
            
	      do begin

                @(`MAS_DRV_CB);
                if(`MAS_MON_CB.HRESP && !`MAS_MON_CB.HREADY)
                  slv_error_task();
	        
		first_trans_wait = 1;
	   
	      end while(!`MAS_MON_CB.HREADY);

            end

	    else if(trans_queue[0]==NONSEQ && req.hburst_type==INCR) begin
          
              `uvm_info("MASTER DRIVER","THIS IS INSIDE UNDEFINED BUSY WAITED CHANGED TO NONSEQ",UVM_DEBUG)
              flash_data();
              break;

            end

            else if(trans_queue[0]==IDLE && req.hburst_type==INCR) begin

              `uvm_info("MASTER DRIVER","THIS IS INSIDE UNDEFINED BUSY WAITED CHANGED TO IDLE",UVM_DEBUG)
            
              `MAS_DRV_CB.HTRANS <= trans_queue.pop_front();
              `MAS_DRV_CB.HADDR  <= $urandom;	
            
	      if(trans_queue[0]!=IDLE) begin	    

                @(`MAS_DRV_CB);
                flash_data();
                break;
	           
              end
           
            end 

	    else if(trans_queue[0]==BUSY)
              `MAS_DRV_CB.HTRANS <= trans_queue.pop_front();
	    
          end

          else if(`MAS_MON_CB.HTRANS==htrans_enum'(IDLE) && !`MAS_MON_CB.HREADY) begin

            `uvm_info("MASTER DRIVER","THIS IS INSIDE IDLE WAITED",UVM_DEBUG)

            if(trans_queue[0]==NONSEQ) begin
 
              `uvm_info("MASTER DRIVER","THIS IS INSIDE IDLE WAITED CHANGED TO NONSEQ",UVM_DEBUG)
	      flash_data();
              break;

            end

            else if (trans_queue[0]==IDLE)begin   //changed 25-01

              `uvm_info("MASTER DRIVER","THIS IS INSIDE IDLE WAITED CHANGED TO IDLE",UVM_DEBUG)
              `MAS_DRV_CB.HTRANS <= trans_queue.pop_front();
              `MAS_DRV_CB.HADDR  <= $urandom;
              @(`MAS_DRV_CB);
              flash_data();
	    
	    end	  

	    else begin

              `uvm_info("MASTER DRIVER","THIS IS INSIDE SEQ OR BUSY AFTER IDLE TRANSECTION",UVM_DEBUG)
              `MAS_DRV_CB.HTRANS <= trans_queue.pop_front();

            end
	
	  end

          else if(trans_queue[0]==BUSY && `MAS_MON_CB.HREADY) begin
 
            `uvm_info("MASTER DRIVER","THIS IS INSIDE BUSY TRANSECTION",UVM_DEBUG)
            
	    `MAS_DRV_CB.HTRANS <= trans_queue.pop_front();
	        
            if(`MAS_MON_CB.HTRANS!=BUSY)
              addr_increment();       
        
          end
        
          else if(trans_queue[0]==IDLE && `MAS_MON_CB.HREADY) begin

            `uvm_info("MASTER DRIVER","THIS IS INSIDE IDLE TRANSECTION",UVM_DEBUG)
          
            `MAS_DRV_CB.HTRANS <= trans_queue.pop_front();
             `MAS_DRV_CB.HADDR  <= $urandom;
             if(trans_queue[0]!=IDLE) begin
               flash_data();
               break;
             end

           end
        
           else begin
          
             `uvm_info("MASTER DRIVER","THIS IS INSIDE SEQ TRANSFER",UVM_DEBUG)
          
             if(`MAS_MON_CB.HTRANS!=htrans_enum'(BUSY)) begin
            
               `uvm_info("MASTER DRIVER","THIS IS SEQ IF PREV IS BUSY SO ADDR NOT CHANGE",UVM_DEBUG)

               while(!`MAS_MON_CB.HREADY) begin

                 @(`MAS_DRV_CB);

                 if(`MAS_MON_CB.HRESP && !`MAS_MON_CB.HREADY) begin
               
                   slv_error_task();
	           break;
                    	
                 end

               end

               addr_increment();
         
             end
         
	     if(trans_queue[0]==NONSEQ) begin

               `MAS_DRV_CB.HTRANS <= trans_queue.pop_front();
               flash_data();
               break;
	        
             end
      
             else begin
               `MAS_DRV_CB.HTRANS <= trans_queue.pop_front();
             end

           end
      
         end

       end
     end
     `uvm_info(get_type_name,"ADDR PHASE!!going to be end!!",UVM_LOW)
   end
endtask : addr_phase

/**  data phase method  */
task ahb_mas_drv::data_phase();
  
  if(req.HWRITE) begin
    
    foreach(req.HWDATA[i])
      temp_queue.push_back(req.HWDATA[i]);
      
  end

  `uvm_info("MASTER DRIVER","THIS IS INSIDE DATA PHASE",UVM_HIGH)

  for(int i=0; i<req.no_of_beats;i++)begin
  
    if(req.HWRITE) begin 

      `uvm_info("MASTER DRIVER","THIS IS INSIDE WRITE SCENARIO DATA PHASE",UVM_HIGH)
      
      @(`MAS_DRV_CB);          
      `uvm_info("MASTER DRIVER",$sformatf("THIS IS LOOP_COUNT -- %0d",i),UVM_HIGH)
      
      if(`MAS_MON_CB.HRESP==OKAY) begin

        `uvm_info("MASTER DRIVER","THIS IS INSIDE WRITE SCENARIO OKAY RESP DATA PHASE",UVM_DEBUG)
        foreach(temp_queue[i])
          `uvm_info("MASTER DRIVER",$sformatf("THIS IS TRANS -- %p",temp_queue[i]),UVM_DEBUG)
                      
        wait(`MAS_MON_CB.HREADY);  

        if(`MAS_MON_CB.HTRANS==htrans_enum'(BUSY) || `MAS_MON_CB.HTRANS==htrans_enum'(IDLE)) begin
        
          i--;      

        end

        else begin
         	        	         	  	          
          `uvm_info("MASTER DRIVER","THIS IS INSIDE DATA SENDING TO THE INTERFACE",UVM_HIGH)
          `MAS_DRV_CB.HWDATA<=temp_queue.pop_front();
       
        end

      end

      else begin
         
        `uvm_info("MASTER DRIVER","THIS IS INSIDE WRITE SCENARIO ERROR RESP DATA PHASE",UVM_HIGH)		
        break;
      
      end

    end

    else begin 
              
      `uvm_info("MASTER DRIVER","THIS IS INSIDE READ SCENARIO DATA PHASE",UVM_HIGH)
	
      @(`MAS_DRV_CB);

      `uvm_info("MASTER DRIVER",$sformatf("THIS IS LOOP_COUNT -- %0d",i),UVM_DEBUG)
      
      wait(`MAS_MON_CB.HREADY);      
      
      if(`MAS_MON_CB.HTRANS==htrans_enum'(BUSY) || `MAS_MON_CB.HTRANS==htrans_enum'(IDLE)) begin
  
        i--;

      end	
              
    end
    
  end
  `uvm_info(get_type_name,$sformatf("DATA PHASE!!size of queue==========%p",trans_queue),UVM_LOW)

  //repeat(req.no_of_wait) begin
  repeat(req.idle_trans_queue.size()) begin
   `uvm_info(get_type_name,$sformatf("value of wait=%0d",req.no_of_wait),UVM_LOW)
    @(`MAS_DRV_CB);
  end
  `uvm_info(get_type_name,"DATA PHASE!!going to be end!!",UVM_LOW)
endtask : data_phase

/** X value signal */
function void ahb_mas_drv::x_value_signal();
  if(req.enb_x_value_cb) begin
    `MAS_DRV_CB.HADDR     <= 'hX;
    `MAS_DRV_CB.HTRANS    <= 2'hx;
    `MAS_DRV_CB.HBURST    <= 3'hx;
    `MAS_DRV_CB.HMASTLOCK <= 1'hx;             
    `MAS_DRV_CB.HPROT     <= `HPROT_WIDTH'hx; 
    `MAS_DRV_CB.HWRITE    <= 1'hx; 
    `ifdef AHB_EXCLUSIVE_TR_PROPERTY  
      `MAS_DRV_CB.HMASTER   <= `HMASTER_WIDTH'hx;              
      `MAS_DRV_CB.HEXCL     <= 1'hx;    
    `endif
    `ifdef AHB_STROBE_PROPERTY  
      `MAS_DRV_CB.HWSTRB    <= {(`DATA_WIDTH/8){1'hx}};   
    `endif
     `ifdef AHB_SECURE_PROPERTY  
      `MAS_DRV_CB.HNONSEC   <= 1'hx;
     `endif 
     `MAS_DRV_CB.HSIZE     <= 3'hx;
     `MAS_DRV_CB.HWDATA    <= `DATA_WIDTH'hx;
  end
endfunction
/** before get_next_item method  */
task ahb_mas_drv::before_get_next_item(); 
        if(!((`MAS_MON_CB.HTRANS===htrans_enum'(BUSY) || `MAS_MON_CB.HTRANS===htrans_enum'(IDLE)) && !`MAS_MON_CB.HREADY && !`MAS_MON_CB.HRESP) && !first_trans_wait) begin

          `uvm_info("MASTER DRIVER","PREVIOUS TRANS IS NOT BUSY",UVM_HIGH)
           @(`MAS_DRV_CB);

	        if(!`MAS_MON_CB.HRESP && `MAS_MON_CB.HTRANS!==htrans_enum'(IDLE)) begin
            
	          while(!`MAS_MON_CB.HREADY) begin

              @(`MAS_DRV_CB);

              if(`MAS_MON_CB.HRESP && !`MAS_MON_CB.HREADY)
                 slv_error_task();
                            
            end

          end

        end

	      if(first_trans_wait)
          first_trans_wait = 0;

endtask

/**   slv_error_task  */
function void ahb_mas_drv::slv_error_task();
      
  `MAS_DRV_CB.HTRANS <= htrans_enum'(IDLE);
  `MAS_DRV_CB.HADDR  <= $urandom;
  temp_queue.delete();
  trans_queue.delete();
  disable data_phase;

endfunction : slv_error_task

/**   addr increment function */
function void ahb_mas_drv::addr_increment();

  req.HADDR += req.addr_incr;		  
  `MAS_DRV_CB.HADDR <= req.HADDR;
  
  if((req.HADDR==req.higher_boundary) && ((req.hburst_type==WRAP4) || (req.hburst_type==WRAP8) || (req.hburst_type==WRAP16))) begin

    `uvm_info("MASTER DRIVER","THIS IS SEQ IF PREV IS BUSY SO ADDR NOT CHANGE WRAP BOUNDRY",UVM_MEDIUM)
              
    `MAS_DRV_CB.HADDR <= req.lower_boundary;       
    req.HADDR = req.lower_boundary;
  end

endfunction : addr_increment

/**  flash data function */
function void ahb_mas_drv::flash_data();
 
  temp_queue.delete();
  trans_queue.delete();
  if(req.idle_trans_queue.size()==0)
    disable data_phase;
  
endfunction : flash_data
       
`endif
