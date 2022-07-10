// Tham khao:  http://nguyenquanicd.blogspot.com/

module fsm
  (   
  input wire clk, rst_n, g_end, y_end, r_end, 
  output reg [2:0] street_a, street_b, 
  output wire fsm_g, fsm_r, fsm_y
  );
  // internal signal 
  reg [2:0] current_state, next_state;
  localparam AG_BR  = 3'd0;
  localparam AY_BR  = 3'd1;
  localparam AR_BR1 = 3'd2; // trang thai khoi dong
  localparam AR_BG  = 3'd3;
  localparam AR_BY  = 3'd4;
  localparam AR_BR2 = 3'd5;
  // Next state logic
  always @ (*) 
    begin
	  case(current_state)
	    AG_BR:
		  begin
		    if(g_end) next_state = AY_BR;
			else next_state = current_state;
		  end
	    AY_BR:
		  begin
		    if(y_end) next_state =  AR_BR1;
			else next_state = current_state;
		  end
		AR_BR1:
		  begin
		    if(r_end) next_state = AR_BG;
			else next_state = current_state;
		  end
		AR_BG:
		  begin
		    if(g_end) next_state = AR_BY;
			else next_state = current_state;
		  end
		AR_BY:
		  begin 
		    if(y_end) next_state = AR_BR2;
			else next_state= current_state;
		  end
		AR_BR2: 
		  begin 
		    if(r_end) next_state = AG_BR;
			else next_state = current_state;
		  end
		default: next_state = current_state;
	  endcase
	end
	// state logic
	always @ (posedge clk) 
	   begin
	     if(~rst_n) current_state <= AR_BR1;
		 else current_state <= next_state;
	  end
	// output:
	always @ (*) 
	  begin
	    case(current_state)
		  AG_BR: street_a = 3'b100;
		  AY_BR: street_a = 3'b010;
		  default: street_a = 3'b001;
		endcase
	  end
	always @ (*)
	  begin
	    case(current_state)
		  AR_BG: street_b = 3'b100;
		  AR_BY: street_b = 3'b010;
		  default: street_b = 3'b001;
		endcase
	  end
  // fsm_g: tin hieu nay de truyen toi khoi time counter de dem thoi gian
  assign fsm_g = (current_state == AG_BR)|(current_state == AR_BG);
  assign fsm_y = (current_state == AY_BR)|(current_state == AR_BY);
  assign fsm_r = (current_state == AR_BR1) | (current_state == AR_BR2);
  
endmodule
  