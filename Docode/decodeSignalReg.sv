module decodeSignalReg(
    input logic clk,
    input logic reset,
    
    // Entradas
    input logic [31:0] pc_in,
    input logic [31:0] pc_p1_in,
    input logic [3:0] rd_in,
    input logic [31:0] extend_in,
    
    input logic regWrite_in,
    input logic memWrite_in,
    input logic jump_in,
    input logic branch_in,
    input logic aluSrc_in,
    input logic [1:0] resultSrc_in,
    input logic [3:0] aluControl_in,

    // Salidas
    output logic [31:0] pc_out,
    output logic [31:0] pc_p1_out,
    output logic [3:0] rd_out,
    output logic [31:0] extend_out,
    
    output logic regWrite_out,
    output logic memWrite_out,
    output logic jump_out,
    output logic branch_out,
    output logic aluSrc_out,
    output logic [1:0] resultSrc_out,
    output logic [3:0] aluControl_out
);

// Registro de pipeline
always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        // Reset de todos los valores
        pc_out <= 32'b0;
        pc_p1_out <= 32'b0;
        rd_out <= 4'b0;
        extend_out <= 32'b0;
        
        regWrite_out <= 1'b0;
        memWrite_out <= 1'b0;
        jump_out <= 1'b0;
        branch_out <= 1'b0;
        aluSrc_out <= 1'b0;
        resultSrc_out <= 2'b0;
        aluControl_out <= 4'b0;
    end else begin
        // Asignación de registros
        pc_out <= pc_in;
        pc_p1_out <= pc_p1_in;
        rd_out <= rd_in;
        extend_out <= extend_in;
        
        regWrite_out <= regWrite_in;
        memWrite_out <= memWrite_in;
        jump_out <= jump_in;
        branch_out <= branch_in;
        aluSrc_out <= aluSrc_in;
        resultSrc_out <= resultSrc_in;
        aluControl_out <= aluControl_in;
    end
end

endmodule
