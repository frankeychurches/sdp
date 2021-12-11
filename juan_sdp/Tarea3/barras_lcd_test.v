// --------------------------------------------------------------------
// Universitat Politècnica de València
// Departamento de Ingeniería Electrónica
// --------------------------------------------------------------------
// Sistemas Digitales Programables MUISE
// Curso 2021 - 2022
// --------------------------------------------------------------------
// Nombre del archivo: barras_lcd_test.v
//
// Descripción: Este código de verilog implemente un testbench para el 
// programa barras_lcd.c el cuál genera 8 barras de colores en el display LCD.
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

`timescale 1 ns/ 100 ps

module barras_lcd_test();

localparam T = 20;

reg CLK, RST;
wire NCLK, GREST, HD, VD, DEN;

wire [7:0] R, G, B;


barras_lcd barras_lcd_inst
(
	.CLK(CLK) ,	// input  CLK_sig
	.RST(RST) ,	// input  RST_sig
	.NCLK(NCLK) ,	// output  NCLK_sig
	.GREST(GREST) ,	// output  GREST_sig
	.HD(HD) ,	// output  HD_sig
	.VD(VD) ,	// output  VD_sig
	.DEN(DEN) ,	// output  DEN_sig
	.R(R) ,	// output [7:0] R_sig
	.G(G) ,	// output [7:0] G_sig
	.B(B) 	// output [7:0] B_sig
);


integer fd;
event cierraFichero;


initial begin
    CLK = 0;
    RST = 0;
    repeat(5) @ (negedge CLK);
    RST = 1;
	repeat(5) @ (negedge CLK);
	$display("SIMULANDO!");
	//ALL_ROWS();
	
	// Flanco de subida de VD fin de la pantalla
	@(posedge VD)
	$display("Fin de la simulacion\n");
	-> cierraFichero;
	#10;
	$stop;
end

initial begin 
	fd = $fopen("vga.txt", "w");
	@(cierraFichero);
	disable guardaFichero;
	$display("Cierro fichero");
	$fclose(fd);
end

initial forever begin: guardaFichero
	@(posedge CLK)
	$fwrite(fd, "%0t ps: %b %b %b %b %b %b\n", $time, HD, VD, DEN, R, G, B);
end



// Definicion del reloj
always
begin
   #(T/2) CLK = ~CLK; 
end 


endmodule