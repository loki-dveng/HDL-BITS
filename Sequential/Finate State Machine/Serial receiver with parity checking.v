module top_module(
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output done
);
    parameter IDLE = 3'd0,
              DATA = 3'd1,
              PARITY = 3'd2,
              STOP = 3'd3,
              WAIT_STOP = 3'd4,
              DONE = 3'd5;
              
    reg[2:0] state,next_state;
    reg[3:0] bit_cnt;
    wire odd;
    wire parity_in = ((state==DATA)||(state==PARITY))?in:1'b0;
    wire parity_reset = (state==IDLE)||(state==WAIT_STOP)||(state==DONE)||reset;
    parity u_parity (.clk(clk),.reset(parity_reset),.in(parity_in),.odd(odd));
    always@(*) begin
        case(state)
            IDLE:      
                next_state = (in== 1'b0)?DATA:IDLE;
            DATA:      
                next_state = (bit_cnt == 4'd7)?PARITY:DATA;
            PARITY:    
                next_state = STOP;
            STOP:begin
                if(in == 1'b1) begin
                    if(odd == 1'b1)
                        next_state = DONE;
                    else
                        next_state = IDLE;
                end
                else begin
                    next_state = WAIT_STOP;
                end
            end
            WAIT_STOP: 
                next_state = (in==1'b1)?IDLE:WAIT_STOP;
            DONE:      
                next_state = (in== 1'b0)?DATA:IDLE;
            default:   
                next_state = IDLE;
        endcase
    end
    always@(posedge clk) begin
        if(reset) begin
            state<=IDLE;
            out_byte<=8'b0;
            bit_cnt<=4'b0;
        end 
        else begin
            state<=next_state;
            if(state == DATA) begin
                out_byte<={in, out_byte[7:1]};
                bit_cnt <= bit_cnt + 4'd1;
            end 
            else begin
                bit_cnt <= 4'b0;
            end
        end
    end
    assign done = (state==DONE);
endmodule
