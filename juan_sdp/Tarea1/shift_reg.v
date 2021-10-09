module n_shift_reg (clk, rst, enable, SR_in, PR, SR_out);

parameter N = 7;
input clk, rst, enable, SR_in;

output reg [N-1:0] PR;
output SR_out;

always @(posedge clk) 
begin
    if (!rst)
        PR <= 0;
    else
        if (enable)
            PR[N-1:0] <= {SR_in, PR[N-1:1]};
        else
            PR <= PR;
end

assign SR_out = PR[0];

endmodule