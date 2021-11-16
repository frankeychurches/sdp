module barras_lcd (
    CLK, RST, NCLK, GREST, HD, VD, DEN, R, G, B
);

input CLK, RST;
output NCLK, GREST, HD, VD, DEN;
output reg [7:0] R, G, B;

wire [10:0] COLUMNA;


localparam offset = 216;
localparam step = 100;


lcd_sync lcd_sync_inst
(
	.CLK(CLK) ,	// input  CLK_sig
	.RST_N(RST) ,	// input  RST_N_sig
	.NCLK(NCLK) ,	// output  NCLK_sig
	.GREST(GREST) ,	// output  GREST_sig
	.HD(HD) ,	// output  HD_sig
	.VD(VD) ,	// output  VD_sig
	.DEN(DEN) ,	// output  DEN_sig
	.fila() ,	// output [9:0] fila_sig
	.columna(COLUMNA) 	// output [10:0] columna_sig
);


always @(COLUMNA) begin
    if(COLUMNA >= offset && COLUMNA <= (offset + step))
        begin
            R = 8'b11111111;
            G = 8'b11111111;
            B = 8'b11111111;
        end
    else if(COLUMNA >= (offset + step) && COLUMNA <= (offset + 2*step))
        begin
            R = 8'b11111111;
            G = 8'b11111111;
            B = 0;
        end
    else if(COLUMNA >= (offset + 2*step) && COLUMNA <= (offset + 3*step))
        begin
            R = 0;
            G = 8'b11111111;
            B = 8'b11111111;
        end
    else if(COLUMNA >= (offset + 3*step) && COLUMNA <= (offset + 4*step))
        begin
            R = 0;
            G = 8'b11111111;
            B = 0;
        end
    else if(COLUMNA >= (offset + 4*step) && COLUMNA <= (offset + 5*step))
        begin
            R = 8'b11111111;
            G = 0;
            B = 8'b11111111;
        end
    else if(COLUMNA >= (offset + 5*step) && COLUMNA <= (offset + 6*step))
        begin
            R = 8'b11111111;
            G = 0;
            B = 0;
        end
    else if(COLUMNA >= (offset + 6*step) && COLUMNA <= (offset + 7*step))
        begin
            R = 0;
            G = 0;
            B = 8'b11111111;
        end
    else if(COLUMNA >= (offset + 7*step) && COLUMNA <= (offset + 8*step))
        begin
            R = 0;
            G = 0;
            B = 0;
        end
    else
        begin
            R = 0;
            G = 0;
            B = 0;
        end
end



    
endmodule