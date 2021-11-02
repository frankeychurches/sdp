module Practica_FSM (
    input clk, rst, up_down, enable, 
    output [3:0] seq
);

//(* syn_encoding = "user" *) reg [3: 0] estado_actual;
reg [3: 0] estado_actual;

parameter [3:0] S0 = 4'b0000, S1 = 4'b0010, S2 = 4'b0011, S3 = 4'b0101, S4 = 4'b00111, S5 = 4'b01010;

always @(posedge clk or negedge rst) begin
    if (!rst) 
        estado_actual <= S1;
    else 
        if(enable)
            case (estado_actual)
                S0: estado_actual <= S1;
                S1: if (up_down)
                        estado_actual <= S2;
                    else 
                        estado_actual <= S5;
                S2: if (up_down)
                        estado_actual <= S3;
                    else 
                        estado_actual <= S1;
                S3: if (up_down)
                        estado_actual <= S4;
                    else 
                        estado_actual <= S2;
                S4: if (up_down)
                        estado_actual <= S5;
                    else 
                        estado_actual <= S3;
                S5: if (up_down)
                        estado_actual <= S1;
                    else 
                        estado_actual <= S4;
                default: estado_actual <= S1;
        endcase
end

assign seq = estado_actual;  
    
endmodule