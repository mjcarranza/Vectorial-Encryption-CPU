module register_file_tb;

  // Parámetros de reloj
  logic clk;
  logic rst;

  // Señales de control y datos
  logic WE3;
  logic [3:0] A1, A2, A3;
  logic [31:0] WD3, R15;

  // Señales de salida del módulo
  logic [31:0] RD1, RD2;

  // Instancia del módulo register_file
  register_file reg_file_inst (
    .clk(clk),
    .rst(rst),
    .WE3(WE3),
    .A1(A1),
    .A2(A2),
    .A3(A3),
    .WD3(WD3),
    .R15(R15),
    .RD1(RD1),
    .RD2(RD2)
  );

  // Inicialización de señales
  initial begin
    // Inicializar reloj
    clk = 0;

    // Inicializar otras señales
    rst = 1;
    WE3 = 0;
    A1 = 4'b0000;
    A2 = 4'b0001;
    A3 = 4'b0010;
    WD3 = 32'h0000_1234;
    R15 = 32'h5678_9abc;

    // Ciclo de simulación
    repeat (20) begin
      // Ciclo de reloj
      #5 clk = ~clk;

      // Cambiar valores de señales durante la simulación
      if ($time == 15) begin
        rst = 0;
        WE3 = 1;
      end
    end


  end

endmodule
