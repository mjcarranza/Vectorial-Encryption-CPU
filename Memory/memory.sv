

module memory( input logic clk, rst, regWriteM, memWriteM,
					input logic [15:0] aluResM, writeDataM,
					input logic [3:0] RdM,
					input logic resultSrcM,
					output logic [15:0] aluResW, readDataW, writeDataW,
					output logic [3:0] RdW,
					output logic regWriteW,
					output logic resultSrcW 
					
					);
						
	logic [15:0] readDataM;
	
	// instancia de la memoria para datos
	DataMemory dataMem_inst(
								.address_a(aluResM),
								.clock_a(clk),
								.data_a(writeDataM),
								.wren_a(memWriteM),
								.q_a(readDataM)
								);
								 				
				
				
	// instancia del registro de memoria
	MEM_WB_Reg memory(
						   .clk(clk),
							.reset(rst),
							
							.regWrite_in(regWriteM),
							.resultSrc_in(resultSrcM),
							.rd_in(RdM),
							.aluRes_in(aluResM),
							.readData_in(readDataM),
							.writeDataM(writeDataM),
							
							.regWrite_out(regWriteW),
							.resultSrc_out(resultSrcW),
							.rd_out(RdW),
							.aluRes_out(aluResW),
							.readData_out(readDataW),
							.writeDataW(writeDataW)
							);
					
					
endmodule 