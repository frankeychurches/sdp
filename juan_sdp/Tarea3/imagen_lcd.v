module imagen_lcd (
	CLK, RST, NCLK, GREST, HD, VD, DEN, R, G, B
);
	
input CLK, RST;
output NCLK, GREST, HD, VD, DEN;
output [7:0] R, G, B;
wire [9:0] fila;
wire [10:0] columna;
wire DEN_sig;
wire [16:0] dir;
wire [15:0] q_sig;

wire [7:0] filax2;
wire [8:0] columnax2;

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


// Direccionamiento X-Y

assign filax2={fila-35}>>1; 
assign columnax2={columna-215}>>1;

assign dir = {filax2,columnax2};

ROM_image	ROM_image_inst (
	.address ( dir ),
	.clock ( NCLK ),
	.q ( q_sig )
);


assign R= {q_sig [15:11], q_sig [15:13]};
assign G= {q_sig [10:5], q_sig [10:9]};
assign B= {q_sig [4:0], q_sig [4:2]};



endmodule