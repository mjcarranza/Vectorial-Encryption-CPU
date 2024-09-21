module program_counter_tb;

  // Parámetros de reloj
  logic clk;
  logic rst;
  
  // Señales de entrada/salida del módulo
  logic [32-1:0] d;
  logic [32-1:0] q;

  // Instancia del módulo program_counter
  program_counter pc_inst (
    .clk(clk),
    .rst(rst),
    .d(d),
    .q(q)
  );

  // Inicialización de señales
  initial begin
    // Inicializar reloj
    clk = 0;

    // Ciclo de simulación
    repeat (20) begin
      // Ciclo de reloj
      #5 clk = ~clk;

      // Generar datos aleatorios para simular
      d = $random;

      // Aplicar reset después de algunos ciclos
      if ($time == 15) rst = 1;
    end

  end

endmodule
