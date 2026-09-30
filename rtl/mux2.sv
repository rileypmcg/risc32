module mux2 #(parameter width = 32) (       // creates a module named 'mux2' with the parameter width of 32 bits
    input logic [width-1:0] a, b,           // creates input logic wires 'a' & 'b' that are a 32 bit bus
    input logic             sel,            // creates select wire thats just one, no bus
    output logic [width-1:0] y              // creates y wire that is a 32 width bus
);
    assign y = sel ? b : a;                 // permanently assigns y to if select then b if not a
endmodule                                   // ends the module description