// ADC DCLK Counter

// --------------------------------------------------------------------
// Universitat Politècnica de València
// Departamento de Ingeniería Electrónica
// --------------------------------------------------------------------
// Sistemas Digitales Programables MUISE
// Curso 2021 - 2022
// --------------------------------------------------------------------
// Nombre del archivo: adc_dclk_cnt.v
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

module adc_dclk_cnt (
    CLK, RST_n, Enable, TC_2, TC
);

`include "MathFun.vh"
parameter fin_cuenta = 16; //Contador de 0 a 15
parameter N = CLogB2(fin_cuenta - 1);

input CLK, RST_n, Enable;
reg [N-1:0] count;
output TC_2, TC;

always @(posedge CLK) 
begin
	if (!RST_n) 
		count <= 0;
	else
        if (Enable)
            if(count == fin_cuenta - 1)
                count <= 0;
            else
                count <= count + 1;
        else
            count <= count;  
end

assign TC = (count == fin_cuenta - 1)? 1 : 0; 
assign TC_2 = (count == (fin_cuenta - 1) >> 1 || (count == fin_cuenta - 1) )? 1: 0;


endmodule
