
module ADC_CONTROL_HEX(
					iCLK,
					iRST_n,
					oADC_DIN,
					oADC_DCLK,
					oSCEN,
					iADC_DOUT,
					iADC_BUSY,
					iADC_PENIRQ_n,
					SEG0,
					SEG1,
					SEG2,
					SEG3,
					SEG4,
					SEG5,
					);

input					iCLK;
input					iRST_n;
input					iADC_DOUT;
input					iADC_PENIRQ_n;
input					iADC_BUSY;
output				oADC_DIN;
output				oADC_DCLK;
output				oSCEN;
output [6:0] SEG0, SEG1, SEG2, SEG3, SEG4, SEG5;
wire	[11:0]	oX_COORD;
wire	[11:0]	oY_COORD;



// Asignaciones de pines invertidas. Hex0[0] = segment[6]

ADC_CONTROL ADC_CONTROL_inst
(
	.iCLK(iCLK) ,	// input  iCLK
	.iRST_n(iRST_n) ,	// input  iRST_n
	.oADC_DIN(oADC_DIN) ,	// output  oADC_DIN
	.oADC_DCLK(oADC_DCLK) ,	// output  oADC_DCLK
	.oSCEN(oSCEN) ,	// output  oSCEN
	.iADC_DOUT(iADC_DOUT) ,	// input  iADC_DOUT
	.iADC_BUSY(iADC_BUSY) ,	// input  iADC_BUSY
	.iADC_PENIRQ_n(iADC_PENIRQ_n) ,	// input  iADC_PENIRQ_n
	.oX_COORD(oX_COORD) ,	// output [11:0] oX_COORD
	.oY_COORD(oY_COORD) 	// output [11:0] oY_COORD
);

defparam ADC_CONTROL_inst.SYSCLK_FRQ = 50000000;
defparam ADC_CONTROL_inst.ADC_DCLK_FRQ = 70000;


hex7seg hex7seg0
(
	.hex(oX_COORD[3:0]) ,	// input [3:0] hex
	.segment(SEG0) 	// output [6:0] segment
);


hex7seg hex7seg1
(
	.hex(oX_COORD[7:4]) ,	// input [3:0] hex
	.segment(SEG1) 	// output [6:0] segment
);


hex7seg hex7seg2
(
	.hex(oX_COORD[11:8]) ,	// input [3:0] hex
	.segment(SEG2) 	// output [6:0] segment
);



hex7seg hex7seg3
(
	.hex(oY_COORD[3:0]) ,	// input [3:0] hex
	.segment(SEG3) 	// output [6:0] segment
);


hex7seg hex7seg4
(
	.hex(oY_COORD[7:4]) ,	// input [3:0] hex
	.segment(SEG4) 	// output [6:0] segment
);


hex7seg hex7seg5
(
	.hex(oY_COORD[11:8]) ,	// input [3:0] hex
	.segment(SEG5) 	// output [6:0] segment
);

    
endmodule