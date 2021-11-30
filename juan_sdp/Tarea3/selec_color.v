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