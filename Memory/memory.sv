

module memory( input logic clk, regWriteM, memWriteM, //rst, stop,
					input logic [31:0] RD0, RD1, RD2, RD3,
					input logic [3:0] RdM, resCmp,
					output logic [3:0] RdW, resCompare,
					output logic regWriteW
					
					);
						
	logic [15:0] readDataM;
	logic [127:0] aluRes;
	
	// instancia para unir los resultados de las ALUS en uno solo y guardarlo en la memoria
	combineUnit combineInst(
					 .Src0(RD0),			// resultado de la alu 0
					 .Src1(RD1),			// resultado de la alu 1
					 .Src2(RD2),			// resultado de la alu 2
					 .Src3(RD3),			// resultado de la alu 3
					 .ALUresult(aluRes)	// resultado a guardar en memoria
					);
	
	// instancia de la memoria para datos
	DataMemory dataMem_inst(
								.address_a(16'h0), 	// se guarda el resulatado de la matriz en la posicion 0
								.clock_a(clk),
								.data_a(aluRes),		// cambiar memoria para que acepte 128 bits de entrada
								.wren_a(memWriteM), 	// write enable
								.q_a(readDataM)  		// datos leidos
								);
								 				
				
				
	// instancia del registro de memoria
	//MEM_WB_Reg memory(
	//					   .clk(clk),
	//						.reset(rst),
	//						
	//						.regWrite_in(regWriteM),
	//						.resultSrc_in(resultSrcM),
	//						.rd_in(RdM),
	//						.aluRes_in(aluResM),
	//						.readData_in(readDataM),
	//						.writeDataM(writeDataM),
	//						
	//						.regWrite_out(regWriteW),
	//						.resultSrc_out(resultSrcW),
	//						.rd_out(RdW),
	//						.aluRes_out(aluResW),
	//						.readData_out(readDataW),
	//						.writeDataW(writeDataW)
	//						);
	
	assign regWriteW = regWriteM;
	assign RdW = RdM;
	assign resCompare = resCmp;
	
					
					
endmodule 