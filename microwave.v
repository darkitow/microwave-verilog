`include "magnetron_control.v"
`include "timer_input_and_control.v"
`include "minutes_seconds_counter.v"
`include "segment7_decoder"


module microwave(
    input wire startn, stopn, clearn, door_closed, clock,
    input wire[9:0] keypad,
    output wire mag_on,
    output wire[6:0] sec_ones_segs, sec_tens_segs, min_segs
);

    // magnetron_control
    wire magnetron;
    magnetron_control control(
        .startn(startn),
        .stopn(stopn),
        .clearn(clearn),
        .door_closed(door_closed),
        .timer_done(zero)
        .magnetron(magnetron)
    );
    assign mag_on = magnetron;

    // encoder
    wire D, pgt_1Hz, loadn;
    timer_input_and_control encoder(
        .key(keypad),
        .clk(clock),
        .enablen(zero)
        .D(D),
        .pgt_1Hz(pgt_1Hz),
        .loadn(loadn)
    );

    // timer
    wire sec_ones, sec_tens, mins, zero;
    minutes_seconds_counter timer(
        .data(D),
        .loadn(loadn),
        .clrn(clearn),
        .clock(pgt_1Hz),
        .enable(magnetron),
        .sec_ones(sec_ones),
        .sec_tens(sec_tens),
        .mins(mins),
        .zero(zero)
    );

    // decode
    segment7_decoder decoder(
        .sec_ones(sec_ones),
        .sec_tens(sec_tens),
        .min(mins),
        .sec_ones_segs(sec_ones_segs),
        .sec_tens_segs(sec_tens_segs),
        .min_segs(min_segs),
    );
    
endmodule