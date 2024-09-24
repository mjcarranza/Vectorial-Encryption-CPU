module PackingUnit(
    input logic [31:0] ALUresult0, ALUresult1,
    input logic MCMode, // Bandera para seleccionar modo MixColumns
    output logic [15:0] halfRow0,halfRow1,halfRow2,halfRow3
);
/*
always @(*) begin
    if (MCMode) begin
        PackedResult = {ALUresult0[31:24], ALUresult1[31:24], ALUresult2[31:24], ALUresult3[31:24], ALUresult0[23:16], ALUresult1[23:16], ALUresult2[23:16], ALUresult3[23:16], ALUresult0[15:8], ALUresult1[15:8], ALUresult2[15:8], ALUresult3[15:8], ALUresult0[7:0], ALUresult1[7:0], ALUresult2[7:0], ALUresult3[7:0]};
    end else begin  
        PackedResult = {ALUresult0[31:0], ALUresult1[31:0], ALUresult2[31:0], ALUresult3[31:0]};
    end
end
*/
always @(*) begin
    if (MCMode) begin
        halfRow0 = {ALUresult0[31:24], ALUresult1[31:24]};
		  halfRow1 = {ALUresult0[23:16], ALUresult1[23:16]};
		  halfRow2 = {ALUresult0[15:8], ALUresult1[15:8]};
		  halfRow3 = {ALUresult0[7:0], ALUresult1[7:0]};
    end
end
endmodule
