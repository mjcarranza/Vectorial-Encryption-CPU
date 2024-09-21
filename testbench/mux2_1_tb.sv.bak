// test bench for multiplexor 2_1

module mux2_1_tb;

  // Parámetros
  parameter width = 4;

  // Señales
  logic [width - 1:0] data0, data1, result;
  logic select;

  // Instancia del módulo bajo prueba
  mux2_1 #(width) uut (
    .data0(data0),
    .data1(data1),
    .select(select),
    .result(result)
  );

  // Inicialización de valores
  initial begin
    // Ingrese sus valores de prueba aquí
    data0 = 4'b0000;
    data1 = 4'b1111;
    select = 0;

    // Aplicar estímulo
    #10 select = 1;  // Cambiar a la entrada B
    #10 select = 0;  // Cambiar a la entrada A
    #10 select = 1;  // Cambiar a la entrada B

  end

  // Añadir visualización de ondas si es necesario
  // Puedes agregar más bloques de monitoreo según sea necesario

endmodule
