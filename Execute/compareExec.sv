module compareExec(
    input  [3:0] A,	// cambiar por la cantidad de bits que corresponda
    input  [3:0] B,
    output [3:0] C,
    output logic zero  // Bandera para indicar si el resultado es cero
);

    // Realizamos la resta de A - B
    assign C = A + B;

    // Activamos la bandera `zero` si el resultado es igual a 0
    always_comb begin
        zero = (C == 4'hA);  // Si C es 0, activamos la bandera `zero`
    end

endmodule
