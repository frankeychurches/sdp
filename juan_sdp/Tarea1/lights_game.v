// --------------------------------------------------------------------
// Universitat Politècnica de València
// Departamento de Ingeniería Electrónica
// --------------------------------------------------------------------
// Sistemas Digitales Programables MUISE
// Curso 2021 - 2022
// --------------------------------------------------------------------
// Nombre del archivo: lights_game.v
//
// Descripción: Este código de verilog implementa un juego de luces
// del coche fantástico. Las entradas y salidas de este programa son:
// 1. clk -> Reloj activo por flanco de subida  (Entrada)
// 2. reset -> Reset activo a nivel bajo (Entrada)
// 3. enable -> Habilitador de cuenta y funcionamiento (Entrada)
// 4. leds -> Vector de 8 leds (salida)

//
// --------------------------------------------------------------------
// Versión: V1.0| Fecha Modificación: 21/10/2021
//
// Autor(es): Juan Platero Avello y Francisco José Llave Iglesias
// Ordenador de trabajo: Portátil
//
// --------------------------------------------------------------------


module lights_game(clk, reset, enable, leds);

`include "MathFun.vh"

input clk, reset, enable;
output [7:0] leds;

reg [7:0] leds_aux;
wire TC, shift_out;
wire [6:0] PR;

//n_counter #(.fin_cuenta(4)) counter_leds 
n_counter #(.fin_cuenta(12500000)) counter_leds 
(
	.clk(clk), 
	.reset(reset), 
	.enable(enable), 
	.up_down(1), 
	.count(), 
	.TC(TC)
);

n_shift_reg #(.N(7)) reg_7 
(
	.clk(clk),
	.rst(reset), 
	.enable(TC), 
	.SR_in(~shift_out), 
	.PR(PR), 
	.SR_out(shift_out)
);

// Lógica de salida de los leds en función de los estados 
always @(posedge clk)

	if (!reset)
		leds_aux = 0;
	else
		case (PR)
			7'b0000000: leds_aux = 1 << 7;
			7'b1000000: leds_aux = 1 << 6;
			7'b1100000: leds_aux = 1 << 5;
			7'b1110000: leds_aux = 1 << 4;
			7'b1111000: leds_aux = 1 << 3;
			7'b1111100: leds_aux = 1 << 2;
			7'b1111110: leds_aux = 1 << 1;
			7'b1111111: leds_aux = 1 << 0;
			7'b0111111: leds_aux = 1 << 1;
			7'b0011111: leds_aux = 1 << 2;
			7'b0001111: leds_aux = 1 << 3;
			7'b0000111: leds_aux = 1 << 4;
			7'b0000011: leds_aux = 1 << 5;
			7'b0000001: leds_aux = 1 << 6;
			default: leds_aux = 0;
		endcase

// Asignaciones de los leds
assign leds = leds_aux;

endmodule

