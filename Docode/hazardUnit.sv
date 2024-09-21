module hazardUnit(
    input logic zeroFlag,          // Bandera de cero de la ALU que compara el contador
    input logic [3:0] OpCode,      // Código de operación de la instrucción actual

    output logic stopSignal,       // Señal para detener el pipeline
    output logic selectPCMux       // Señal para seleccionar el MUX para el PC
);
    
    // Inicializar la señal de control
    always_comb begin
        // Por defecto, las señales se inicializan en 0
        stopSignal = 0;
        selectPCMux = 0;

        // Detectar hazard de control (si la instrucción es un branch y la bandera de cero está activa)
        if (OpCode == 4'b0011 && zeroFlag) begin
            stopSignal = 1;       // Señal de stop para detener el pipeline
            selectPCMux = 1;      // Selección del PC para el branch
        end
    end

endmodule

