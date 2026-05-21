module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
    typedef enum logic[2:0] {A, B, C, D, E, F, G, H} state_t;
    state_t state, next_state;
    always_ff @(posedge clk) begin
        if(reset)
            state <= A;
        else
            state <= next_state;
    end
    always_comb begin
        case(state)
            A:next_state=s?B:A;
            B:next_state=w?D:C;
            H:next_state=w?D:C;
            C:next_state=w?F:E;
            D:next_state=w?G:F;
            E:next_state=B;
            F:next_state=w?H:B;
            G:next_state=w?B:H;
            default:next_state=A;
        endcase
    end
    assign z=(state==H);
endmodule
