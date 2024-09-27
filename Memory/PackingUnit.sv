module PackingUnit(
    input logic [31:0] ALUresult0, ALUresult1,
    //input logic MCMode, // Bandera para seleccionar modo MixColumns
    output logic [15:0] halfRow0,halfRow1,halfRow2,halfRow3
);

	assign halfRow0 = {ALUresult0[31:24], ALUresult1[31:24]};
	assign halfRow1 = {ALUresult0[23:16], ALUresult1[23:16]};
	assign halfRow2 = {ALUresult0[15:8], ALUresult1[15:8]};
	assign halfRow3 = {ALUresult0[7:0], ALUresult1[7:0]};

endmodule
