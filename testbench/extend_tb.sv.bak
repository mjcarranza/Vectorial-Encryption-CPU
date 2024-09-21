

module extend_tb;

  // Señales
  logic [23:0] Instr;
  logic [1:0] ImmSrc;
  logic [31:0] ExtImm;

  // Instancia del módulo bajo prueba
  extend uut (
    .Instr(Instr),
    .ImmSrc(ImmSrc),
    .ExtImm(ExtImm)
  );

  // Inicialización de valores
  initial begin
    // Ingrese sus valores de prueba aquí
    Instr = 24'b101010101010101000101010; // Puedes cambiar los valores según tus necesidades
    ImmSrc = 2'b00;

    // Aplicar estímulo
    #10 ImmSrc = 2'b01;  // Cambiar a 12-bit unsigned immediate
    #10 ImmSrc = 2'b10;  // Cambiar a 24-bit two's complement shifted branch

    // Puedes agregar más cambios y verificaciones según sea necesario

  end

endmodule
