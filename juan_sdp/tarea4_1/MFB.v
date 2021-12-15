////////////////////////////////////////////////////////////////////////
// FICHERO:		MFB.v
// 
// Autor:		Vicente Herrero Bosch
// Fecha:		12/12/2017
// Descripcion: TAREA 4 SDP. 
//              Testbench. Modelo Funcional de Bus. 
// Comentarios: En este modulo se situan la generacion de reloj y 
//		el interfaz para reuso con otro tipo de buses (p.e.)
////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module MFB(		CLK, 
				RST, 
				X_COORD_CONTROL,
				X_COORD_MODELO,
				Y_COORD_CONTROL,
				Y_COORD_MODELO,
				START_CONV_n,
				ADC_DCLK
				);

parameter periodo = 50;			//Periodo de reloj

parameter signal_test = 8;

output reg CLK;
output reg RST;
output [11:0] X_COORD_MODELO;
output [11:0] Y_COORD_MODELO;
output reg START_CONV_n;
input [11:0] X_COORD_CONTROL;
input [11:0] Y_COORD_CONTROL;
input ADC_DCLK;

reg [11:0] X_COORD_MODELO_aux;
reg [11:0] Y_COORD_MODELO_aux;


assign X_COORD_MODELO = X_COORD_MODELO_aux;
assign Y_COORD_MODELO = Y_COORD_MODELO_aux;



task gen_conversion;
	input [11:0] DATO_X;
	input [11:0] DATO_Y;
		
	begin
		@(negedge CLK);
		X_COORD_MODELO_aux <= DATO_X;
		Y_COORD_MODELO_aux <= DATO_Y;
		START_CONV_n <= 1'b0;
		@(negedge CLK);
		START_CONV_n <= 1'b1;
	end
	
endtask



task comprueba;

	begin

	repeat(40) @(negedge ADC_DCLK);
	repeat (2) @(negedge CLK);
	// Condicion de validacion de la salida
	
	if ( (X_COORD_CONTROL!==X_COORD_MODELO_aux)|| (Y_COORD_CONTROL!==Y_COORD_MODELO_aux))
			begin
			$display ("Error de transmision");
			$display($time);
			$stop;
			end

	
	end	
endtask	


task reset;			
	//Generador de reset

	begin
	
	disable gen_conversion;
	disable comprueba;
	
	START_CONV_n <= 1'b1;
	
	RST <= 1'b1;
	wait (CLK !== 1'bx);
	@(negedge CLK);
	RST <= 1'b0;
	repeat(4) @(negedge CLK);
	RST <= 1'b1;
	
	if ((X_COORD_CONTROL ==! 12'h0)||(Y_COORD_CONTROL ==! 12'h0)) 
			begin
			$display("Error en RESET");
			$display($time);
			$stop;
			end
	//Asercion sobre el funcionamiento del RESET
	
	end
	
endtask


always			
	begin
	#(periodo/2);
	CLK <= 0;
	#(periodo/2);
	CLK <= 1;
	end
// Generador de reloj



endmodule
