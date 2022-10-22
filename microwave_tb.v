`include "microwave.v"
`include "magnetron_control.v"
`include "timer_input_and_control.v"
`include "minutes_seconds_counter.v"
`include "segment7_decoder.v"

module microwave_tb;
    reg startn, stopn, clearn, door_closed, clock; reg [9:0] keypad;
    wire[6:0] sec_ones_segs, sec_tens_segs, min_segs; wire magnetron;

    microwave (startn, stopn, clearn, door_closed, clock, keypad, sec_ones_segs, sec_tens_segs, min_segs, mag_on);

    begin
        
    end   
endmodule