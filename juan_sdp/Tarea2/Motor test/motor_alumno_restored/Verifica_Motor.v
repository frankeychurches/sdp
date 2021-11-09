module Verifica_Motor(
	Reloj,
	Reset,
	KEY2,
	KEY3,
	UP_DOWN,
	HALF_FULL,
	ENABLE,
	A,
	B,
	C,
	D,
	INH1,
	INH2,
	HEX0_a,
	HEX0_b,
	HEX0_c,
	HEX0_d,
	HEX0_e,
	HEX0_f,
	HEX0_g,
	HEX1_a,
	HEX1_b,
	HEX1_c,
	HEX1_d,
	HEX1_e,
	HEX1_f,
	HEX1_g,
	HEX2_a,
	HEX2_b,
	HEX2_c,
	HEX2_d,
	HEX2_e,
	HEX2_f,
	HEX2_g,
	HEX3_a,
	HEX3_b,
	HEX3_c,
	HEX3_d,
	HEX3_e,
	HEX3_f,
	HEX3_g,
	LEDR,
	LTM_R,
	LTM_G,
	LTM_B,
	LTM_NCLK,
	LTM_HD,
	LTM_VD,
	LTM_DEN,
	LTM_GRST,
	LTM_SDA,
	LTM_SCEN,
	ADC_PENIRQ_N,
	ADC_BUSY,
	ADC_DIN,
	ADC_DOUT,	
	ADC_LTM_SCLK
);


input wire	Reloj;
input wire	Reset;
input			KEY2;
input			KEY3;
input wire	UP_DOWN;
input wire	HALF_FULL;
input wire	ENABLE;
output wire	A;
output wire	B;
output wire	C;
output wire	D;
output wire	INH1;
output wire	INH2;
output wire	HEX0_a;
output wire	HEX0_b;
output wire	HEX0_c;
output wire	HEX0_d;
output wire	HEX0_e;
output wire	HEX0_f;
output wire	HEX0_g;
output wire	HEX1_a;
output wire	HEX1_b;
output wire	HEX1_c;
output wire	HEX1_d;
output wire	HEX1_e;
output wire	HEX1_f;
output wire	HEX1_g;
output wire	HEX2_a;
output wire	HEX2_b;
output wire	HEX2_c;
output wire	HEX2_d;
output wire	HEX2_e;
output wire	HEX2_f;
output wire	HEX2_g;
output wire	HEX3_a;
output wire	HEX3_b;
output wire	HEX3_c;
output wire	HEX3_d;
output wire	HEX3_e;
output wire	HEX3_f;
output wire	HEX3_g;
output wire	[15:0] LEDR;
output	[7:0] LTM_R;
output	[7:0] LTM_G;
output	[7:0] LTM_B;
output	LTM_NCLK;
output	LTM_HD;
output	LTM_VD;
output	LTM_DEN;
output	LTM_GRST;
inout		LTM_SDA;
output	LTM_SCEN;
input		ADC_PENIRQ_N;
input		ADC_BUSY;
output	ADC_DIN;
input		ADC_DOUT;
output	ADC_LTM_SCLK;
	
wire	mA;
wire	mB;
wire	mC;
wire	mD;
wire	mINH1;
wire	mINH2;
wire	mENABLE;


testbench	U1(
	.Reloj(Reloj),
	.Reset(Reset),
	.ENABLE(ENABLE),
	.A(mA),
	.B(mB),
	.C(mC),
	.D(mD),
	.INH1(mINH1),
	.INH2(mINH2),
	.HEX0_a(HEX0_a),
	.HEX0_b(HEX0_b),
	.HEX0_c(HEX0_c),
	.HEX0_d(HEX0_d),
	.HEX0_e(HEX0_e),
	.HEX0_f(HEX0_f),
	.HEX0_g(HEX0_g),
	.HEX1_a(HEX1_a),
	.HEX1_b(HEX1_b),
	.HEX1_c(HEX1_c),
	.HEX1_d(HEX1_d),
	.HEX1_e(HEX1_e),
	.HEX1_f(HEX1_f),
	.HEX1_g(HEX1_g),
	.HEX2_a(HEX2_a),
	.HEX2_b(HEX2_b),
	.HEX2_c(HEX2_c),
	.HEX2_d(HEX2_d),
	.HEX2_e(HEX2_e),
	.HEX2_f(HEX2_f),
	.HEX2_g(HEX2_g),	
	.HEX3_a(HEX3_a),
	.HEX3_b(HEX3_b),
	.HEX3_c(HEX3_c),
	.HEX3_d(HEX3_d),
	.HEX3_e(HEX3_e),
	.HEX3_f(HEX3_f),
	.HEX3_g(HEX3_g),	
	.AUTOENABLE(mENABLE),
	.SPEED_MAS(KEY3),
	.SPEED_MENOS(KEY2),
	.LEDR(LEDR),
	.LTM_R(LTM_R),
	.LTM_G(LTM_G),
	.LTM_B(LTM_B),
	.LTM_NCLK(LTM_NCLK),
	.LTM_HD(LTM_HD),
	.LTM_VD(LTM_VD),
	.LTM_DEN(LTM_DEN),
	.LTM_GRST(LTM_GRST),
	.LTM_SDA(LTM_SDA),
	.LTM_SCEN(LTM_SCEN),
	.ADC_PENIRQ_N(ADC_PENIRQ_N),
	.ADC_BUSY(ADC_BUSY),
	.ADC_DIN(ADC_DIN),
	.ADC_DOUT(ADC_DOUT),	
	.ADC_LTM_SCLK(ADC_LTM_SCLK)
	);


control_motor	U2(
	.CLK(Reloj),
	.RESET(Reset),
	.UP_DOWN(UP_DOWN),
	.HALF_FULL(HALF_FULL),
	.ENABLE(mENABLE),
	.A(mA),
	.B(mB),
	.C(mC),
	.D(mD),
	.INH1(mINH1),
	.INH2(mINH2));

assign	A = mA;
assign	B = mB;
assign	C = mC;
assign	D = mD;
assign	INH1 = mINH1;
assign	INH2 = mINH2;

endmodule
