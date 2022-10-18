module clock_divide_by_100(
    input wire clk,
    output reg clk_out
);  
  	integer count;
    initial begin
        count = 0;
      	clk_out = 1'b0;
    end

    always @(posedge clk) begin
        count <= count + 1;
        if (count == 4) begin
            count <= 0;
            clk_out <= ~clk_out;
        end
    end

endmodule

module timer_input_and_control(
    input wire[9:0] key,
    input wire clk, enablen,
    output wire[3:0] D,
    output wire pgt_1Hz, loadn
);
    // Priority encoder
    wire valid;
    assign D = enablen ? (
        key[9] ? 4'b1001 :
        key[8] ? 4'b1000 :
        key[7] ? 4'b0111 :
        key[6] ? 4'b0110 :
        key[5] ? 4'b0101 :
        key[4] ? 4'b0100 :
        key[3] ? 4'b0011 :
        key[2] ? 4'b0010 :
        key[1] ? 4'b0001 :
        key[0] ? 4'b0000 :
        4'bx) : D;
    assign valid = enablen ? ((key == 10'b0) ? 1'b0 : 1'b1) : valid;
    assign loadn = valid;

    // 100Hz to 1Hz
    wire clk1Hz;
    clock_divide_by_100 c(.clk(clk), .clk_out(clk1Hz));

    // Non Recycling counter? .clear(valid) .clk(clk)

    // MUX
    assign pgt_1Hz = enablen ? clk1Hz : 1'b0;

endmodule