module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q ); 
    integer r, c;
    integer nr, nc;
    integer count;
    logic [255:0] next_q;
    always_comb begin
        for(r=0;r < 16; r=r+1) begin
            for(c=0; c<16; c=c+1) begin
                count=0;
                for(nr=-1; nr<=1; nr=nr+1) begin
                    for(nc=-1; nc<=1; nc=nc+1) begin
                        if(!(nr==0&&nc==0)) begin
                            count=count+q[((r+nr+16)%16)*16+((c+nc+16)%16)];
                        end
                    end
                end
                case(count)
                    2:next_q[r*16+c] = q[r*16+c];
                    3:next_q[r*16+c] = 1'b1;
                    default:next_q[r*16+c] = 1'b0;
                endcase
            end
        end
    end
    always_ff@(posedge clk) begin
        if(load)
            q<=data;
        else
            q<=next_q;
    end
endmodule
