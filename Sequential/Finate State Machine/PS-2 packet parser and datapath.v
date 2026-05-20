module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //
    parameter BYTE1 = 2'd0,
              BYTE2 = 2'd1,
              BYTE3 = 2'd2,
              DONE = 2'd3;
    reg [1:0] state,next_state;
    reg [23:0] shift_reg;
    always@(*) begin
        case(state)
            BYTE1:next_state = in[3]?BYTE2:BYTE1;
            BYTE2:next_state = BYTE3;
            BYTE3:next_state = DONE;
            DONE:next_state = in[3]?BYTE2:BYTE1;
            default:next_state = BYTE1;
        endcase
    end
    always@(posedge clk) begin
        if(reset) begin
            state<=BYTE1;
            shift_reg<=24'b0;
        end 
        else begin
            state<=next_state;
           shift_reg<={shift_reg[15:0],in};
        end
    end
    assign done=(state==DONE);
    assign out_bytes=shift_reg;
endmodule
    
