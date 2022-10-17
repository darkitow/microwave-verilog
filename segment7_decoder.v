module BCD_to_7segment(
    input wire[3:0] in,
    output wire[6:0] out
);
    assign out =
        (in == 'd0) ? 7'b1111110 :
        (in == 'd1) ? 7'b0110000 :
        (in == 'd2) ? 7'b1101101 :
        (in == 'd3) ? 7'b1111001 :
        (in == 'd4) ? 7'b0110011 :
        (in == 'd5) ? 7'b1011011 :
        (in == 'd6) ? 7'b1011111 :
        (in == 'd7) ? 7'b1110000 :
        (in == 'd8) ? 7'b1111111 :
        (in == 'd9) ? 7'b1111011 :
        7'bx;

endmodule

module segment7_decoder(
    input wire[3:0] sec_ones, sec_tens, min, 
    output wire[6:0] sec_ones_segs, sec_tens_segs, min_segs
);
    BCD_to_7segment ones(.in(sec_ones), .out(sec_ones_segs));
    BCD_to_7segment tens(.in(sec_tens), .out(sec_tens_segs));
    BCD_to_7segment mins(.in(min), .out(min_segs));

endmodule