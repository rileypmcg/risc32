module mux4 #(parameter width = 32) (    // defines module
    input logic [width-1:0] d0, d1, d2, d3,
    input logic [1:0] sel,
    output logic [width-1:0] y
);
    always_comb begin                   // always_comb (combinational) re-evaluates whenever any signal it reads changes.
        case (sel)                      // case is like a truth table: goated
            2'b00: y = d0;
            2'b01: y = d1;
            2'b10: y = d2;
            2'b11: y = d3;
            default: y = '0;
        endcase
    end
endmodule