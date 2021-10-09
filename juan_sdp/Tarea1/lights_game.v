module lights_game(clk, reset, enable, up_down, count, TC);

parameter end_count = 16; //Maximum number to count to

`include "MathFun.vh"

parameter N = CLogB2(end_count - 1);

input clk, reset, enable, up_down;
output [N-1:0] count;
output TC;


n_counter #(end_count) counter_16 (clk, reset, enable, up_down, count, TC);

endmodule

