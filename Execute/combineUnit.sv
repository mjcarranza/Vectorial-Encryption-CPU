module combineUnit(
    input logic [31:0] Src0,
    input logic [31:0] Src1,
	 input logic [31:0] Src2,
	 input logic [31:0] Src3,
    output logic [127:0] ALUresult
);


	// Lógica combinacional para concatenar las entradas en el orden indicado
	always_comb begin
	  ALUresult = {Src3, Src2, Src1, Src0}; // Src3 es el más significativo, Src0 el menos significativo
	end

endmodule