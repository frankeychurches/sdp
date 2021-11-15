module lcd_sync (
    CLK, RST_N, NCLK, GREST, HD, VD, DEN, fila, columna
);

input CLK, RST_N;
output NCLK, GREST, HD, VD, DEN;
output [10:0] fila;
output [9:0] columna; 

//Falta definir si son de tipo wire o reg


wire NCLK, TC_hcount, TC_vcount;


defparam hcount.fin_cuenta = 1056;
defparam vcount.fin_cuenta = 525;


PLL_VGA	PLL_VGA_inst (
	.inclk0 ( CLK ),
	.c0 ( NCLK )
	);


n_counter hcount (
    .clk ( NCLK ),
    .reset ( RST_N ),
    .enable (1),
    .up_down (1),
    .TC ( TC_hcount ),
    .count ( columna )
);


n_counter vcount (
    .clk ( NCLK ),
    .reset ( RST_N ),
    .enable ( TC_hcount ),
    .up_down (1),
    .TC ( TC_vcount ),
    .count ( fila )
);


assign DEN = (columna >= 216 && columna <= 1015 && fila >= 35 && fila <= 514 ) ? 1:0;
assign GREST = RST_N;
assign VD = ~TC_vcount;
assign HD = ~TC_hcount;




endmodule