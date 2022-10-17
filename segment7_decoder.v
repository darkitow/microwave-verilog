module BCD_to_7segment(
    input wire[3:0] in,
    output wire[6:0] out
);
    assign out =
        (in == 'd0) ? 7'b1111110 : // 7e
        (in == 'd1) ? 7'b0110000 : // 30
        (in == 'd2) ? 7'b1101101 : // 6d
        (in == 'd3) ? 7'b1111001 : // 79
        (in == 'd4) ? 7'b0110011 : // 33
        (in == 'd5) ? 7'b1011011 : // 5b
        (in == 'd6) ? 7'b1011111 : // 5f
        (in == 'd7) ? 7'b1110000 : // 70
        (in == 'd8) ? 7'b1111111 : // 7f
        (in == 'd9) ? 7'b1111011 : // 7b
        7'bx;

endmodule

module segment7_decoder(
    input wire[3:0] sec_ones, sec_tens, min, 
    output wire[6:0] sec_ones_segs, sec_tens_segs, min_segs
);
    BCD_to_7segment ones(.in(sec_ones), .out(sec_ones_segs));

    wire[6:0] tens_temp;
    BCD_to_7segment tens(.in(sec_tens), .out(tens_temp));
    assign sec_tens_segs = (sec_tens == 0 & min == 0) ? 7'b0 : tens_temp;

    wire[6:0] min_temp;
    BCD_to_7segment mins(.in(min), .out(min_temp));
    assign min_segs = (min == 0) ? 7'b0 : min_temp;

endmodule