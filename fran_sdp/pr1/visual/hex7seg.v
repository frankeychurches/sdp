module hex7seg (
    input hex[3:0] hex;
    output reg[6:0] segment;

    always @(*)
    begin
        case (hex)
            4'b0000 : segment = 7'b0000001 //0
            4'b0001 : segment = 7'b1001111 //1   
            4'b0010 : segment = 7'b0010010 //2
            4'b0011 : segment = 7'b0000110 //3 
            4'b0100 : segment = 7'b1001100 //4 
            4'b0101 : segment = 7'b0100100 //5
            4'b0110 : segment = 7'b0100000 //6
            4'b0111 : segment = 7'b0001110 //7
            4'b1000 : segment = 7'b0000000 //8
            4'b1001 : segment = 7'b0001100 //9
            4'b1010 : segment = 7'b0001000 //a
            4'b1011 : segment = 7'b1100000 //b
            4'b1100 : segment = 7'b1110010 //c
            4'b1101 : segment = 7'b1000010 //d
            4'b1110 : segment = 7'b0110000 //E
            4'b1111 : segment = 7'b0111000 //F
        default : segment = 7'b1111110 //-
    end
    end module 