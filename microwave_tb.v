`include "microwave.v"
`include "magnetron_control.v"
`include "timer_input_and_control.v"
`include "minutes_seconds_counter.v"
`include "segment7_decoder.v"
`timescale  1ms/1ms

module microwave_tb;
    reg [9:0] keypad;
    reg clk, start, stop, clear, door;
    wire[6:0] ones, tens, mins;
    wire mag;
    
    microwave ttbb(
        .keypad(key),
        .clock(clk),
        .startn(start),
        .stopn(stop),
        .clearn(clear),
        .door_closed(door),
        .sec_ones_segs(ones),
        .sec_tens_segs(tens),
        .min_segs(mins),
        .mag_on(mag));

        initial begin
    $dumpfile("microwave.vcd");
    $dumpvars(0,microwave_tb);
  end
  
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end
  
  initial begin
    start = 1; stop = 0; door = 1; clear = 1; 
    #5;

    // 6:01
    key = 10'b0000000000;
    #5;

    key = 10'b0000010000; 
    #100; 

    key = 10'b0000000000;
    #5;
    
    key = 10'b0000000001;
    #100;

    key = 10'b0000000000;
    #5;
            
    key = 10'b1000000000; 
    #100;

    start = 0; stop = 1;
    #50000;

    stop = 0; start = 1; // Testando se ele para
    #5000;

    clear = 0; // Clear

    // 0:55
    key = 10'b0000000000;
    #5;

    key = 10'b0000000001; 
    #100; 

    key = 10'b0000000000;
    #5;
    
    key = 10'b0000100000;
    #100;

    key = 10'b0000000000;
    #5;
            
    key = 10'b0000100000; 
    #100;

    start = 0; stop = 1; clear = 1;
    #50000;

    door = 0; start = 1;// Abrindo a porta durante a contagem
    #5000;

    $finish();
    end
endmodule