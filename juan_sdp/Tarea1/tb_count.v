// Curso 2021 - 2022
// --------------------------------------------------------------------
// Nombre del archivo: tb_count.v
//
// Descripción: Este es in fichero de test para comprobar el funcionamiento
// del contador de N bits implementado en el archivo n_counter.v:
// 1. CLK -> reloj del contador  (Entrada)
// 2. RST_n -> reset del contador  (Entrada)
// 3. ENABLE -> Habilitador del contador (Entrada)
// 4. UP_DOWN -> Bit de cuenta hacia arriba o abajo (Entrada)
// 5. COUNT -> 5 bits de cuenta del contador (Salida)
// 6. TC -> Terminal count. Indica cuando llega al final de la cuenta (Salida)

//
// --------------------------------------------------------------------
// Versión: V1.0| Fecha Modificación: 21/10/2021
//
// Autor(es): Juan Platero Avello y Francisco José Llave Iglesias
// Ordenador de trabajo: Portátil
//
// --------------------------------------------------------------

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
