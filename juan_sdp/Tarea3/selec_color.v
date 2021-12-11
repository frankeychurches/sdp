// --------------------------------------------------------------------
// Universitat Politècnica de València
// Departamento de Ingeniería Electrónica
// --------------------------------------------------------------------
// Sistemas Digitales Programables MUISE
// Curso 2021 - 2022
// --------------------------------------------------------------------
// Nombre del archivo: selec_color.v
//
// Descripción: Este código de verilog implementa un multiplexor que 
// escoge el color negro (1'b1) si es un pixel del carácter, o el color
// amarillo (1'b0) si es el color del fondo. 
// Las entradas y salidas de este programa son:
// 1. selector -> Bit de selección de color del carácter y del fondo,
//                salida del multiplexor de la ROM. (Entrada)
// 2. R,G,B -> Codificación de colores RGB. Tamaño 8 bits (Salida)
//
// --------------------------------------------------------------------
// Versión: V2.0| Fecha Modificación: 11/12/2021
//
// Autor(es): Juan Platero Avello y Francisco José Llave Iglesias
// Ordenador de trabajo: Portátil
//
// --------------------------------------------------------------------

module selec_color (selector, R, G, B);

input selector;
output reg [7:0] R, G, B;

always @(selector) begin
    case (selector)
        1'b1: begin
            R = 8'b00000000;
            G = 8'b00000000;
            B = 8'b00000000;
        end
        1'b0: begin
            R = 8'b11111111;
            G = 8'b11111111;
            B = 8'b00000000;          
        end 
        default: begin
            R = 8'b11111111;
            G = 8'b00000000;
            B = 8'b00000000;          
        end 
    endcase
end

    
endmodule