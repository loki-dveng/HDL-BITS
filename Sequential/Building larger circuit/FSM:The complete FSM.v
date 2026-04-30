module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );
    localparam S0=0,S1=1,S2=2,S3=3,S4=4,SHIFT=5,WAIT=6,DONE=7;
    reg [2:0] state, next_state;
    reg [1:0] count;
    always @(posedge clk) begin
        if (reset)
            state<=S0;
        else
            state<=next_state;
    end
    always @(*) begin
        case (state)
            S0: next_state=data?S1:S0;
            S1: next_state=data?S2:S0;
            S2: next_state=data?S2:S3;
            S3: next_state=data?S4:S0;
            S4: next_state=SHIFT;
            SHIFT:next_state=(count==2)?WAIT:SHIFT;
            WAIT:next_state=done_counting?DONE:WAIT;
            DONE:next_state=ack?S0:DONE;
            default: next_state=S0;
        endcase
    end
    always @(posedge clk) begin
        if (reset)
            count<=0;
        else if (state==SHIFT)
            count<=count+1;
        else
            count<=0;
    end
    assign shift_ena=(state==SHIFT||(state==S4 && next_state==SHIFT));
    assign counting=(state==WAIT);
    assign done=(state==DONE);
endmodule
