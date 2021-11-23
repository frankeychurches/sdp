module imagen_lcd (
	CLK, RST, NCLK, GREST, HD, VD, DEN, R, G, B
);
	
input CLK, RST;
output NCLK, GREST, HD, VD, DEN;
output [7:0] R, G, B;
wire [9:0] fila;
wire [10:0] columna;
wire DEN_sig;
reg [19:0] dir;
wire [23:0] q_sig;

lcd_sync lcd_sync_inst
(
	.CLK(CLK) ,	// input  CLK
	.RST_N(RST) ,	// input  RST_N
	.NCLK(NCLK) ,	// output  NCLK
	.GREST(GREST) ,	// output  GREST
	.HD(HD) ,	// output  HD
	.VD(VD) ,	// output  VD
	.DEN(DEN) ,	// output  DEN
	.fila(fila) ,	// output [9:0] fila
	.columna(columna) 	// output [10:0] columna
);


// Direccionamiento
always @(fila, columna) begin
	if(DEN_sig)
		dir = {columna, fila};
end


ROM_image	ROM_image_inst (
	.address ( dir ),
	.clock ( NCLK ),
	.q ( q_sig )
	);



endmodule