
module execute( input logic clk, rst, regWriteE, memWriteE, jumpE, branchE, aluSrcE, // se;ales de un bit
					input logic [1:0] resultSrcE,
					input logic [3:0] aluControlE,					
					input logic [15:0] RD1E, RD2E, PCPlus2E, PCE, extendedE,
					input logic [3:0] RdE,
					
					output logic regWriteM, memWriteM, PCSrcE,
					output logic [1:0] resultSrcM,
					output logic [15:0] PCPlus2M, aluResM, writeDataM,
					output logic [3:0] RdM				
					);
					
	logic [15:0] srcBE, aluResE;	
	logic zeroE, negE, negComp, zeroComp;
					
			
	// instancia mux
	mux_Exe muxExe_inst(.data0(RD2E),
							  .data1(extendedE),
							  .select(aluSrcE),
							  .result(srcBE)
							  );
	
	// instancia de la alu
	alu alu_inst(
					 .A(RD1E),
					 .B(srcBE),
					 .sel(aluControlE),
					 .alu_out(aluResE),
					 .zero(zeroE),
					 .negative(negE)
					);
					
	// instancia para el registro de las flags
	aluFlags aluFlags_inst(	.clk(clk), 
									.rst(rst), 
									.n(negE), 
									.z(zeroE),
									.nOut(negComp), 
									.zOut(zeroComp)
									);
					
	// instancia de compuerta 
	compuerta compuerta_inst(
							 .zeroE(zeroComp), 
							 .jumpE(jumpE), 
							 .branchE(branchE),
							 .negative(negComp),
							 .pcSrcE(PCSrcE) // salida
							);
							
	// instancia registro exe-mem
	EXE_MEM_Reg EMReg_inst(
							 .clk(clk),              	// Reloj del sistema
							 .reset(rst),            	// Reset asíncrono
							 
							 .regWrite_in(regWriteE), 
							 .memWrite_in(memWriteE),
							 .resultSrc_in(resultSrcE),
							 
							 .pc_plus2_in(PCPlus2E), // Valor de PC+4 de la etapa IF
							 .rd_in(RdE),     	// Registro destino
							 .aluRes_in(aluResE),
							 .op2_in(RD2E),     	// Operando 2
							 
							 
							 .regWrite_out(regWriteM),
							 .resultSrc_out(resultSrcM),
							 .memWrite_out(memWriteM),
							 .pc_plus2_out(PCPlus2M),  // Valor de PC+4 almacenado
							 .rd_out(RdM),     	// Registro destino
							 .aluRes_out(aluResM),
							 .op2_out(writeDataM)     	// Operando 2
							);
	
	
endmodule 