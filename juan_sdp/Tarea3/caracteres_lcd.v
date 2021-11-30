module caracteres_lcd (
    CLK, RST, NCLK, GREST, HD, VD, DEN, R, G, B
);
    

input CLK, RST;
output NCLK, GREST, HD, VD, DEN;
output [7:0] R,G,B;

wire [9:0] fila;
wire [10:0] columna; 
wire color_selector;


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



char_rom char_rom_inst
(
	.NCLK(NCLK) ,	// input  NCLK
	.fila(fila) ,	// input [9:0] fila
	.columna(columna) ,	// input [10:0] columna
	.caracter(6'o01) ,	// input [5:0] caracter
	.pixel_on_off(color_selector) 	// output  pixel_on_off
);



selec_color selec_color_inst
(
	.selector(color_selector) ,	// input  selector
	.R(R) ,	// output [7:0] R
	.G(G) ,	// output [7:0] G
	.B(B) 	// output [7:0] B
);






endmodule