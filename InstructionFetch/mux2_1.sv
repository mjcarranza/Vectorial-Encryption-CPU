module mux2_1(
  input logic [11:0] data0,        // Entrada de 12 bits
  input logic [7:0] data1,         // Entrada de 8 bits
  input logic select,              // Señal de selección
  output logic [11:0] result       // Resultado de 12 bits
);

  always_comb begin
    if (select)
      result = {4'b0000, data1};   // Concatenar 4 ceros a los 8 bits de data1
    else
      result = data0;
  end

endmodule
