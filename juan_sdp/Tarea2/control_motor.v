// Top-level entity

// Reset asíncrono activo a nivel bajo

module control_motor (
    input CLK, RESET, UP_DOWN, HALF_FULL, ENABLE, 
    output A, B, C, D, INH1, INH2
);

parameter [3:0] S1 = 3'b0000, S2 = 3'b0001, S3 = 3'b0010, S4 = 3'b0011, S5 = 3'b0100, S6 = 3'b0101, S7 = 3'b0110, S8 = 3'b0111, S9 = 3'b1000; //S9 es el reset

reg [3:0] Estado_Siguiente, Estado_Actual;


// Lógica del estado siguiente
always @(Estado_Actual, ENABLE, UP_DOWN, HALF_FULL) begin
    case (Estado_Actual)
        S1: if (ENABLE)
                if (HALF_FULL)
                    if (UP_DOWN)
                        Estado_Siguiente = S2;
                    else
                        Estado_Siguiente = S8;
                else 
                    if (UP_DOWN)
                        Estado_Siguiente = S3;
                    else
                        Estado_Siguiente = S7;  
            else 
                Estado_Siguiente = S1; 


        S2: if (ENABLE)
                if (HALF_FULL)
                    if (UP_DOWN)
                        Estado_Siguiente = S4;
                    else
                        Estado_Siguiente = S8;
                else 
                    if (UP_DOWN)
                        Estado_Siguiente = S3;
                    else
                        Estado_Siguiente = S1;  
            else 
                Estado_Siguiente = S2;  


        S3: if (ENABLE)
                if (HALF_FULL)
                    if (UP_DOWN)
                        Estado_Siguiente = S4;
                    else
                        Estado_Siguiente = S2;
                else 
                    if (UP_DOWN)
                        Estado_Siguiente = S5;
                    else
                        Estado_Siguiente = S1;  
            else 
                Estado_Siguiente = S3;  


        S4: if (ENABLE)
                if (HALF_FULL)
                    if (UP_DOWN)
                        Estado_Siguiente = S6;
                    else
                        Estado_Siguiente = S2;
                else 
                    if (UP_DOWN)
                        Estado_Siguiente = S5;
                    else
                        Estado_Siguiente = S3;  
            else 
                Estado_Siguiente = S4;  


        S5: if (ENABLE)
                if (HALF_FULL)
                    if (UP_DOWN)
                        Estado_Siguiente = S6;
                    else
                        Estado_Siguiente = S4;
                else 
                    if (UP_DOWN)
                        Estado_Siguiente = S7;
                    else
                        Estado_Siguiente = S3;  
            else 
                Estado_Siguiente = S5;  


        S6: if (ENABLE)
                if (HALF_FULL)
                    if (UP_DOWN)
                        Estado_Siguiente = S8;
                    else
                        Estado_Siguiente = S4;
                else 
                    if (UP_DOWN)
                        Estado_Siguiente = S7;
                    else
                        Estado_Siguiente = S5;  
            else 
                Estado_Siguiente = S6;  


        S7: if (ENABLE)
                if (HALF_FULL)
                    if (UP_DOWN)
                        Estado_Siguiente = S8;
                    else
                        Estado_Siguiente = S6;
                else 
                    if (UP_DOWN)
                        Estado_Siguiente = S1;
                    else
                        Estado_Siguiente = S5;  
            else 
                Estado_Siguiente = S7;  


        S8: if (ENABLE)
                if (HALF_FULL)
                    if (UP_DOWN)
                        Estado_Siguiente = S2;
                    else
                        Estado_Siguiente = S6;
                else 
                    if (UP_DOWN)
                        Estado_Siguiente = S1;
                    else
                        Estado_Siguiente = S7;  
            else 
                Estado_Siguiente = S8; 
        S9:  
            Estado_Siguiente = S1;
        default: Estado_Siguiente = S1;
    endcase  
end


// Registro de estado actual con reset asíncrono
always @(posedge CLK or negedge RESET) begin
    if (!RESET)
        Estado_Actual <= S9;
    else
        Estado_Actual <= Estado_Siguiente;
end


// Lógica de salida en función del estado actual

assign A = (Estado_Actual == S3 || Estado_Actual == S4 || Estado_Actual == S5) ? 1:0;
assign B = (Estado_Actual == S1 || Estado_Actual == S7 || Estado_Actual == S8) ? 1:0;
assign C = (Estado_Actual == S5 || Estado_Actual == S6 || Estado_Actual == S7) ? 1:0;
assign D = (Estado_Actual == S1 || Estado_Actual == S2 || Estado_Actual == S3) ? 1:0;
assign INH1 = (Estado_Actual == S2 || Estado_Actual == S6) ? 0:1;
assign INH2 = (Estado_Actual == S4 || Estado_Actual == S8) ? 0:1;

    
endmodule