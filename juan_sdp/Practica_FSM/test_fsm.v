`timescale 1 ns/100 ps //define la precision de 100 ps

module tb_fsm_gen ();

localparam T = 20;

//Entradas de tipo REG
reg CLK, RST, UP_DOWN, ENABLE;
// Salidas de tipo WIRE
wire [4:0] SEQ;

Practica_FSM DUV (
    .clk(CLK),
    .rst(RST),
    .enable(ENABLE),
    .up_down(UP_DOWN),
    .seq(SEQ)
);



defparam Practica_FSM_inst.S0 = 'b0000;
defparam Practica_FSM_inst.S1 = 'b0010;
defparam Practica_FSM_inst.S2 = 'b0011;
defparam Practica_FSM_inst.S3 = 'b0101;
defparam Practica_FSM_inst.S4 = 'b0111;
defparam Practica_FSM_inst.S5 = 'b1010;

initial begin
    CLK = 0;
    RST = 0;
    ENABLE = 0;
    #(5*T)
    RST = 1;
    ENABLE = 1;
    UP_DOWN = 1;
    repeat (6) @(posedge CLK);
	 UP_DOWN = 0;
	 repeat (6) @(posedge CLK);
	 $display("Fin de simulacion");
	 $stop;
end


always
begin
   #(T/2) CLK = ~CLK; 
end 


endmodule