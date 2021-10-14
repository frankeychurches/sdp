module lights_game(clk, reset, enable, up_down, leds);

//parameter end_count = 12500000; //Maximum number to count to
parameter end_count = 4; //Maximum number to count to

`include "MathFun.vh"

parameter N = CLogB2(end_count - 1);

input clk, reset, enable, up_down;
output reg [7:0] leds;

wire [N-1:0] count;
wire TC, shift_in, shift_out;
wire [13:0] PR;

assign shift_in = ~shift_out;

n_counter #(end_count) counter_leds (clk, reset, enable, up_down, count, TC);

n_shift_reg #(14) reg_14 (clk, reset, TC, shift_in, PR, shift_out);

always @(posedge clk)
case (PR)
    14'b10000000000000 || ~(14'b10000000000000): leds = 8'b10000000; 
    14'b11000000000000 : leds = 8'b01000000; 
    14'b11100000000000 : leds = 8'b00100000; 
    14'b11110000000000 : leds = 8'b00010000; 
    14'b11111000000000 : leds = 8'b00001000; 
    14'b11111100000000 : leds = 8'b00000100; 
    14'b11111110000000 : leds = 8'b00000010; 
    14'b11111111000000 : leds = 8'b00000001; 

    14'b11111111100000 : leds = 8'b00000010; 
    14'b11111111110000 : leds = 8'b00000100; 
    14'b11111111111000 : leds = 8'b00001000; 
    14'b11111111111100 : leds = 8'b00010000; 
    14'b11111111111110 : leds = 8'b00100000; 
    14'b11111111111111 : leds = 8'b01000000; 
    default: leds = 8'b00000000;
endcase

//Tengo que usar un assign porque el registro usa flip flops y va retrasado una unidad 

endmodule

