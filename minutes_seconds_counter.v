module BCD_counter #(parameter MOD)(
    input wire[3:0] data,
    input wire loadn, clrn, clk, en
    output wire[3:0] out,
    output wire tc, zero
);
    integer count;
    always @(posedge clrn) begin
        count <= 0;
    end

    always @(posedge clk) begin
        if (loadn) begin
            count <= data; 
        if (en) begin
            out <= 'b0
        else begin
            if (count == 0) begin
                count <= MOD;
            end else begin
                count <= count - 1;
            end
            
            out <= count;

            if (out == 0) begin
                zero = 1'b1;
            end else begin
                zero = 1'b0;
            end
        end
    end

endmodule

module minutes_seconds_counter(
    input wire[3:0] data,
    input wire loadn, clrn, clock, enable,
    output wire[3:0] sec_ones, sec_tens, mins,
    output wire zero
);
    // sec_ones
    wire ones_wire, tc1, zero1;
    BCD_counter #(MOD = 10) sec_ones_counter(
        .data(data),
        .loadn(loadn),
        .clrn(clrn),
        .clk(clock),
        .en(enable),
        .out(ones_wire),
        .tc(tc1),
        .zero(zero1)
    );
    assign sec_ones = ones_wire;

    // sec_tens
    wire tens_wire, tc2, zero2;
    BCD_counter #(MOD = 6) sec_tens_counter(
        .data(ones_wire),
        .loadn(loadn),
        .clrn(clrn),
        .clk(clock),
        .en(tc1),
        .out(),
        .tc(tc2),
        .zero(zero3)
    );
    assign sec_tens = tens_wire;

    // mins
    wire mins_wire, zero3;
    BCD_counter #(MOD = 10) mins_counter(
        .data(tens_wire),
        .loadn(loadn),
        .clrn(clrn),
        .clk(clock),
        .en(tc2),
        .out(mins_wire),
        .tc(tc3),
        .zero(zero3)
    );
    assign mins = mins_wire

    assign zero = zero1 & zero2 & zero3;

endmodule