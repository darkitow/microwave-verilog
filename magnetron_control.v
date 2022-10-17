module magnetron_control(
    input wire startn, stopn, clearn, door_closed, timer_done,
    output wire magnetron
);
    // On/Off Logic
    wire Set, Reset;
    assign Set = startn & door_closed;
    assign Reset = stopn | ~door_closed | timer_done;

    // SR latch
    wire Q, Qn;
    assign Q = Reset ~| Qn;
    assign Qn = Set ~| Q;

    assign magnetron = Q;

endmodule