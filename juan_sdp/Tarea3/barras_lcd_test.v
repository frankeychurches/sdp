`timescale 1 ns/ 100 ps

module barras_lcd_test();

localparam T = 20;

reg CLK, RST;
wire NCLK, GREST, HD, VD, DEN;

wire [7:0] R, G, B;


barras_lcd barras_lcd_inst
(
	.CLK(CLK) ,	// input  CLK_sig
	.RST(RST) ,	// input  RST_sig
	.NCLK(NCLK) ,	// output  NCLK_sig
	.GREST(GREST) ,	// output  GREST_sig
	.HD(HD) ,	// output  HD_sig
	.VD(VD) ,	// output  VD_sig
	.DEN(DEN) ,	// output  DEN_sig
	.R(R) ,	// output [7:0] R_sig
	.G(G) ,	// output [7:0] G_sig
	.B(B) 	// output [7:0] B_sig
);


integer fd;
event cierraFichero;


initial begin
    CLK = 0;
    RST = 0;
    repeat(5) @ (negedge CLK);
    RST = 1;
	repeat(5) @ (negedge CLK);
	$display("SIMULANDO!");
	//ALL_ROWS();
	
	@(posedge VD)
	$display("Fin de la simulacion\n");
	-> cierraFichero;
	#10;
	$stop;
end

initial begin 
	fd = $fopen("vga.txt", "w");
	@(cierraFichero);
	disable guardaFichero;
	$display("Cierro fichero");
	$fclose(fd);
end

initial forever begin: guardaFichero
	@(posedge CLK)
	$fwrite(fd, "%0t ps: %b %b %b %b %b %b\n", $time, HD, VD, DEN, R, G, B);
end



// Definicion del reloj
always
begin
   #(T/2) CLK = ~CLK; 
end 



task ONE_ROW();
begin 
	repeat(2) @(negedge CLK);
	#(T*2030);
end
endtask


task ALL_ROWS();
begin 
	repeat(2) @(negedge CLK);
	#(T*2030*525);
end
endtask

endmodule