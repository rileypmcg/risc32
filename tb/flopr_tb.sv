module flopr_tb;
    logic        clk;
    logic        reset;
    logic [31:0] d, q;
    int          errors;

    flopr dut (.clk(clk), .reset(reset), .d(d), .q(q));
    initial clk = 0;
    always #5 clk = ~clk;

    task checkQ(input logic [31:0] expected, input string label);
        if (q !== expected) begin
            $error("%s: got %h, expected %h", label, q, expected);
            errors = errors + 1;
        end
    endtask

    initial begin
        errors = 0;

        // ---- Test 1: reset forces q to 0 ----
        reset = 1; // Set reset to 1
        d = 32'hD1D1_D1D1; // Set d to some nonzero value 
        //                 (non zero because we expect a zero value, 
        //                 so if there is an error and d passes to q, we won't be able to recognize it)

        @(posedge clk); // Wait for next edge
        #1; // Step past edge
        checkQ(32'h0000_0000, "reset");

        // ---- Test 2: loads d on the edge ----
        reset = 0; // Set reset to 0
        d = 32'hDEAD_BEEF; // Set do to random hex value that's easily recognizable

        @(posedge clk); // Wait for next edge
        #1; // Step past edge
        checkQ(32'hDEAD_BEEF, "load d");

        // ---- Test 3: holds between edges ----
        d = 32'h8765_4321;

        #2; // Wait NOT for edge - want it to hold OLD value
        checkQ(32'hDEAD_BEEF, "holds");

        // ---- Test 4: picks up the new d on the next edge ----
        @(posedge clk); // Wait for next edge
        #1; // Step past edge

        checkQ(32'h8765_4321, "new d");

        // ---- Test 5: reset wins over d ----
        reset = 1; // Set reset to 1
                   // Keep d nonzero
        @(posedge clk); // Wait for next edge
        #1; // Step past edge

        checkQ(32'h0000_0000, "reset wins");

        // ---- Summary ----
        if(errors == 0)
            $display("PASS: all flopr tests passed");
        else
            $display("FAIL: %0d test(s) failed", errors);
        $finish;
        end
endmodule