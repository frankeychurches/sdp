module lights_game(clk, reset, enable, up_down, leds);

parameter end_count = 12500000; //Maximum number to count to
//parameter end_count = 4; //Maximum number to count to

`include "MathFun.vh"

parameter N = CLogB2(end_count - 1);

input clk, reset, enable, up_down;
output [7:0] leds;

reg [7:0] leds_aux;
wire [N-1:0] count;
wire TC, shift_in, shift_out;
wire [13:0] PR;

assign shift_in = ~shift_out;

n_counter #(end_count) counter_leds (clk, reset, enable, up_down, count, TC);

n_shift_reg #(14) reg_14 (clk, reset, TC, shift_in, PR, shift_out);


always @(clk)

	if (!reset)
		leds_aux = 0;
		
	else
		if (PR == 14'b10000000000000 || PR == ~14'b10000000000000)
			leds_aux[7] = 1;
		else if (PR == 14'b11000000000000 || PR == ~14'b11000000000000 || PR == 14'b11111111111111)
			leds_aux[6] = 1;
		else if (PR == 14'b11100000000000 || PR == ~14'b11100000000000 || PR == 14'b11111111111110 || PR == ~14'b11111111111110)
			leds_aux[5] = 1;
		else if (PR == 14'b11110000000000 || PR == ~14'b11110000000000 || PR == 14'b11111111111100 || PR == ~14'b11111111111100)
			leds_aux[4] = 1;
		else if (PR == 14'b11111000000000 || PR == ~14'b11111000000000 || PR == 14'b11111111111000 || PR == ~14'b11111111111000)
			leds_aux[3] = 1;
		else if (PR == 14'b11111100000000 || PR == ~14'b11111100000000 || PR == 14'b11111111110000 || PR == ~14'b11111111110000)
			leds_aux[2] = 1;
		else if (PR == 14'b11111110000000 || PR == ~14'b11111110000000 || PR == 14'b11111111100000 || PR == ~14'b11111111100000)
			leds_aux[1] = 1;
		else if (PR == 14'b11111111000000 || PR == ~14'b11111111000000)
			leds_aux[0] = 1;
		else
			leds_aux[7] = 1;


assign leds[7] = leds_aux[7];
assign leds[6] = leds_aux[6];
assign leds[5] = leds_aux[5];
assign leds[4] = leds_aux[4];
assign leds[3] = leds_aux[3];
assign leds[2] = leds_aux[2];
assign leds[1] = leds_aux[1];
assign leds[0] = leds_aux[0];

endmodule

