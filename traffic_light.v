// thao khao: http://nguyenquanicd.blogspot.com/
module traffic_light
  (
  input clk, rst_n,
  output [2:0] street_a, street_b
  );
  // module traffic_light = fsm + time_counter
  /*Beginning of automatic wires 
  for undeclared instantiated-module outputs
  Voi nhung module khong khai bao: thi phai
  khai bao day
  */
  wire fsm_g, fsm_r, fsm_y, g_end, r_end, y_end;
  time_counter tc
  (
  //output
  .g_end (g_end),
  .y_end (y_end),
  .r_end (r_end),
  //input
  .clk   (clk),
  .rst_n (rst_n),
  .fsm_g (fsm_g),
  .fsm_r (fsm_r),
  .fsm_y (fsm_y)
  );
  
  fsm fsm
  (
  // output
  .street_a (street_a),
  .street_b (street_b),
  .fsm_g    (fsm_g),
  .fsm_r    (fsm_r),
  .fsm_y    (fsm_y),
  //input
  .clk      (clk),
  .rst_n    (rst_n),
  .g_end    (g_end),
  .r_end    (r_end),
  .y_end    (y_end)
  );
endmodule