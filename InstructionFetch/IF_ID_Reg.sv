module IF_ID_Reg(
    input logic clk,              // Reloj del sistema
    input logic reset,            // Reset asíncrono
    input logic stop,             // Señal para detener el pipeline
    input logic [11:0] instruction_in, // Instrucción de la etapa IF
    output logic [11:0] instruction_out // Instrucción almacenada
);

    // Define registros internos para almacenar los valores entre etapas
    logic [11:0] instruction_reg;

    // Lógica de actualización de registros
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            instruction_reg <= 12'b0; // Reinicia el registro con 0 en caso de reset
        end else if (stop) begin
            // Si stop está activo, no hacer nada, el registro mantiene su valor actual
            instruction_reg <= instruction_reg; 
        end else begin
            instruction_reg <= instruction_in; // Actualiza con la nueva instrucción
        end
    end

    assign instruction_out = instruction_reg;

endmodule
