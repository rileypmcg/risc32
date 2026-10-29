module alu #(parameter width = 32) (
    input   logic [width-1:0]   a,
    input   logic [width-1:0]   b,
    input   logic [3:0]         aluControl,
    output  logic [width-1:0]   result,
    output  logic               zero
);

    always_comb begin
        case (aluControl)
                4'b0000: result = a + b; // add
                4'b1000: result = a - b; // sub 
                4'b0100: result = a ^ b; // xor
                4'b0110: result = a | b; // or
                4'b0111: result = a & b; // and
                default: result = '0;
        endcase  
    end

    assign zero = (result == '0);   
endmodule