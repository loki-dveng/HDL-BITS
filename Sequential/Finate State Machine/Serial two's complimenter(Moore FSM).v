module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    parameter S_WAIT_FIRST_1 = 2'd0,
              S_FIRST_1 = 2'd1,
              S_INVERT_0 = 2'd2,
              S_INVERT_1 = 2'd3;
    reg [1:0] state,next_state;
    always@(*) begin
        case(state)
            S_WAIT_FIRST_1:next_state = x?S_FIRST_1:S_WAIT_FIRST_1;
            S_FIRST_1:next_state = x?S_INVERT_1:S_INVERT_0;
            S_INVERT_0:next_state = x?S_INVERT_1:S_INVERT_0;
            S_INVERT_1:next_state = x?S_INVERT_1:S_INVERT_0;
            default:next_state = S_WAIT_FIRST_1;
        endcase
    end
    always@(posedge clk or posedge areset) begin
        if(areset)
            state <= S_WAIT_FIRST_1;
        else
            state <= next_state;
    end
    assign z = (state==S_FIRST_1)|(state==S_INVERT_0);
endmodule
