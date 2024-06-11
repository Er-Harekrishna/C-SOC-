bit [31:0] glb_status;

function void start_test();
  glb_status = 32'b1;
endfunction : start_test

function void end_test();
  glb_status[1:0] = 2'b11;
endfunction : end_test
