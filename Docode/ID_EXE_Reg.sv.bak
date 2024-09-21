module ID_EXE_Reg(
    input logic clk,              	// Reloj del sistema
    input logic reset,            	// Reset asíncrono
	 
    input logic [31:0] pc_in,     	// Valor de PC de la etapa IF
    input logic [31:0] pc_plus4_in, // Valor de PC+4 de la etapa IF
	 input logic [31:0] op1_in,     	// Operando 1
	 input logic [31:0] op2_in,     	// Operando 2
	 input logic [4:0] rd_in,     	// Registro destino
	 input logic [31:0] extend_in,   // Valor de PC de la etapa IF
	 
	 // agregar aca las se;ales del control unit	 in/out
	 
    output logic [31:0] pc_out,        // Valor de PC almacenado
    output logic [31:0] pc_plus4_out,  // Valor de PC+4 almacenado
	 output logic [31:0] op1_out,     	// Operando 1
	 output logic [31:0] op2_out,     	// Operando 2
	 output logic [4:0] rd_out,     	// Registro destino
	 output logic [31:0] extend_out    // Valor de PC de la etapa IF
	 
	  
);

    // Define registros internos para almacenar los valores entre etapas
    logic [31:0] pc_reg;
    logic [31:0] pc_plus4_reg;
	 logic [4:0] rd_reg;
	 logic [31:0] op1_reg;
	 logic [31:0] op2_reg;
	 logic [31:0] ext_reg;
	 

    // Lógica de actualización de registros
    always_ff @(posedge clk or posedge reset) begin
	 
        if (reset) begin					// Limpia los registros si la señal de reset está activa
            pc_reg <= 32'b0;
            pc_plus4_reg <= 32'b0;
				rd_reg <= 5'b0;
				ext_reg <= 32'b0;
				op1_reg <= 32'b0;
				op2_reg <= 32'b0;
				
				
        end else begin 		// Actualiza los registros
            pc_reg <= pc_in;
            pc_plus4_reg <= pc_plus4_in;
				rd_reg <= rd_in;
				ext_reg <= extend_in;
				op1_reg <= op1_in;
				op2_reg <= op2_in;
				
        end
        // Si stall está activo, los registros mantienen su valor actual
    end

    // Asigna los valores de los registros a las salidas
    assign pc_out = pc_reg;
    assign pc_plus4_out = pc_plus4_reg;
	 assign rd_out = rd_reg;
	 assign op1_out = op1_reg;
	 assign op2_out = op2_reg;
	 assign extend_out = ext_reg;

endmodule
