module mealy_button (
    clk, reset, button1, button2, enable, up_down
);

input clk, reset, button1, button2;
output enable, up_down;

reg [1:0] state, next_state;

parameter [1:0] S1 = 2'b00, S2 = 2'b01, S3 = 2'b10;


// Maquina de estados Mealy (2 bloques)

always @(posedge clk or negedge reset) 
    if (!reset)
        state <= S1;
    else
        state <= next_state;

always @(state or button1 or button2) 
    
    case (state)
        S1, S2, S3: if(!button1)
                begin
                next_state = S2; 
                enable = 1;
                up_down = 0;
                end
            else
                if (!button2) begin
                    next_state = S3;
                    enable = 1;
                    up_down = 1;
                end
                else
                    next_state = S1;
                    enable = 0;
                    up_down = 0;

        default: begin
            next_state = S1;
            enable = 0;
            up_down = 0;
        end
    endcase

endmodule