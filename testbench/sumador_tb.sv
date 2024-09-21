`timescale 1ns / 1ps
module sumador_tb;

  // Señales de entrada/salida del módulo
  logic [11:0] A;
  logic [11:0] B;
  logic [11:0] C;

  // Instancia del módulo adder
  sumador adder_inst (
    .A(A),
    .B(B),
    .C(C)
  );

  // Inicialización de señales
  initial begin
    // Generar datos aleatorios para A y B
    A = 12'h000;
    B = 12'h001;

    // Imprimir valores iniciales
    #5;
    // Cambiar los valores de A y B
    A = 12'h1;
    B = 12'h1;
	 #5;
    // Cambiar los valores de A y B
    A = 12'h2;
    B = 12'h1;
	 #5;
    // Cambiar los valores de A y B
    A = 12'h3;
    B = 12'h1;


  end

endmodule
