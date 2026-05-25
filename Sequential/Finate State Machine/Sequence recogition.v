module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);
    parameter S_NONE = 4'd0,
              S_ONE = 4'd1,
              S_TWO = 4'd2,
              S_THREE = 4'd3,
              S_FOUR = 4'd4,
              S_FIVE = 4'd5,
              S_SIX = 4'd6,
              S_DISC = 4'd7,
              S_FLAG = 4'd8,
              S_ERR = 4'd9;
    reg[3:0] state,next_state;
    always@(*) begin
        case(state)
            S_NONE:next_state = in?S_ONE:S_NONE;
            S_ONE:next_state = in?S_TWO:S_NONE;
            S_TWO:next_state = in?S_THREE:S_NONE;
            S_THREE:next_state = in?S_FOUR:S_NONE;
            S_FOUR:next_state = in?S_FIVE:S_NONE;
            S_FIVE:next_state = in?S_SIX:S_DISC;
            S_SIX:next_state = in?S_ERR:S_FLAG;
            S_DISC:next_state = in?S_ONE:S_NONE;
            S_FLAG:next_state = in?S_ONE:S_NONE;
            S_ERR:next_state = in?S_ERR:S_NONE;
            default:next_state = S_NONE;
        endcase
    end
    always@(posedge clk) begin
        if(reset) begin
            state <= S_NONE;
        end 
        else begin
            state <= next_state;
        end
    end
    assign disc = (state==S_DISC);
    assign flag = (state == S_FLAG);
    assign err  = (state == S_ERR);
endmodule
