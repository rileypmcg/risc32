module mux4_tb;
    logic [31:0] d3, d2, d1, d0, y;
    logic [1:0]  sel;

    mux4 dut(.d3(d3), .d2(d2), .d1(d1), .d0(d0), .y(y), .sel(sel));

    int errors;

    task checkOutput(input logic [1:0] selValue, input logic [31:0] expected);
        sel = selValue;
        #10;
        if (y !== expected) begin
            $error("sel=%b: got %h, expected %h", sel, y, expected);
            errors = errors + 1;
        end
    endtask

    initial begin
        errors = 0;

        d3 = 32'hD3D3_D3D3;
        d2 = 32'hD2D2_D2D2;
        d1 = 32'hD1D1_D1D1;
        d0 = 32'hD0D0_D0D0;
        checkOutput(2'b11, d3);
        checkOutput(2'b10, d2);
        checkOutput(2'b01, d1);
        checkOutput(2'b00, d0);

        if (errors == 0)
            $display("PASS: all mux4 tests passed");
        else 
            $display("FAIL: %0d test(s) failed", errors);
        $finish;
    end
endmodule