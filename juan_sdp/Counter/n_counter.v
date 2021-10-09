module n_counter(clk, reset, enable, up_down, count, TC);

parameter end_count = 16; //Maximum number to count to

`include "MathFun.vh"

parameter N = CLogB2(end_count - 1);

input clk, reset, enable, up_down;
output reg [N-1:0] count;
output TC;

always @(posedge clk) 
begin

    if (enable && clk)
        if (!reset) 
            count <= 0;
        else
            if (up_down)
                count <= count + 1;
            else
                count <= count - 1;
    else
        count <=count;  
end

assign TC = (up_down && count == end_count - 1)? 1 : (!up_down && !count)? 1 : 0; 

endmodule

