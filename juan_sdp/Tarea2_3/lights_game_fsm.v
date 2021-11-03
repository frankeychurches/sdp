module lights_game_fsm (
    clk, reset, enable, button1, button2, modo, leds_red, leds_green
);
    

input clk, reset, up_down, enable, button1, button2;
output [7:0] leds;

wire TC_sig, enable_mealy, up_down_mealy;

wire [3:0] cuenta;

defparam counter2.fin_cuenta = 12500000;
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


counter_var variable_counter(
	.clk(clk) ,
	.reset(reset) ,
	.entrada() ,
	.enable() ,
	.modo() ,
	.cuenta() ,
	.TC()
);



endmodule