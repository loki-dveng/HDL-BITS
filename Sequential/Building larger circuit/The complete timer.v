module top_module (
    input clk,
    input reset,
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack
);
    parameter S_IDLE = 4'd0,
              S_1 = 4'd1,
              S_11 = 4'd2,
              S_110 = 4'd3,
              B0 = 4'd4,
              B1 = 4'd5,
              B2 = 4'd6,
              B3 = 4'd7,
              COUNT = 4'd8,
              WAIT_ACK = 4'd9;
    reg[3:0] state,next_state;
    reg[9:0] cnt_1000;
    reg[3:0] delay_reg;
    always@(*) begin
        case(state)
            S_IDLE:next_state = data?S_1:S_IDLE;
            S_1:next_state = data?S_11:S_IDLE;
            S_11:next_state = data?S_11:S_110;
            S_110:next_state = data?B0:S_IDLE;
            B0:next_state = B1;
            B1:next_state = B2;
            B2:next_state = B3;
            B3:next_state = COUNT;
            COUNT:next_state = (delay_reg==4'd0&&cnt_1000==10'd999)?WAIT_ACK:COUNT;
            WAIT_ACK:next_state = ack?S_IDLE:WAIT_ACK;
            default:next_state = S_IDLE;
        endcase
    end
    always@(posedge clk) begin
        if(reset) begin
            state <= S_IDLE;
            cnt_1000 <= 10'd0;
            delay_reg <= 4'd0;
        end
        else begin
            state <= next_state;
            if(state==B0||state==B1||state == B2||state == B3) begin
                delay_reg<={delay_reg[2:0],data};
            end
            else if(state == COUNT) begin
                if(cnt_1000 == 10'd999) begin
                    cnt_1000 <= 10'd0;
                    if(delay_reg > 4'd0) begin
                        delay_reg <= delay_reg-4'd1;
                    end
                end 
                else begin
                    cnt_1000 <= cnt_1000+10'd1;
                end
            end
            else begin
                cnt_1000 <= 10'd0;
            end
        end
    end
    assign count = delay_reg;
    assign counting = (state == COUNT);
    assign done = (state == WAIT_ACK);
endmodule
