// --------------------------------------------------------------------
// Universitat Politècnica de València
// Departamento de Ingeniería Electrónica
// --------------------------------------------------------------------
// Sistemas Digitales Programables MUISE
// Curso 2021 - 2022
// --------------------------------------------------------------------
// Nombre del archivo: caracteres_lcd.v
//
// Descripción: Este código de verilog implementa la muestra de caracteres 
// por pantalla, declarando el barrido inicial de la pantalla (lcd_sync),
// seguido de la ROM para mostrar el pixel del caracter o el fondo (char_rom),
// así como la selección del color del fondo (amarillo) y del pixel (negro). 
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