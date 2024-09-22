module MEM_WB_Reg(
    input logic clk,
    input logic reset,
    
    // Entradas
    input logic regWrite_in,
    input logic [1:0] resultSrc_in,  		// seleccion del mux
    input logic [3:0] rd_in,
    input logic [15:0] aluRes_in,
    input logic [15:0] readData_in,
    input logic [15:0] writeDataM,

    // Salidas
    output logic regWrite_out,
    output logic [1:0] resultSrc_out,
    output logic [15:0] pc_plus2_out,
    output logic [3:0] rd_out,
    output logic [15:0] aluRes_out,
    output logic [15:0] readData_out,
    output logic [15:0] writeDataW
);

	// Registro de pipeline
	always_ff @(posedge clk or posedge reset) begin
		 if (reset) begin
			  // Reset de todos los valores
			  regWrite_out <= 1'b0;
			  resultSrc_out <= 2'b0;
			  pc_plus2_out <= 16'b0;
			  rd_out <= 4'b0;
			  aluRes_out <= 16'b0;
			  readData_out <= 16'b0;
			  writeDataW <= 16'b0;
		 end else begin
			  // Asignación de registros
			  regWrite_out <= regWrite_in;
			  resultSrc_out <= resultSrc_in;
			  pc_plus2_out <= pc_plus2_in;
			  rd_out <= rd_in;
			  aluRes_out <= aluRes_in;
			  readData_out <= readData_in;
			  writeDataW <= writeDataM;
		 end
	end

endmodule
