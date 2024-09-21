`timescale 1ns / 1ps

module IF_ID_Reg_tb;

    // Señales de prueba
    logic clk;
    logic reset;
    logic stop;
    logic [11:0] instruction_in;
    logic [11:0] instruction_out;

    // Instancia del DUT (Device Under Test)
    IF_ID_Reg dut (
        .clk(clk),
        .reset(reset),
        .stop(stop),
        .instruction_in(instruction_in),
        .instruction_out(instruction_out)
    );

    // Generador de reloj (50 MHz)
    always #10 clk = ~clk;

    // Procedimiento de prueba
    initial begin
        // Inicialización de señales
        clk = 0;
        reset = 0;
        stop = 0;
        instruction_in = 12'b0;

        // Prueba 1: Verificación de reset
        $display("Prueba 1: Reset");
        reset = 1; // Activar reset
        #20; // Esperar un ciclo
        reset = 0; // Desactivar reset
        #20;
        if (instruction_out == 12'b0)
            $display("Reset correcto: instruction_out = %b", instruction_out);
        else
            $display("Error: instruction_out = %b", instruction_out);

        // Prueba 2: Cargar una instrucción
        $display("Prueba 2: Cargar instrucción");
        instruction_in = 12'hABC; // Nueva instrucción
        #20; // Esperar a que se cargue en el registro
        if (instruction_out == 12'hABC)
            $display("Carga correcta: instruction_out = %b", instruction_out);
        else
            $display("Error: instruction_out = %b", instruction_out);

        // Prueba 3: Detener con la señal stop
        $display("Prueba 3: Detener con stop");
        stop = 1; // Activar la señal stop
        instruction_in = 12'h123; // Cambiar instrucción de entrada
        #20; // Esperar un ciclo
        if (instruction_out == 12'hABC) // El valor no debería cambiar
            $display("Stop correcto: instruction_out = %b", instruction_out);
        else
            $display("Error: instruction_out = %b", instruction_out);

        // Prueba 4: Desactivar stop y cargar nueva instrucción
        $display("Prueba 4: Desactivar stop y cargar nueva instrucción");
        stop = 0; // Desactivar stop
        instruction_in = 12'h456; // Nueva instrucción
        #20; // Esperar un ciclo
        if (instruction_out == 12'h456)
            $display("Carga después de stop correcta: instruction_out = %b", instruction_out);
        else
            $display("Error: instruction_out = %b", instruction_out);

    end

endmodule
