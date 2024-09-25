module EXE_MEM_Reg(
    input logic clk, reset, stop, 
	 input logic regWrite_in, 											// 
	 input logic memWrite_in, 						 
	 input logic [3:0] rd_in, resCompare,     					// 
	 input logic [31:0] aluRes0, aluRes1, aluRes2, aluRes3, 	// 4 resultados de 4 alus de 32 bits cada uno
	 
	 // salidas del registro
	 output logic regWrite_out, memWrite_out,
	 output logic [3:0] rd_out, resCompare_out,
	 output logic [31:0] aluRes0_out, aluRes1_out, aluRes2_out, aluRes3_out
	 
	  
);

    // Define registros internos para almacenar los valores entre etapas
	 logic regWrite_reg, memWrite_reg;
	 logic [3:0] rd_reg, resCmp;
	 logic [15:0] aluRes0_reg, aluRes1_reg, aluRes2_reg, aluRes3_reg;
	 

    // Lógica de actualización de registros
    always_ff @(posedge clk or posedge reset) begin
	 
        if (reset) begin					// Limpia los registros si la señal de reset está activa
				memWrite_reg <= 1'b0;
				regWrite_reg <= 1'b0;
				rd_reg <= 4'b0000;
				resCmp <= 4'b0000;
				aluRes0_reg <= 32'b0;	
				aluRes1_reg <= 32'b0;
				aluRes2_reg <= 32'b0;
				aluRes3_reg <= 32'b0;
				
				
        end else begin 		// Actualiza los registros
				memWrite_reg <= memWrite_in;
				regWrite_reg <= regWrite_in;
				rd_reg <= rd_in;
				resCmp <= resCompare;
				aluRes0_reg <= aluRes0;
				aluRes1_reg <= aluRes1;
				aluRes2_reg <= aluRes2;
				aluRes3_reg <= aluRes3;
				
        end
        // Si stall está activo, los registros mantienen su valor actual
    end

    // Asigna los valores de los registros a las salidas
	 assign memWrite_out = memWrite_reg;
	 assign regWrite_out = regWrite_reg;
	 assign rd_out = rd_reg;
	 assign resCompare_out = resCmp;
	 assign aluRes0_out = aluRes0_reg;
	 assign aluRes1_out = aluRes1_reg;
	 assign aluRes2_out = aluRes2_reg;	
	 assign aluRes3_out = aluRes3_reg;

endmodule
