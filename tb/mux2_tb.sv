module mux2_tb;                 // testbenches have no pins, since nothing plugs into them
    logic [31:0] a, b, y;       // wires to connect to the mux
    logic        sel;       

    mux2 dut (.a(a), .b(b), .sel(sel), .y(y));  // place the mux dut == ("device under test") and wire it up

    initial begin               // simulation-only; runs once, top to bottom Note: (kinda like C)
        a = 32'hAAAA_AAAA;        // 32-bit hex value
        b = 32'h5555_5555;
        sel = 0;
        #10;                    // wait 10 time units for signals to settle
        $display("sel=%b y=%h   (expect AAAAAAAA)", sel, y);

        sel = 1;
        #10;
        $display("sel=%b y=%h   (expect 55555555)", sel, y);

        $finish;                // end the simulation
    end
endmodule