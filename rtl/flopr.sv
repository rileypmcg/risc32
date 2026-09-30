module flopr #(parameter width = 32) ( // D flip-flop w/ reset
    input   logic             clk,
    input   logic             reset,
    input   logic [width-1:0] d,
    output  logic [width-1:0] q
);

// Test case with invalid logic (uncomment to test)
// assign q = reset ? '0 : d;

// Correct logic (comment to test)
    always_ff @(posedge clk) begin
        if (reset)
            q <= '0;
        else 
            q <= d;
    end

endmodule