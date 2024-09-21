

module extend_tb;

  // Señales
  logic [6:0] Instr;
  logic [15:0] ExtImm;

  // Instancia del módulo bajo prueba
  extend uut (
    .Instr(Instr),
    .ExtImm(ExtImm)
  );

  // Inicialización de valores
  initial begin
    // Ingrese sus valores de prueba aquí
    Instr = 7'b1010101;

    // Aplicar estímulo
    #10;
	 Instr = 7'b0001111;
    #10; 
	 Instr = 7'b0000001;
	 #10;

  end

endmodule
