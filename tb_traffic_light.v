// tham khao: // thao khao:  http://nguyenquanicd.blogspot.com/
`timescale 1ns/1ns

module tb_traffic_light;
  reg clk;
  reg rst_n;
  wire [2:0] street_a;
  wire [2:0] street_b;
  traffic_light dut
    (
	// output
	.street_a (street_a),
	.street_b (street_b),
	//input
	.clk      (clk),
	.rst_n    (rst_n)
	);
  initial 
    begin
      clk = 0;
	  forever #5 clk = ~clk;
	end
  initial
    begin
	  rst_n = 0;
	  #10 rst_n = 1;
	end
endmodule
