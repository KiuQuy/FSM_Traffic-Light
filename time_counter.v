// tham khao: http://nguyenquanicd.blogspot.com/
module time_counter
  (
  input wire clk, rst_n, fsm_r, fsm_g, fsm_y,
  output wire g_end, r_end, y_end
  );
  
  parameter green_time  = 3;//4
  parameter yellow_time = 2;//3
  parameter red_time    = 4;//5
  // Khai bao signal
  reg [7:0] clk_counter;
  wire clr_counter;
  // start
  always @ (posedge clk)
    begin
	  if( (~rst_n) | clr_counter) clk_counter <= 8'd0;
	  else clk_counter <= clk_counter + 1'b1;
	end
  /* compare the end time_counter
  de phat di tin hieu ket thuc
  dang logic 1/0
  */
  assign g_end = fsm_g & (clk_counter == green_time);
  assign r_end = fsm_r & (clk_counter == red_time);
  assign y_end = fsm_y & (clk_counter == yellow_time);
  assign clr_counter = g_end | y_end | r_end;
endmodule