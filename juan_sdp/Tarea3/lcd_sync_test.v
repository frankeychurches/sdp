`timescale 1 ns/ 100 ps

module lcd_sync_test();

localparam T = 20;

reg CLK, RST;
wire NCLK, GREST, HD, VD, DEN;

wire [9:0] FILA;
wire [10:0] COLUMNA;

lcd_sync DUV
(
	.CLK(CLK) ,	// input  CLK_
	.RST_N(RST) ,	// input  RST_N_
	.NCLK(NCLK) ,	// output  NCLK_
	.GREST(GREST) ,	// output  GREST_
	.HD(HD) ,	// output  HD_
	.VD(VD) ,	// output  VD_
	.DEN(DEN) ,	// output  DEN_
	.fila(FILA) ,	// output [10:0] fila_
	.columna(COLUMNA) 	// output [9:0] columna_
);

// Definicion del reloj
always
begin
   #(T/2) CLK = ~CLK; 
end 


initial begin
    CLK = 0;
    RST = 0;
    repeat(5) @ (negedge CLK);
    RST = 1;
	repeat(5) @ (negedge CLK);
	$display("SIMULANDO!");
	ONE_ROW();
	$stop;

end


task ONE_ROW();
begin 
	repeat(2) @(negedge CLK);
	#(T*5000);
end
endtask

endmodule