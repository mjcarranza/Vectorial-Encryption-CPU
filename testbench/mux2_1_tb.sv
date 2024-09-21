// test bench for multiplexor 2_1

module mux2_1_tb;

  // Señales
  logic [11:0] data0, data1, result;
  logic select;

  // Instancia del módulo bajo prueba
  mux2_1 mux_inst(
    .data0(data0),
    .data1(data1),
    .select(select),
    .result(result)
  );

  // Inicialización de valores
  initial begin
    // Ingrese sus valores de prueba aquí
    data0 = $random;
    data1 = $random;
    select = 0;

    // Aplicar estímulo
    #10 select = 1;  // Cambiar a la entrada B
    #10 select = 0;  // Cambiar a la entrada A
    #10 select = 1;  // Cambiar a la entrada B

  end

  // Añadir visualización de ondas si es necesario
  // Puedes agregar más bloques de monitoreo según sea necesario

endmodule
