// ADC DIN Generator

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
// 1. clk -> Reloj activo por flanco de subida  (Entrada)
// 2. reset -> Reset síncrono activo a nivel bajo (Entrada)
// 3. enable -> Habilitador de cuenta y funcionamiento (Entrada)
// 4. up_down -> Dirección de la cuenta. 1 - arriba, 2 - abajo (Entrada)
// 5. count -> Valor actual de la cuenta (Salida)
// 6. TC ->  Bit de fin de cuenta (salida)
//
// --------------------------------------------------------------------
// Versión: V2.0| Fecha Modificación: 11/12/2021
//
// Autor(es): Juan Platero Avello y Francisco José Llave Iglesias
// Ordenador de trabajo: Portátil
//
// --------------------------------------------------------------------

module adc_din_gen (
    CLK, RST_n, Enable, Cuenta, ADC_DIN
);

input CLK, RST_n, Enable;
input [6:0] Cuenta; //Cuenta de módulo 80
output reg ADC_DIN;
                    //     S----PD0
localparam [7:0] DIN_x = 8'b10010010;
localparam [7:0] DIN_y = 8'b11010010;

//RESOLUCION MEDIANTE CASE
always @(posedge CLK or negedge RST_n) begin
    if (!RST_n) 
        begin
        ADC_DIN = 0; 
        end
    else
        if(Enable)
            case (Cuenta)
				
                0,1 : ADC_DIN = DIN_x[7];
                2,3 : ADC_DIN = DIN_x[6];
                4,5 : ADC_DIN = DIN_x[5];
                6,7 : ADC_DIN = DIN_x[4];
                8,9 : ADC_DIN = DIN_x[3];
                10,11 : ADC_DIN = DIN_x[2];
                12,13 : ADC_DIN = DIN_x[1];
                14,15 : ADC_DIN = DIN_x[0];

                32,33 : ADC_DIN = DIN_y[7];
                34,35 : ADC_DIN = DIN_y[6];
                36,37 : ADC_DIN = DIN_y[5];
                38,39 : ADC_DIN = DIN_y[4];
                40,41 : ADC_DIN = DIN_y[3];
                42,43 : ADC_DIN = DIN_y[2];
                44,45 : ADC_DIN = DIN_y[1];
                46,47 : ADC_DIN = DIN_y[0];

                default: ADC_DIN = 0;
            endcase
        else
            ADC_DIN = 0;
end

endmodule

