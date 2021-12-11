// --------------------------------------------------------------------
// Universitat Politècnica de València
// Departamento de Ingeniería Electrónica
// --------------------------------------------------------------------
// Sistemas Digitales Programables MUISE
// Curso 2021 - 2022
// --------------------------------------------------------------------
// Nombre del archivo: imagen_lcd.v
//
// Descripción: Este código de verilog implementa la visualización de una 
// imagen cargada en una ROM y su correspondiente adecuación en cuanto
// a la resolución (de 800x480 a 400x240) y a la profundidad de color
// (de 16 a 24 bits). 
//
// Las entradas y salidas de este programa son:
// 1. CLK -> Señal de reloj (50 MHz)  (Entrada)
// 2. RST -> Reset síncrono activo a nivel bajo (Entrada)
// 3. NCLK -> Reloj de la pantalla a 25 MHz (Salida)
// 4. GREST -> Reset  síncrono activo a nivel bajo (Salida)
// 5. HD -> Fin de fila (Salida)
// 6. VD ->  Fin de la pantalla (salida)
// 7. DEN ->  Enable de activación cuando se llega a la zona de visualización (Salida)
// 8. R, G, B ->  Codificación de colores RGB. Tamaño 8 bits (salida)
//
// --------------------------------------------------------------------
// Versión: V2.0| Fecha Modificación: 11/12/2021
//
// Autor(es): Juan Platero Avello y Francisco José Llave Iglesias
// Ordenador de trabajo: Portátil
//
// --------------------------------------------------------------------

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