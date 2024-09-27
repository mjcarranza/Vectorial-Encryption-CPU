module Combine16to32(
    input logic [15:0] in0, in1,   // Entradas de 16 bits
    output logic [31:0] out        // Salida de 32 bits
);

    assign out = {in0, in1};       // Concatenar las dos entradas

endmodule
