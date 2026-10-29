module alu_tb;
    logic [31:0]    a, b, result;
    logic [3:0]     aluControl;
    logic           zero;
    int             errors;

    alu dut(.a(a), .b(b), .result(result), .aluControl(aluControl), .zero(zero));
    
    task checkAlu(input logic [31:0]    aIn, bIn,
                  input logic [3:0]     control,
                  input logic [31:0]    expected,
                  input logic           expectedZero,
                  input string          label);

        a = aIn;
        b = bIn;
        aluControl = control;
        #1;
        if (result !== expected) begin
            $error("%s: aIn = %h, bIn = %h, control = %b, result = %h, expected %h", label, aIn, bIn, aluControl, result, expected);
            errors = errors + 1;
        end
        if (zero !== expectedZero) begin 
            $error("%s: aIn = %h, bIn = %h, control = %b, zero = %b, expected %b", label, aIn, bIn, aluControl, zero, expectedZero);
            errors = errors + 1;
        end
    endtask

    initial begin
        errors = 0;

        checkAlu(32'd5, 32'd3, 4'b0000, 32'd8, 1'b0, "add"); // add check
        checkAlu(32'hFFFF_FFFF, 32'd1, 4'b0000, 32'h0000_0000, 1'b1, "overflow (add)"); // add with overflow check
        checkAlu(32'd10, 32'd3, 4'b1000, 32'd7, 1'b0, "sub"); // subtraction check
        checkAlu(32'd1, 32'd2, 4'b1000, 32'hFFFF_FFFF, 1'b0, "negative sub"); // negative subtraction check
        checkAlu(32'd7, 32'd7, 4'b1000, '0, 1'b1, "equal sub"); // equal subtraction check
        checkAlu(32'hAAAA_AAAA, 32'h5555_5555, 4'b0111, '0, 1'b1, "and"); // and check
        checkAlu(32'hAAAA_AAAA, 32'h5555_5555, 4'b0110, 32'hFFFF_FFFF, 1'b0, "or"); // or check
        checkAlu(32'hF0F0_F0F0, 32'hFF00_FF00, 4'b0100, 32'h0FF0_0FF0, 1'b0, "xor"); // xor check
        checkAlu(32'h0123_3210, 32'h1122_3344, 4'b1111, '0, 1'b1, "default check"); // default check with bad control code
    
        if (errors == 0)
            $display("PASS: all alu tests passed");
        else 
            $display("FAIL: %0d check(s) failed", errors);
        $finish;
    end
endmodule
