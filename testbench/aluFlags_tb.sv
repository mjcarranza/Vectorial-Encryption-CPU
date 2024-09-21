`timescale 1ns / 1ps

module aluFlags_tb;

    // Parámetros del test bench
    parameter CLK_PERIOD = 10; // Periodo del reloj en ps

    // Señales
    logic clk;
    logic rst;
    logic n;
    logic z;
    logic nOut;
    logic zOut;

    // Instancia del módulo aluFlags
    aluFlags uut (
        .clk(clk),
        .rst(rst),
        .n(n),
        .z(z),
        .nOut(nOut),
        .zOut(zOut)
    );

    // Generación del reloj
    always #CLK_PERIOD clk = ~clk;

    // Inicialización
    initial begin
        clk = 0;
        rst = 1;
        n = 0;
        z = 0;

        // Liberación del reset
        #20 rst = 0;

        // Cambios en las señales durante la simulación
        #30 n = 1;
        #30 z = 1;
        #30 n = 0;
        #30 z = 0;
    end

endmodule
