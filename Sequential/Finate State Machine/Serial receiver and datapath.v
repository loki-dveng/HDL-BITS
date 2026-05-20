module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //
    localparam IDLE = 4'd0,
               D0 = 4'd1,
               D1 = 4'd2,
               D2 = 4'd3,
               D3 = 4'd4,
               D4 = 4'd5,
               D5 = 4'd6,
               D6 = 4'd7,
               D7 = 4'd8,
               STOP = 4'd9,
               DONE = 4'd10,
               WAIT = 4'd11;
    reg [3:0] state,next_state;
    always@(*) begin
        case(state)
            IDLE:next_state = in?IDLE:D0;
            D0:next_state = D1;
            D1:next_state = D2;
            D2:next_state = D3;
            D3:next_state = D4;
            D4:next_state = D5;
            D5:next_state = D6;
            D6:next_state = D7;
            D7:next_state = STOP;
            STOP:next_state = in?DONE:WAIT;
            DONE:next_state = in?IDLE:D0;
            WAIT:next_state = in?IDLE:WAIT;
            default:next_state = IDLE;
        endcase
    end
    always@(posedge clk) begin
        if(reset)
            state <= IDLE;
        else
            state <= next_state;
    end
    always@(posedge clk) begin
        case(state)
            D0,D1,D2,D3,D4,D5,D6,D7:begin
                out_byte <= {in, out_byte[7:1]};
            end
            default:begin
                out_byte <= out_byte;
            end
        endcase
    end
    assign done = (state==DONE);
endmodule
