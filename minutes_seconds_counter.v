module BCD_counter #(parameter MOD = 10)(
    input wire[3:0] data,
    input wire loadn, clrn, clk, en,
    output wire[3:0] out,
    output wire tc, zero
);
    integer count;
    initial begin
        count <= 0;
    end

    always @(posedge clk) begin
        // update count
        if (en) begin
            if (count == 0) begin
                count <= MOD-1;
                tc = 1'b1;
            end else begin
                tc = 1'b0;
                count = count - 1;
            end
        end else begin
            if (loadn) begin
                count <= data;
            end
            tc <= 1'b0;
        end

        //update zero
        if (count == 0) begin
            zero <= 1'b1;
        end else begin
            zero <= 1'b0;
        end

        // update out
        out = count;
    end

endmodule

module minutes_seconds_counter(
    input wire[3:0] data,
    input wire loadn, clrn, clock, enable,
    output wire[3:0] sec_ones, sec_tens, mins,
    output wire zero
);
    // sec_ones
    wire[3:0] ones_wire;
    wire tc1, zero1;
    BCD_counter #(10) sec_ones_counter(
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
    wire[3:0] tens_wire;
    wire tc2, zero2;
    BCD_counter #(6) sec_tens_counter(
        .data(ones_wire),
        .loadn(loadn),
        .clrn(clrn),
        .clk(clock),
        .en(tc1),
        .out(tens_wire),
        .tc(tc2),
        .zero(zero2)
    );
    assign sec_tens = tens_wire;

    // mins
    wire[3:0] mins_wire;
    wire zero3;
    BCD_counter #(10) mins_counter(
        .data(tens_wire),
        .loadn(loadn),
        .clrn(clrn),
        .clk(clock),
        .en(tc2),
        .out(mins_wire),
        .tc(tc3),
        .zero(zero3)
    );
    assign mins = mins_wire;

    assign zero = zero1 & zero2 & zero3;

endmodule