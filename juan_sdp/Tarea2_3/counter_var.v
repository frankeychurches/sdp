
// --------------------------------------------------------------------
// Universitat Politècnica de València
// Departamento de Ingeniería Electrónica
// --------------------------------------------------------------------
// Sistemas Digitales Programables MUISE
// Curso 2021 - 2022
// --------------------------------------------------------------------
// Nombre del archivo: counter_var.v
//
// Descripción: Este código de verilog implementa un contador de tamaño 
// parametrizable con un módulo variable de entre 2 y 16 bits (1 a 15).
// Si el modo es 1, el fin de la cuenta es la entrada que tengamos. 
// Si no, sería la variable modulo_good, la cual incluye el valor 15
// (en este caso, el máximo de los bits puestos), y cuenta todos los
// bits del parámetro.
// Cuando la cuenta haya acabado y tengamos el enable activo, el TC
// guarda un 1 para indicar a otros elementos que ha finalizado.
// Las entradas y salidas de este programa son:
// 1. clk -> Reloj activo por flanco de subida  (Entrada)
// 2. reset -> Reset asíncrono activo a nivel bajo (Entrada)
// 3. entrada -> Vector de bits con el número hasta el cual queremos contar
// 					(Entrada)
// 3. enable -> Habilitador de cuenta y funcionamiento (Entrada)
// 4. modo -> Hasta dónde cuenta. 1 - entrada, 2 - modulo_good (Entrada)
// 5. cuenta -> Valor actual de la cuenta (Salida)
// 6. TC ->  Bit de fin de cuenta (salida)
//
// --------------------------------------------------------------------
// Versión: V1.0| Fecha Modificación: 11/11/2021
//
// Autor(es): Juan Platero Avello y Francisco José Llave Iglesias
// Ordenador de trabajo: Portátil
//
// --------------------------------------------------------------------

module counter_var (
    clk, reset, entrada, enable, modo, cuenta, TC
);

parameter width_count = 4;
localparam [width_count - 1:0] modulo_good = 2 ** width_count - 1;

input clk, reset, enable, modo;
input [width_count - 1:0] entrada;

output reg [width_count - 1:0] cuenta;
output TC;

wire [width_count - 1:0] cuenta_fin;

assign cuenta_fin = (modo == 1) ? entrada : modulo_good;
assign TC = (cuenta == cuenta_fin && enable == 1) ? 1 : 0;

always @(posedge clk or negedge reset) 
    if(!reset)
        cuenta <= 0;
    else
        if(enable)
            if(cuenta == cuenta_fin)
                cuenta <= 0;
            else 
                cuenta <= cuenta + 1; 
endmodule