module ID_EXE_Reg(

    input logic clk,               // Reloj del sistema
    input logic reset,             // Reset asíncrono
    input logic stop,              // Señal para detener el funcionamiento del registro
    input logic regWrite_in, memWrite_in, jump_in, branch_in, resultSrc_in, updateCount_in, select_in,  // banderas de 1 bit 
    input logic [31:0] op01_in, op11_in, op21_in, op31_in, op1,      // Operando 1
    input logic [31:0] op02_in, op12_in, op22_in, op32_in, op2,      // Operando 2
    input logic [3:0] rd_in,      // Registro destino
    input logic [3:0] aluControl_in,  // Control de la ALU (4 bits)
	 input logic [1:0] column_in,

    output logic [31:0] op01_out, op11_out, op21_out, op31_out, op1_out,  // Operando 1
    output logic [32:0] op02_out, op12_out, op22_out, op32_out, op2_out,  // Operando 2
    output logic [3:0] rd_out,     // Registro destino
    output logic regWrite_out, memWrite_out, branch_out, resultSrc_out, updateCount_out, select_out,  // banderas de 1 bit 
    output logic [3:0] aluControl_out,   // Control de la ALU (4 bits)
	 output logic [1:0] column_out
);

    // Define registros internos para almacenar los valores entre etapas
    logic [3:0] rd_reg;
    logic [15:0] op01_reg, op11_reg, op21_reg, op31_reg, op1_reg;
    logic [15:0] op02_reg, op12_reg, op22_reg, op32_reg, op2_reg;
	 logic [1:0] col_reg;

    // Banderas
    logic [3:0] aluControl_reg;  
    logic regWrite_reg, memWrite_reg, branch_reg, resultSrc_reg, updateCount_reg, select_reg;

    // Lógica de actualización de registros
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin  // Limpia los registros si la señal de reset está activa
            rd_reg <= 4'b0;
            op01_reg <= 32'b0;
            op02_reg <= 32'b0;
            op11_reg <= 32'b0;
            op12_reg <= 32'b0;
            op21_reg <= 32'b0;
            op22_reg <= 32'b0;
            op31_reg <= 32'b0;
            op32_reg <= 32'b0;
				op1_reg <= 32'b0;
				op2_reg <= 32'b0;
            resultSrc_reg <= 1'b0;
            aluControl_reg <= 4'b0;  
            regWrite_reg <= 1'b0;
				updateCount_reg <= 1'b0;
            memWrite_reg <= 1'b0;
            branch_reg <= 1'b0;
				select_reg <= 0;
				col_reg <= 2'b00;
				
        end else if (!stop) begin  // Actualiza los registros en el flanco positivo del reloj si stop es 0
            rd_reg <= rd_in;
            op01_reg <= op01_in;
            op02_reg <= op02_in;
            op11_reg <= op11_in;
            op12_reg <= op12_in;
            op21_reg <= op21_in;
            op22_reg <= op22_in;
            op31_reg <= op31_in;
            op32_reg <= op32_in;
				op1_reg <= op1;
				op2_reg <= op2;
				
				updateCount_reg <= updateCount_in;
            resultSrc_reg <= resultSrc_in;
            aluControl_reg <= aluControl_in;
            regWrite_reg <= regWrite_in;
            memWrite_reg <= memWrite_in;
            branch_reg <= branch_in;
				select_reg <= select_in;
				col_reg <= column_in;
        end
    end

    // Asignación de salidas a los registros internos
    assign rd_out = rd_reg;
    assign op01_out = op01_reg;
    assign op02_out = op02_reg;
    assign op11_out = op11_reg;
    assign op12_out = op12_reg;
    assign op21_out = op21_reg;
    assign op22_out = op22_reg;
    assign op31_out = op31_reg;
    assign op32_out = op32_reg;
	 
	 assign op1_out = op1_reg;
	 assign op2_out = op2_reg;
	 
	 assign updateCount_out = updateCount_reg;
    assign resultSrc_out = resultSrc_reg;
    assign aluControl_out = aluControl_reg;
    assign regWrite_out = regWrite_reg;
    assign memWrite_out = memWrite_reg;
    assign branch_out = branch_reg;
	 assign select_out = select_reg;
	 assign column_out = col_reg;

endmodule
