

// Autor: Ricardo José Colom Palero
// Fecha: 10 de diciembre de 2018

`timescale 1ns/1ps

module tb_count ();

localparam T = 20;

reg               CLK, RST_n;
reg               ENABLE, UP_DOWN;
wire    [ 4:0]    COUNT;
wire              TC;

// Instanciación del DUT (Device Under Test)
n_counter #(.fin_cuenta(20)) i1 (   .clk(CLK),
                                .reset(RST_n),
                                .enable(ENABLE),
                                .up_down(UP_DOWN),
                                .count(COUNT),
                                .TC(TC));

initial
    begin
        RST_n = 1'b0;
        CLK = 1'b0;

        ENABLE = 1'b0;
        UP_DOWN = 1'b0;
        $display("SIMULANDO!!!");
        #(T*2)

        RST_n = 1'b1;

        #(T*2)

        ENABLE = 1'b1;
        UP_DOWN = 1'b1;
        #(T*24)


        $display("Fin Simulacion!!!");
        $stop;

    end
    
always
    begin
        #(T/2) CLK <= ~CLK;
    end

endmodule
