// ADC DCLK Generator

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

module adc_dclk_gen (
    CLK, RST_n, Enable, ADC_DCLK
);

input CLK, RST_n, Enable;

output reg ADC_DCLK;

always @(posedge CLK) 
begin
	if (!RST_n) 
		ADC_DCLK <= 0;
	else
        ADC_DCLK <= Enable;
end


endmodule
