
// --------------------------------------------------------------------
// Universitat Politècnica de València
// Departamento de Ingeniería Electrónica
// --------------------------------------------------------------------
// Sistemas Digitales Programables MUISE
// Curso 2021 - 2022
// --------------------------------------------------------------------
// Nombre del archivo: n_counter.v
//
// Descripción: Este código de verilog implementa un contador bidireccional 
// parametrizable de hasta fin_cuenta - 1 con N bits. 
//
// Las entradas y salidas de este programa son:
// 1. CLK -> Reloj activo por flanco de subida  (Entrada)
// 2. RST_n -> Reset síncrono activo a nivel bajo (Entrada)
// 3. ADC_DCLK -> Habilitador de cuenta y funcionamiento (Entrada)
// 4. SCEN -> Dirección de la cuenta. 1 - arriba, 2 - abajo (Entrada)
// 5. ADC_PENIRQ_n -> Valor actual de la cuenta (Salida)
// 6. ADC_DIN ->  Bit de fin de cuenta (salida)
// 6. ADC_DOUT ->  Bit de fin de cuenta (salida)
// 6. X_COORD, Y_COORD ->  Bit de fin de cuenta (salida)
//
// --------------------------------------------------------------------
// Versión: V2.0| Fecha Modificación: 11/12/2021
//
// Autor(es): Juan Platero Avello y Francisco José Llave Iglesias
// Ordenador de trabajo: Portátil
//
// --------------------------------------------------------------------

module ADC_CONTROL(
					iCLK,
					iRST_n,
					oADC_DIN,
					oADC_DCLK,
					oSCEN,
					iADC_DOUT,
					iADC_BUSY,
					iADC_PENIRQ_n,
					oX_COORD,
					oY_COORD
					);

parameter SYSCLK_FRQ	= 50000000;
parameter ADC_DCLK_FRQ	= 70000; //1000000
parameter ADC_DCLK_CNT	= SYSCLK_FRQ/(ADC_DCLK_FRQ*2);

// Me da la sensación de que hay un BUG en el testbecnh porque ADC_BUSY salta demasiado pronto!

input					iCLK;
input					iRST_n;
input					iADC_DOUT;
input					iADC_PENIRQ_n;
input					iADC_BUSY;
output				oADC_DIN;
output				oADC_DCLK;
output				oSCEN;
output	[11:0]	oX_COORD;
output	[11:0]	oY_COORD;


wire dclk, half_dclk, trans_en, fin_80, wait_en, wait_irq;
wire [6:0] count_80; // La habiamos declarado como un bit y tiene 7!!!!

n_counter n_counter_inst
(
	.clk(iCLK) ,	// input  CLK
	.reset(iRST_n) ,	// input  RST_n
	.enable(dclk) ,	// input  enable_sig
	.up_down(1) ,	// input  up_down_sig
	.count(count_80) ,	// output [N-1:0] count_sig
	.TC(fin_80) 	// output  TC_sig
);

defparam n_counter_inst.fin_cuenta = 80;


n_counter n_counter_wait
(
	.clk(iCLK) ,	// input  CLK
	.reset(iRST_n) ,	// input  RST_n
	.enable(wait_en) ,	// input  enable_sig
	.up_down(1) ,	// input  up_down_sig
	.count() ,	// output [N-1:0] count_sig
	.TC(wait_irq) 	// output  TC_sig
);

defparam n_counter_wait.fin_cuenta = 25000000;

adc_fsm adc_fsm_inst
(
	.CLK(iCLK) ,	// input  CLK_sig
	.RST_n(iRST_n) ,	// input  RST_n_sig
	.Enable1(dclk) ,	// input  Enable1_sig
	.Enable2(fin_80) ,	// input  Enable2_sig
	.wait_irq(wait_irq) ,	// input  wait_irq_sig
	.ADC_CS(oSCEN) ,	// output  ADC_CS_sig
	.ADC_PENIRQ_n(iADC_PENIRQ_n) ,	// input  ADC_PENIRQ_n_sig
	.wait_en(wait_en) ,	// output  wait_en_sig
	.Ena_trans(trans_en) ,	// output  Ena_trans_sig
	.Fin_trans() 	// output  Fin_trans_sig
);





adc_dclk_cnt adc_dclk_cnt_inst
(
	.CLK(iCLK) ,	// input  CLK
	.RST_n(iRST_n) ,	// input  RST_n
	.Enable(trans_en) ,	// input  Enable_sig
	.TC_2(half_dclk) ,	// output  TC_2_sig
	.TC(dclk) 	// output  TC_sig
);

defparam adc_dclk_cnt_inst.fin_cuenta = ADC_DCLK_CNT;

assign oADC_DCLK=count_80[0];

adc_din_gen adc_din_gen_inst
(
	.CLK(iCLK) ,	// input  CLK
	.RST_n(iRST_n) ,	// input  RST_n
	.Enable(trans_en) ,	// input  Enable_sig
	.Cuenta(count_80) ,	// input [6:0] Cuenta_sig
	.ADC_DIN(oADC_DIN) 	// output [7:0] ADC_DIN_sig
);


adc_dout adc_dout_inst
(
	.CLK(iCLK) ,	// input  CLK
	.RST_n(iRST_n) ,	// input  RST_n
	.Enable1(trans_en) ,	// input  Enable1_sig
	.Enable2(half_dclk) ,	// input  Enable2_sig
	.Cuenta(count_80) ,	// input [6:0] Cuenta_sig
	.ADC_DOUT(iADC_DOUT) ,	// input [11:0] ADC_DOUT_sig
	.X_COORD(oX_COORD) ,	// output [11:0] X_COORD_sig
	.Y_COORD(oY_COORD) 	// output [11:0] Y_COORD_sig
);



endmodule
