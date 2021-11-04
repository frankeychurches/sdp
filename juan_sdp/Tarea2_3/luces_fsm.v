module luces_fsm (
    clk, reset, enable, leds
);


input clk, reset, enable;
output [7:0] leds;

reg [7:0] state;
reg state_up_down;

parameter [7:0] S1 = 1 << 7, S2 = 1 << 6, S3 = 1 << 5, S4 = 1 << 4, S5 = 1 << 3, S6 = 1 << 2, S7 = 1 << 1, S8 = 1 << 0, S9 = 0;

always @(posedge clk or negedge reset) 
    if (!reset)
        begin
        state <= S9;
        state_up_down = 0; 
        end
    else
        if(enable)
            case (state)
                S1: begin state <= S2; state_up_down = 1; end
                S2: if(state_up_down == 1)  
                            state <= S3;
                        else 
                            state <= S1;
                S3: if(state_up_down == 1)  
                            state <= S4;
                        else 
                            state <= S2;
                S4: if(state_up_down == 1)  
                            state <= S5;
                        else 
                            state <= S3;
                S5: if(state_up_down == 1)  
                            state <= S6;
                        else 
                            state <= S4;
                S6: if(state_up_down == 1)  
                            state <= S7;
                        else 
                            state <= S5;
                S7: if(state_up_down == 1)  
                            state <= S8;
                        else 
                            state <= S6;
                S8: begin state <= S7; state_up_down = 0; end
                S9: begin state <= S1; state_up_down = 0; end
                default: state <= S1;
            endcase

assign leds = state;


endmodule