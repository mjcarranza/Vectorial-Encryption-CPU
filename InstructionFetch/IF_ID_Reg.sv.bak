module IF_ID_Reg(
    input logic clk,              // Reloj del sistema
    input logic reset,            // Reset asíncrono
    
	 input logic [31:0] pc_in,     // Valor de PC de la etapa IF
    input logic [31:0] pc_plus4_in, // Valor de PC+4 de la etapa IF
    input logic [31:0] instruction_in, // Instrucción de la etapa IF
	 
    output logic [31:0] pc_out,         // Valor de PC almacenado
    output logic [31:0] pc_plus4_out,   // Valor de PC+4 almacenado
    output logic [31:0] instruction_out // Instrucción almacenada
);

    // Define registros internos para almacenar los valores entre etapas
    logic [31:0] pc_reg;
    logic [31:0] pc_plus4_reg;
    logic [31:0] instruction_reg;

    // Lógica de actualización de registros
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            // Limpia los registros si la señal de reset está activa
            pc_reg <= 32'b0;
            pc_plus4_reg <= 32'b0;
            instruction_reg <= 32'b0;
        end else begin
            // Actualiza los registros
            pc_reg <= pc_in;
            pc_plus4_reg <= pc_plus4_in;
            instruction_reg <= instruction_in;
        end
        // Si stall está activo, los registros mantienen su valor actual
    end

    // Asigna los valores de los registros a las salidas
    assign pc_out = pc_reg;
    assign pc_plus4_out = pc_plus4_reg;
    assign instruction_out = instruction_reg;

endmodule
