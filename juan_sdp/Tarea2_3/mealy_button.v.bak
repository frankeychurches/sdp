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
                next_state = S2; 
                enable = 1;
                up_down = 0;
                end
            else
                if (!button2) begin
                    next_state = S2;
                    enable = 1;
                    up_down = 1;
                end
                else
                    begin
                    next_state = S1;
                    enable = 0;
                    up_down = 0;
                    end
        S2:
            if(!button1 || !button2)
				begin
                next_state = S2;
                enable = 0;
                up_down = 0;
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