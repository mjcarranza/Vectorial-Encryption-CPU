`timescale 1ns / 1ps

module mux_WB_tb;

    // Parámetros de tiempo
    parameter CLK_PERIOD = 10; // Periodo del reloj en ns
    
    // Señales
    logic [15:0] data0, data1, data2, data3;
    logic [1:0] select;
    logic [15:0] result;
    
    // Instancia del módulo mux_WB
    mux_WB mux_inst (
        .data0(data0),
        .data1(data1),
        .data2(data2),
        .data3(data3),
        .select(select),
        .result(result)
    );
    
    // Generador de clock
    always #CLK_PERIOD select++;

    // Inicialización de señales
    initial begin
        data0 = 16'h1234;
        data1 = 8'h22;
        data2 = 16'h9ABC;
        data3 = 16'hDEF0;
        select = 2'b00; // Selección inicial

        // Espera un poco para estabilizar las entradas
        #10;
		  select = 2'b01;
		  #10;
		  select = 2'b10;
		  #10;
		  select = 2'b11;

        // Imprime el encabezado
        $display("Time |  Data0  |  Data1  |  Data2  |  Data3  | Select | Result");
        $display("-------------------------------------------------------------------");

        // Prueba de selección de datos
        for (int i = 0; i < 4; i++) begin
            select = i; // Selecciona cada entrada

            // Imprime los datos y el resultado
            $display("%0d |   %h  |   %h  |   %h  |   %h  |    %d   |   %h", $time, data0, data1, data2, data3, select, result);
            #CLK_PERIOD; // Espera un ciclo de reloj
        end
    end

endmodule
