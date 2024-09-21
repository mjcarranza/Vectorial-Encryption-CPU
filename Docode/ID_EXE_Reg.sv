module ID_EXE_Reg(

    input logic clk,               // Reloj del sistema
    input logic reset,             // Reset asíncrono
    input logic stop,              // Señal para detener el funcionamiento del registro
    input logic regWrite_in, memWrite_in, jump_in, branch_in, resultSrc_in,  // banderas de 1 bit 
    input logic [15:0] op01_in, op11_in, op21_in, op31_in,      // Operando 1
    input logic [15:0] op02_in, op12_in, op22_in, op32_in,      // Operando 2
    input logic [3:0] rd_in,      // Registro destino
    input logic [3:0] aluControl_in,  // Control de la ALU (4 bits)

    output logic [15:0] op01_out, op11_out, op21_out, op31_out,  // Operando 1
    output logic [15:0] op02_out, op12_out, op22_out, op32_out,  // Operando 2
    output logic [3:0] rd_out,     // Registro destino
    output logic regWrite_out, memWrite_out, branch_out, resultSrc_out,  // banderas de 1 bit 
    output logic [3:0] aluControl_out   // Control de la ALU (4 bits)
);

    // Define registros internos para almacenar los valores entre etapas
    logic [3:0] rd_reg;
    logic [15:0] op01_reg, op11_reg, op21_reg, op31_reg;
    logic [15:0] op02_reg, op12_reg, op22_reg, op32_reg;

    // Banderas
    logic [3:0] aluControl_reg;  
    logic regWrite_reg, memWrite_reg, branch_reg, resultSrc_reg;

    // Lógica de actualización de registros
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin  // Limpia los registros si la señal de reset está activa
            rd_reg <= 4'b0;
            op01_reg <= 16'b0;
            op02_reg <= 16'b0;
            op11_reg <= 16'b0;
            op12_reg <= 16'b0;
            op21_reg <= 16'b0;
            op22_reg <= 16'b0;
            op31_reg <= 16'b0;
            op32_reg <= 16'b0;
            resultSrc_reg <= 1'b0;
            aluControl_reg <= 4'b0;  
            regWrite_reg <= 1'b0;
            memWrite_reg <= 1'b0;
            branch_reg <= 1'b0;
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
            resultSrc_reg <= resultSrc_in;
            aluControl_reg <= aluControl_in;
            regWrite_reg <= regWrite_in;
            memWrite_reg <= memWrite_in;
            branch_reg <= branch_in;
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
    assign resultSrc_out = resultSrc_reg;
    assign aluControl_out = aluControl_reg;
    assign regWrite_out = regWrite_reg;
    assign memWrite_out = memWrite_reg;
    assign branch_out = branch_reg;

endmodule
