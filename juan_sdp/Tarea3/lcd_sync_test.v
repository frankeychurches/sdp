// --------------------------------------------------------------------
// Universitat Politècnica de València
// Departamento de Ingeniería Electrónica
// --------------------------------------------------------------------
// Sistemas Digitales Programables MUISE
// Curso 2021 - 2022
// --------------------------------------------------------------------
// Nombre del archivo: lcd_sync_test.v
//
// Descripción: Este código de verilog implementa un test para 
// comprobar el correcto barrido horizontal y el paso a la 
// siguiente línea del programa lcd_sync.v
//
// Las entradas y salidas del DUV son:
// 1. CLK -> Señal de reloj (50 MHz)  (Entrada)
// 2. RST -> Reset síncrono activo a nivel bajo (Entrada)
// 3. NCLK -> Reloj de la pantalla a 25 MHz (Salida)
// 4. GREST -> Reset  síncrono activo a nivel bajo (Salida)
// 5. HD -> Fin de fila (Salida)
// 6. VD ->  Fin de la pantalla (salida)
// 7. DEN ->  Enable de activación cuando se llega a la zona de visualización (Salida)
// 8. R, G, B ->  Codificación de colores RGB. Tamaño 8 bits (Salida)
//
// --------------------------------------------------------------------
// Versión: V2.0| Fecha Modificación: 11/12/2021
//
// Autor(es): Juan Platero Avello y Francisco José Llave Iglesias
// Ordenador de trabajo: Portátil
//
// --------------------------------------------------------------------

`timescale 1 ns/ 100 ps

module lcd_sync_test();

localparam T = 20;

reg CLK, RST;
wire NCLK, GREST, HD, VD, DEN;

wire [9:0] FILA;
wire [10:0] COLUMNA;

lcd_sync DUV
(
	.CLK(CLK) ,	// input  CLK_
	.RST_N(RST) ,	// input  RST_N_
	.NCLK(NCLK) ,	// output  NCLK_
	.GREST(GREST) ,	// output  GREST_
	.HD(HD) ,	// output  HD_
	.VD(VD) ,	// output  VD_
	.DEN(DEN) ,	// output  DEN_
	.fila(FILA) ,	// output [10:0] fila_
	.columna(COLUMNA) 	// output [9:0] columna_
);

// Definicion del reloj
always
begin
   #(T/2) CLK = ~CLK; 
end 


initial begin
    CLK = 0;
    RST = 0;
    repeat(5) @ (negedge CLK);
    RST = 1;
	repeat(5) @ (negedge CLK);
	$display("SIMULANDO!");
	@(posedge VD)
	$display("Fin de la simulacion\n");
	$stop;
end



endmodule