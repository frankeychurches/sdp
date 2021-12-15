// ADC ADC_DOUT Coordinates

// --------------------------------------------------------------------
// Universitat Politècnica de València
// Departamento de Ingeniería Electrónica
// --------------------------------------------------------------------
// Sistemas Digitales Programables MUISE
// Curso 2021 - 2022
// --------------------------------------------------------------------
// Nombre del archivo: adc_cout_coord.v
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

module adc_dout (
    CLK, RST_n, Enable1, Enable2, Cuenta, 
    ADC_DOUT, X_COORD, Y_COORD
);

input CLK, RST_n, Enable1, Enable2;
input [6:0] Cuenta;
input ADC_DOUT;
output reg [11:0] X_COORD, Y_COORD;


always @(posedge CLK or negedge RST_n) begin
    if (!RST_n) 
        begin
            X_COORD = 0;  Y_COORD = 0;
        end
    else 
        if(Enable1)
            if(Enable2)
                case (Cuenta)
                    18,19 : X_COORD[11] = ADC_DOUT;
                    20,21 : X_COORD[10] = ADC_DOUT;
                    22,23 : X_COORD[9] = ADC_DOUT;
                    24,25 : X_COORD[8] = ADC_DOUT;
                    26,27 : X_COORD[7] = ADC_DOUT;
                    28,29 : X_COORD[6] = ADC_DOUT;
                    30,31 : X_COORD[5] = ADC_DOUT;
                    32,33 : X_COORD[4] = ADC_DOUT;
                    34,35 : X_COORD[3] = ADC_DOUT;
                    36,37 : X_COORD[2] = ADC_DOUT;
                    38,39 : X_COORD[1] = ADC_DOUT;
                    40,41 : X_COORD[0] = ADC_DOUT;

                    50,51 : Y_COORD[11] = ADC_DOUT;
                    52,53 : Y_COORD[10] = ADC_DOUT;
                    54,55 : Y_COORD[9] = ADC_DOUT;
                    56,57 : Y_COORD[8] = ADC_DOUT;
                    58,59 : Y_COORD[7] = ADC_DOUT;
                    60,61 : Y_COORD[6] = ADC_DOUT;
                    62,63 : Y_COORD[5] = ADC_DOUT;
                    64,65 : Y_COORD[4] = ADC_DOUT;
                    66,67 : Y_COORD[3] = ADC_DOUT;
                    68,69 : Y_COORD[2] = ADC_DOUT;
                    70,71 : Y_COORD[1] = ADC_DOUT;
                    72,73 : Y_COORD[0] = ADC_DOUT;

                    default: begin
                        X_COORD = X_COORD;
                        Y_COORD = Y_COORD;
                    end
                endcase
            else
                begin
                    X_COORD = X_COORD;
                    Y_COORD = Y_COORD;
                end
        else 
                begin
                    X_COORD = X_COORD;
                    Y_COORD = Y_COORD;
                end

end

endmodule