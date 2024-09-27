module hazardUnit(
    input logic clk,               // Señal de reloj
    input logic reset,             // Señal de reset
    input logic zeroFlag,          // Bandera de cero de la ALU que compara el contador
    input logic [4:0] OpCode,      // Código de operación de la instrucción actual

    output logic stopSignal,       // Señal para detener el pipeline
    output logic selectPCMux       // Señal para seleccionar el MUX para el PC
);
    
    // Declarar un contador para controlar los 3 ciclos de espera
    logic [1:0] cycleCounter;
    logic hazardDetected;          // Señal interna para detectar el hazard

    // Lógica combinacional para detectar el hazard
    always_comb begin
        hazardDetected = 0;

        // Detectar hazard de control (branch con ceroFlag activo)
        if (OpCode == 5'b00010 && zeroFlag) begin
            hazardDetected = 1;
        end
    end

    // Lógica secuencial para controlar el ciclo de detención y la señal selectPCMux
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            cycleCounter <= 0;     // Resetear el contador
            stopSignal <= 0;       // Asegurar que el pipeline no esté detenido en reset
            selectPCMux <= 0;      // Resetear la selección del MUX
        end
        else if (hazardDetected) begin
            if (cycleCounter == 0) begin
                stopSignal <= 1;       // Detener el pipeline al detectar el hazard
                selectPCMux <= 1;      // Selección del MUX para el branch
            end

            if (cycleCounter == 1) begin
                selectPCMux <= 0;      // Cambiar el MUX después del primer ciclo
            end

            // Incrementar el contador y desactivar `stopSignal` después de 3 ciclos
            if (cycleCounter == 3) begin
                cycleCounter <= 0;     // Resetear el contador después de 3 ciclos
                stopSignal <= 0;       // Reactivar el pipeline
            end else begin
                cycleCounter <= cycleCounter + 1;   // Incrementar el contador
            end
        end
    end
endmodule
