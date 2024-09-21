module EXE_MEM_Reg(
    input logic clk,              	// Reloj del sistema
    input logic reset,            	// Reset asíncrono
	 
	 input logic regWrite_in, memWrite_in,
	 input logic [1:0] resultSrc_in,
	 
    input logic [15:0] pc_plus2_in, // Valor de PC+4 de la etapa IF
	 input logic [3:0] rd_in,     	// Registro destino
	 input logic [15:0] aluRes_in,
	 input logic [15:0] op2_in,     	// Operando 2
	 
	 // agregar aca las se;ales del control unit	 in/out
	 
	 output logic regWrite_out, memWrite_out,
	 output logic [1:0] resultSrc_out,
    output logic [15:0] pc_plus2_out,  // Valor de PC+4 almacenado
	 output logic [3:0] rd_out,     	// Registro destino
	 output logic [15:0] aluRes_out,
	 output logic [15:0] op2_out     	// Operando 2
	 
	  
);

    // Define registros internos para almacenar los valores entre etapas
	 logic regWrite_reg, memWrite_reg;
	 logic [1:0] resultSrc_reg;
    logic [15:0] pc_plus2_reg;
	 logic [3:0] rd_reg;
	 logic [15:0] aluRes_reg;
	 logic [15:0] op2_reg;
	 

    // Lógica de actualización de registros
    always_ff @(posedge clk or posedge reset) begin
	 
        if (reset) begin					// Limpia los registros si la señal de reset está activa
				memWrite_reg <= 1'b0;
				regWrite_reg <= 1'b0;
				resultSrc_reg <= 2'b0;
            pc_plus2_reg <= 16'b0;
				rd_reg <= 4'b0;
				aluRes_reg <= 16'b0;
				op2_reg <= 16'b0;
				
				
        end else begin 		// Actualiza los registros
				memWrite_reg <= memWrite_in;
				regWrite_reg <= regWrite_in;
				resultSrc_reg <= resultSrc_in;
            pc_plus2_reg <= pc_plus2_in;
				rd_reg <= rd_in;
				aluRes_reg <= aluRes_in;
				op2_reg <= op2_in;
				
        end
        // Si stall está activo, los registros mantienen su valor actual
    end

    // Asigna los valores de los registros a las salidas
	 assign memWrite_out = memWrite_reg;
	 assign regWrite_out = regWrite_reg;
	 assign resultSrc_out = resultSrc_reg;
    assign pc_plus2_out = pc_plus2_reg;
	 assign rd_out = rd_reg;
	 assign aluRes_out = aluRes_reg;
	 assign op2_out = op2_reg;

endmodule
