// --------------------------------------------------------------------
// Universitat Politècnica de València
// Departamento de Ingeniería Electrónica
// --------------------------------------------------------------------
// Sistemas Digitales Programables MUISE
// Curso 2021 - 2022
// --------------------------------------------------------------------
// Nombre del archivo: shift_reg.v
//
// Descripción: Este código de verilog implementa un contador registro de 
// desplazamiento a la derecha parametrizable de N bits. Las entradas y 
// salidas de este programa son:
// 1. clk -> Reloj activo por flanco de subida  (Entrada)
// 2. reset -> Reset activo a nivel bajo (Entrada)
// 3. enable -> Habilitador de cuenta y funcionamiento (Entrada)
// 4. SR_in -> Nuevo bit a insertar en el registro (Entrada)
// 5. PR -> Valor actual del registro (Salida)
// 6. SR_out ->  Bit de salida del registro (salida)

//
// --------------------------------------------------------------------
// Versión: V1.0| Fecha Modificación: 21/10/2021
//
// Autor(es): Juan Platero Avello y Francisco José Llave Iglesias
// Ordenador de trabajo: Portátil
//
// -------------------------------------------------------------------

module n_shift_reg (clk, rst, enable, SR_in, PR, SR_out);

parameter N = 7;
input clk, rst, enable, SR_in;

output [N-1:0] PR;
output SR_out;
reg [N-1:0] PR_aux;

always @(posedge clk) 
begin
    if (!rst)
        PR_aux <= 0;
    else
        if (enable)
            PR_aux[N-1:0] <= {SR_in, PR_aux[N-1:1]}; //Desplazamiento hacia la derecha
        else
            PR_aux <= PR_aux;
end

// Asignaciones de salida
assign SR_out = PR[0];
assign PR = PR_aux;


endmodule



