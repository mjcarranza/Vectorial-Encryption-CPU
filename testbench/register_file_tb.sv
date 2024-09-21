module register_file_tb;

    // Declarar señales para el testbench
    logic clk;
    logic rst;
    logic regWrite;
    logic [3:0] A1, A2, A3;
    logic [15:0] WD3;
    logic [15:0] RD1, RD2;

    // Instanciar el DUT (Device Under Test)
    register_file uut (
        .clk(clk),
        .rst(rst),
        .regWrite(regWrite),
        .A1(A1),
        .A2(A2),
        .A3(A3),
        .WD3(WD3),
        .RD1(RD1),
        .RD2(RD2)
    );

    // Generar la señal de reloj
    always #5 clk = ~clk;

    // Procedimiento de inicialización
    initial begin
        // Inicializar señales
        clk = 0;
        rst = 1;
        regWrite = 0;
        A1 = 0;
        A2 = 0; 
        A3 = 0;
        WD3 = 16'h0;
        
        // Reset inicial
        #10;
        rst = 0;

        // Escribir en un registro
        #10;
        A3 = 4'b0001;      // Registro de destino A3 = 1
        WD3 = 16'h1234;    // Valor a escribir
        regWrite = 1;      // Habilitar escritura
        
        // Esperar para ver la escritura
        #10;
        regWrite = 0;

        // Leer del registro
        A1 = 4'b0001;      // Leer el registro A1 = 1
        A2 = 4'b0000;      // Leer el registro A2 = 0 (debería ser 0)
        
        // Esperar para ver los resultados de lectura
        #10;
        
        // Comprobar que se ha leído correctamente
        $display("RD1 = %h, Esperado: 1234", RD1); // Debería ser 0x1234
        $display("RD2 = %h, Esperado: 0000", RD2); // Debería ser 0x0000

        // Escribir en otro registro
        #10;
        A3 = 4'b0010;      // Registro de destino A3 = 2
        WD3 = 16'hABCD;    // Valor a escribir
        regWrite = 1;      // Habilitar escritura

        // Esperar para ver la escritura
        #10;
        regWrite = 0;

        // Leer del registro
        A1 = 4'b0010;      // Leer el registro A1 = 2
        A2 = 4'b0001;      // Leer el registro A2 = 1 (debería ser 0x1234)

        // Esperar para ver los resultados de lectura
        #10;

        // Comprobar que se ha leído correctamente
        $display("RD1 = %h, Esperado: ABCD", RD1); // Debería ser 0xABCD
        $display("RD2 = %h, Esperado: 1234", RD2); // Debería ser 0x1234

        // Fin de simulación
        #10;
        $finish;
    end

endmodule
