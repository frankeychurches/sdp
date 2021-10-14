module lights_game(clk, reset, enable, up_down, leds);

//parameter end_count = 12500000; //Maximum number to count to
parameter end_count = 4; //Maximum number to count to

`include "MathFun.vh"

parameter N = CLogB2(end_count - 1);

input clk, reset, enable, up_down;
output [7:0] leds;

wire [N-1:0] count;
wire TC, shift_in, shift_out;
wire [13:0] PR;

assign shift_in = ~shift_out;

n_counter #(end_count) counter_leds (clk, reset, enable, up_down, count, TC);

n_shift_reg #(14) reg_14 (clk, reset, TC, shift_in, PR, shift_out);

assign leds[7] = (PR == 14'b10000000000000 || PR == ~14'b10000000000000) ? 1 : 0;
assign leds[6] = (PR == 14'b11000000000000 || PR == ~14'b11000000000000) ? 1 : (PR == 14'b11111111111111) ? 1 : 0;
assign leds[5] = (PR == 14'b11100000000000 || PR == ~14'b11100000000000) ? 1 : (PR == 14'b11111111111110) ? 1 : 0;
assign leds[4] = (PR == 14'b11110000000000 || PR == ~14'b11110000000000) ? 1 : (PR == 14'b11111111111100) ? 1 : 0;
assign leds[3] = (PR == 14'b11111000000000 || PR == ~14'b11111000000000) ? 1 : (PR == 14'b11111111111000) ? 1 : 0;
assign leds[2] = (PR == 14'b11111100000000 || PR == ~14'b11111100000000) ? 1 : (PR == 14'b11111111110000) ? 1 : 0;
assign leds[1] = (PR == 14'b11111110000000 || PR == ~14'b11111110000000) ? 1 : (PR == 14'b11111111100000) ? 1 : 0;
assign leds[0] = (PR == 14'b11111111000000 || PR == ~14'b11111111000000) ? 1 : 0;

//Tengo que usar un assign porque el registro usa flip flops y va retrasado una unidad 

endmodule

