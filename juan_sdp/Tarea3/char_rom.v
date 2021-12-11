// --------------------------------------------------------------------
// Universitat Politècnica de València
// Departamento de Ingeniería Electrónica
// --------------------------------------------------------------------
// Sistemas Digitales Programables MUISE
// Curso 2021 - 2022
// --------------------------------------------------------------------
// Nombre del archivo: char_rom.v
//
// Descripción: Este código de verilog implementa un multiplexor que 
// dependiendo de los 3 bits LSB del vector columna, va cogiendo
// los valores de visualización de pixel (1) o pixel apagado (0).
// 
// Las entradas y salidas de este programa son:
// 1. NCLK -> Señal de reloj (50 MHz)  (Entrada)
// 2. fila -> Valor del array de filas (Entrada)
// 3. columna -> Habilitador de cuenta y funcionamiento (Entrada)
// 4. caracter -> Dirección de la cuenta. 1 - arriba, 2 - abajo (Entrada)
// 5. pixel_on_off -> Valor actual de la cuenta (Salida)
//
// --------------------------------------------------------------------
// Versión: V2.0| Fecha Modificación: 11/12/2021
//
// Autor(es): Juan Platero Avello y Francisco José Llave Iglesias
// Ordenador de trabajo: Portátil
//
// --------------------------------------------------------------------

module char_rom (NCLK, fila, columna, caracter, pixel_on_off);

input NCLK;
input [5:0] caracter;
input [9:0] fila;
input [10:0] columna;
output reg pixel_on_off;

wire [7:0] datos;
wire [8:0] dir;

assign dir = {caracter[5:0], fila[3:1]}; // Si quisieramos meter de 32x32 bits seria de 4:2 en filas y columnas

always @(columna[3:1], datos) begin
    case (columna[3:1])
        3'b000 : pixel_on_off = datos[7];
        3'b001 : pixel_on_off = datos[6];
        3'b010 : pixel_on_off = datos[5];
        3'b011 : pixel_on_off = datos[4];
        3'b100 : pixel_on_off = datos[3];
        3'b101 : pixel_on_off = datos[2];
        3'b110 : pixel_on_off = datos[1];
        3'b111 : pixel_on_off = datos[0];
        default: pixel_on_off = 0;
    endcase
    
end
    

ROM_char	ROM_char_inst (
	.address ( dir ),
	.clock ( NCLK ),
	.q ( datos )
);


endmodule