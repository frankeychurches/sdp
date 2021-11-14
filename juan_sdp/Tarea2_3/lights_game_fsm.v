
// --------------------------------------------------------------------
// Universitat Politècnica de València
// Departamento de Ingeniería Electrónica
// --------------------------------------------------------------------
// Sistemas Digitales Programables MUISE
// Curso 2021 - 2022
// --------------------------------------------------------------------
// Nombre del archivo: lights_game_fsm.v
//
// Descripción: Este código de verilog implementa del juego de luces del
// coche fantástico con velocidad de paso de un led a otro variable. 
// Las entradas y salidas de este programa son:
// 1. clk -> Reloj activo por flanco de subida  (Entrada)
// 2. reset -> Reset activo a nivel bajo (Entrada)
// 3. enable -> Habilitador de cuenta y funcionamiento (Entrada)
// 4. button1 -> KEY[1] de la placa activo a nivel bajo (Entrada)
// 5. button2 -> KEY[2] de la placa activo a nivel bajo (Entrada)
// 6. leds_red -> Vector de salida de los LEDs rojos que informan
//                de la cuenta (Salida)
// 7. leds_green -> Vector de salida de los LEDs verdes que hacen el 
//						  juego de luces (Salida)
//
// --------------------------------------------------------------------
// Versión: V1.0| Fecha Modificación: 11/11/2021
//
// Autor(es): Juan Platero Avello y Francisco José Llave Iglesias
// Ordenador de trabajo: Portátil
//
// --------------------------------------------------------------------

module lights_game_fsm (
    clk, reset, enable, button1, button2, modo, leds_red, leds_green
);
    

input clk, reset, modo, enable, button1, button2;
output [7:0] leds_green;
output [7:0] leds_red;

wire TC_sig, enable_mealy, up_down_mealy, TC_fsm;

wire [3:0] cuenta;

defparam counter2.fin_cuenta = 12500000;
//defparam counter2.fin_cuenta = 1; //Only simulation
defparam counter_up_down.fin_cuenta = 16;
defparam variable_counter.width_count = 4;

n_counter counter2
(
	.clk(clk) ,	// input  clk_sig
	.reset(reset) ,	// input  reset_sig
	.enable(enable) ,	// input  enable_sig
	.up_down(enable) ,	// input  up_down_sig
	.count() ,	// output [N-1:0] count_sig
	.TC(TC_sig) 	// output  TC_sig
);

n_counter counter_up_down
(
	.clk(clk) ,	// input  clk_sig
	.reset(reset) ,	// input  reset_sig
	.enable(enable_mealy) ,	// input  enable_sig
	.up_down(up_down_mealy) ,	// input  up_down_sig
	.count(cuenta) ,	// output [N-1:0] count_sig
	.TC() 	// output  TC_sig
);


mealy_button buttons (
	.clk(clk) ,
	.reset(reset) ,
	.button1(button1) ,
	.button2(button2) ,
	.enable(enable_mealy) ,
	.up_down(up_down_mealy)
);


counter_var variable_counter (
	.clk(clk) ,
	.reset(reset) ,
	.entrada(cuenta) ,
	.enable(TC_sig) ,
	.modo(modo) ,
	.cuenta(leds_red[7:4]) ,
	.TC(TC_fsm)
);

luces_fsm luces (
	.clk(clk) ,
	.reset(reset) ,
	.enable(TC_fsm) ,
	.leds(leds_green) 
);


assign leds_red[3:0] = cuenta;


endmodule