module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
    parameter A=3'd0,
              B=3'd1,
              C=3'd2,
              D=3'd3,
              E=3'd4,
              F=3'd5;

    reg [2:0] state,next_state;

    always @(posedge clk) begin
        if(reset)
            state <= F;
        else
            state <= next_state;
    end

    always @(*) begin

        case(state)

            A: begin
                if(s == 3'b111)
                    next_state = A;
                else if(s == 3'b011)
                    next_state = C;
                else
                    next_state = A;
            end

            B: begin
                if(s == 3'b111)
                    next_state = A;
                else if(s == 3'b011)
                    next_state = B;
                else if(s == 3'b001)
                    next_state = E;
                else
                    next_state = B;
            end

            C: begin
                if(s == 3'b111)
                    next_state = A;
                else if(s == 3'b011)
                    next_state = C;
                else if(s == 3'b001)
                    next_state = E;
                else
                    next_state = C;
            end

            D: begin
                if(s == 3'b011)
                    next_state = B;
                else if(s == 3'b001)
                    next_state = D;
                else if(s == 3'b000)
                    next_state = F;
                else
                    next_state = D;
            end

            E: begin
                if(s == 3'b011)
                    next_state = B;
                else if(s == 3'b001)
                    next_state = E;
                else if(s == 3'b000)
                    next_state = F;
                else
                    next_state = E;
            end

            F: begin
                if(s == 3'b000)
                    next_state = F;
                else if(s == 3'b001)
                    next_state = D;
                else
                    next_state = F;
            end

            default: next_state = F;

        endcase
    end

    always @(*) begin

        fr1 = 0;
        fr2 = 0;
        fr3 = 0;
        dfr = 0;

        case(state)

            A: begin
                fr1 = 0;
                fr2 = 0;
                fr3 = 0;
                dfr = 0;
            end

            B: begin
                fr1 = 1;
                fr2 = 0;
                fr3 = 0;
                dfr = 0;
            end

            C: begin
                fr1 = 1;
                fr2 = 0;
                fr3 = 0;
                dfr = 1;
            end

            D: begin
                fr1 = 1;
                fr2 = 1;
                fr3 = 0;
                dfr = 0;
            end

            E: begin
                fr1 = 1;
                fr2 = 1;
                fr3 = 0;
                dfr = 1;
            end

            F: begin
                fr1 = 1;
                fr2 = 1;
                fr3 = 1;
                dfr = 1;
            end

        endcase
    end
endmodule
