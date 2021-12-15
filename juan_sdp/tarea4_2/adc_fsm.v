// ADC FSM 

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

module adc_fsm(
    CLK, RST_n, Enable1, Enable2, wait_irq, ADC_CS, 
    ADC_PENIRQ_n, wait_en, Ena_trans, Fin_trans
);

input CLK, RST_n, ADC_PENIRQ_n, Enable1, Enable2, wait_irq;
output reg ADC_CS, Ena_trans, Fin_trans, wait_en;

// Declare state register
reg		[2:0]state;

// Declare states
parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4;

// Output depends only on the state
always @ (state) begin
    case (state)
        S0:
            begin
                Ena_trans = 1'b0; 
                Fin_trans = 1'b0; 
                ADC_CS = 1'b0;
                wait_en = 1'b0;
            end
        S1:
            begin
                Ena_trans = 1'b0; 
                Fin_trans = 1'b0; 
                ADC_CS = 1'b0;
                wait_en = 1'b0;
            end
        S2:
            begin
                Ena_trans = 1'b1; 
                Fin_trans = 1'b0; 
                ADC_CS = 1'b1;
                wait_en = 1'b0;
            end
        S3:
            begin
                Ena_trans = 1'b0; 
                Fin_trans = 1'b1; 
                ADC_CS = 1'b0;
                wait_en = 1'b0;
            end
        S4:
            begin
                Ena_trans = 1'b0; 
                Fin_trans = 1'b0; 
                ADC_CS = 1'b0;
                wait_en = 1'b1;
            end
        default:
            begin
                Ena_trans = 1'b0; 
                Fin_trans = 1'b0; 
                ADC_CS = 1'b0;
                wait_en = 1'b0;
            end
    endcase
end

// Determine the next state
always @ (posedge CLK or negedge RST_n) begin
    if (!RST_n)
        state <= S0;
    else
        case (state)
            S0:
                state <= S1;
            S1:
                if (ADC_PENIRQ_n == 1'b0)
                    state <= S2;
                else
                    state <= S1;
            S2:
                if (Enable1 && Enable2)
                    state <= S3;
                else
                    state <= S2;
            S3:
                    state <= S4;
            S4:
                if (wait_irq)
                    state <= S0;
                else
                    state <= S4;
        default: state <= S0;
        
        endcase
end


endmodule


