module magnetron_control(
    input startn, stopn, clearn, door_closed, timer_done,
    output magnetron
);
    // On/Off Logic
    wire Set, Reset;
    assign Set = startn & door_closed;
    assign Reset = stopn | ~door_closed | timer_done | clearn;

    // SR latch
    wire Q, Qn;
    assign Q = Reset ~| Qn;
    assign Qn = Set ~| Q;

    assign magnetron = Q;

endmodule