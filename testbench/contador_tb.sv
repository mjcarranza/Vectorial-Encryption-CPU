module contador_tb;

    // Parámetros
    parameter CLK_PERIOD = 10; // Periodo del reloj en unidades de tiempo

    // Definición de señales
    reg clk;
    reg reset;
    wire [15:0] address;

    // Instancia del contador
    contador uut (
        .clk(clk),
        .reset(reset),
        .address(address)
    );

    // Generación de reloj
    always #((CLK_PERIOD / 2)) clk = ~clk;

    // Estímulo
    initial begin
        clk = 0;
        reset = 1;
        #20 reset = 0; // Desactiva el reset después de 20 unidades de tiempo
        #100; // Espera 100 unidades de tiempo para observar el contador

        // Verificar el contador
        $display("Inicial: address = %d", address);
        #10; // Espera 10 unidades de tiempo antes de mostrar el siguiente valor
        $display("Después de 10 ciclos: address = %d", address);
        #10; // Espera 90 unidades de tiempo antes de finalizar la simulación
    end

endmodule
