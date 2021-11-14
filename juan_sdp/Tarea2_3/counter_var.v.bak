module counter_var (
    clk, reset, entrada, enable, modo, cuenta, TC
);

parameter width_count = 4;
localparam [width_count - 1:0] modulo_good = 2 ** width_count - 1;

input clk, reset, enable, modo;
input [width_count - 1:0] entrada;

output reg [width_count - 1:0] cuenta;
output TC;

wire [width_count - 1:0] cuenta_fin;

assign cuenta_fin = (modo == 1) ? entrada : modulo_good;
assign TC = (cuenta == cuenta_fin && enable == 1) ? 1 : 0;

always @(posedge clk or negedge reset) 
    if(!reset)
        cuenta <= 0;
    else
        if(enable)
            if(cuenta == cuenta_fin)
                cuenta <= 0;
            else 
                cuenta <= cuenta + 1; 
endmodule