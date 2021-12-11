// --------------------------------------------------------------------
// Universitat Politècnica de València
// Departamento de Ingeniería Electrónica
// --------------------------------------------------------------------
// Sistemas Digitales Programables MUISE
// Curso 2021 - 2022
// --------------------------------------------------------------------
// Nombre del archivo: lcd_sync.v
//
// Descripción: Este código de verilog implementa las señales de datos y 
// sincronismo de la pantalla, mediante dos contadores (uno horizontal
// y otro vertical) encargados de marcar el fin de línea (horz) y el 
// cambio de línea (vert). 
//
// Las entradas y salidas de este programa son:
// 1. CLK -> Señal de reloj (50 MHz)  (Entrada)
// 2. RST_N -> Reset síncrono activo a nivel bajo (Entrada)
// 3. NCLK -> Reloj de la pantalla a 25 MHz (Salida)
// 4. GREST -> Reset  síncrono activo a nivel bajo (Salida)
// 5. HD -> Fin de fila (Salida)
// 6. VD ->  Fin de la pantalla (salida)
// 7. DEN ->  Enable de activación cuando se llega a la zona de visualización (Salida)
// 8. fila ->  Vector de filas (salida)
// 9. columna ->  Vector de columnas (salida)
//
// --------------------------------------------------------------------
// Versión: V2.0| Fecha Modificación: 11/12/2021
//
// Autor(es): Juan Platero Avello y Francisco José Llave Iglesias
// Ordenador de trabajo: Portátil
//
// --------------------------------------------------------------------

module lcd_sync (
    CLK, RST_N, NCLK, GREST, HD, VD, DEN, fila, columna
);

input CLK, RST_N;
output NCLK, GREST, HD, VD, DEN;
output [9:0] fila;
output [10:0] columna; 



wire TC_hcount, TC_vcount;


defparam hcount.fin_cuenta = 1056;
defparam vcount.fin_cuenta = 525;


pll_ltm	pll_ltm_inst (
	.inclk0 ( CLK ),
	.c0 ( NCLK )
	);



n_counter hcount (
    .clk ( NCLK ),
    .reset ( RST_N ),
    .enable (1'b1),
    .up_down (1'b1),
    .count ( columna ),
    .TC ( TC_hcount )
);


n_counter vcount (
    .clk ( NCLK ),
    .reset ( RST_N ),
    .enable ( TC_hcount ),
    .up_down (1'b1),
    .count ( fila ),
    .TC ( TC_vcount )
);


assign DEN = ((columna >= 216 && columna <= 1015) && (fila >= 35 && fila <= 514)) ? 1:0;
assign GREST = RST_N;
assign VD = ~TC_vcount;
assign HD = ~TC_hcount;




endmodule