
// --------------------------------------------------------------------
// Universitat Politècnica de València
// Departamento de Ingeniería Electrónica
// --------------------------------------------------------------------
// Sistemas Digitales Programables MUISE
// Curso 2021 - 2022
// --------------------------------------------------------------------
// Nombre del archivo: mealy_button.v
//
// Descripción: Este código de verilog implementa una máquina mealy 
// de 2 estados, relacionados con los dos botones a usar que hacen que se 
// incremente (KEY[2]) o decremente (KEY[1]) la cuenta. 
// Las entradas y salidas de este programa son:
// 1. clk -> Reloj activo por flanco de subida  (Entrada)
// 2. reset -> Reset asíncrono activo a nivel bajo (Entrada)
// 3. button1 -> KEY[1] de la placa activo a nivel bajo (Entrada)
// 4. button2 -> KEY[2] de la placa activo a nivel bajo (Entrada)
// 5. enable -> Habilitador de cuenta y funcionamiento (Entrada)
// 6. up_down -> Dirección de la cuenta. 1 - arriba, 2 - abajo (Entrada)

//
// --------------------------------------------------------------------
// Versión: V1.0| Fecha Modificación: 11/11/2021
//
// Autor(es): Juan Platero Avello y Francisco José Llave Iglesias
// Ordenador de trabajo: Portátil
//
// --------------------------------------------------------------------

module mealy_button (
    clk, reset, button1, button2, enable, up_down
);

input clk, reset, button1, button2;
output reg enable, up_down;

reg state, next_state;

parameter S1 = 1'b0, S2 = 1'b1; //Solo dos estados


// Maquina de estados Mealy (2 bloques)

always @(posedge clk or negedge reset) 
    if (!reset)
        state <= S1;
    else
        state <= next_state;

always @(state or button1 or button2) 
    
    case (state)
        S1: if(!button1)
                begin
                next_state = S2; enable = 1; up_down = 0;
					 // decrece uno.              
                end
            else
                if (!button2) 
						begin
                    next_state = S2; enable = 1; up_down = 1;
						  // asciende uno.
						end
                else
                  begin
                    next_state = S1; enable = 0; up_down = 0;
						  // no se pulsa ninguno, no hay cambio.
                  end
        S2:
            if(!button1 || !button2)
					begin
						next_state = S2; enable = 0; up_down = 0; 
						// sistema seguridad: si mantienes pulsado,
						// enable se pone a 0, para así no seguir 
						// ascendiendo o descendiendo.
                end
				else
                begin
						next_state = S1;
						enable = 0;
						up_down = 0;
					 end

        default: begin
            next_state = S1;
            enable = 0;
            up_down = 0;
        end
    endcase

endmodule