
module decode( input logic clk, rst, regWriteWB, zeroFlag,
					input logic [15:0] inst, resultWB,
					input logic [3:0] RdestW0, RdestW1,RdestW2,RdestW3,
					
					output logic [15:0] RD01E, RD02E, RD11E, RD12E, RD21E, RD22E, RD31E, RD32E,
					output logic [3:0] RdE,
					output logic regWriteE, memWriteE, branchE, resultSrcE, stopPipe, selPC,
					output logic [7:0] BranchPC,
					output logic [2:0] aluControlE
					
					);

	logic [15:0] extended,ext, dataDeco01, dataDeco02, dataDeco11, dataDeco12, dataDeco21, dataDeco22, dataDeco31, dataDeco32;
	logic regWriteD,RWrite, memWriteD,MWrite, jumpD,jump, branchD, branch, aluSrcD, aluSrc, a1Source, source;
	logic [1:0] resultSrcD, resSrc;
	logic [2:0] aluControlD, aluCtrl;
	logic [3:0] a1Data, a2Data;
	
	assign BranchPC = inst[7:0];

	hazardUnit hazard(
								.clk(clk),
								.reset(rst),
								.zeroFlag(zeroFlag),         	// Bandera de cero de la ALU que compara el contador
								.OpCode(inst[11:8]), 	// Código de operación de la instrucción actual
								.stopSignal(stopPipe),  // Señal para detener el pipeline (ENTRA EN TODOS LOS REGISTROS, EXECPTO EL PC)
								.selectPCMux(selPC) 		// senal de seleccion del pc a utilizar
	);
	
	// instancia de register file 0
	register_file regFile_0(.clk(clk), 
										.rst(rst), 
										.regWrite(regWriteWB), 
										.A1(inst[7:4]), 
										.A2(inst[3:0]), 
										.A3(RdestW0), 
										.WD3(resultWB),	
										.RD1(dataDeco01), 
										.RD2(dataDeco02)
										); 
	// instancia de register file
	register_file regFile_1(.clk(clk), 
										.rst(rst), 
										.regWrite(regWriteWB), 
										.A1(inst[7:4]), 
										.A2(inst[3:0]), 
										.A3(RdestW1), 
										.WD3(resultWB),	
										.RD1(dataDeco11), 
										.RD2(dataDeco12)
										);
									
	// instancia de register file
	register_file regFile_2(.clk(clk), 
										.rst(rst), 
										.regWrite(regWriteWB), 
										.A1(inst[7:4]), 
										.A2(inst[3:0]), 
										.A3(RdestW2), 
										.WD3(resultWB),	
										.RD1(dataDeco21), 
										.RD2(dataDeco22)
										);
									
	// instancia de register file
	register_file regFile_3(.clk(clk), 
										.rst(rst), 
										.regWrite(regWriteWB), 
										.A1(inst[7:4]), 
										.A2(inst[3:0]), 
										.A3(RdestW3), 
										.WD3(resultWB),	
										.RD1(dataDeco31), 
										.RD2(dataDeco32)
										);	
										
									
	// instancia para la unidad de control
	Control_Unit control_inst( .operation(inst[15:12]),
										.regWrite(regWriteD), 
										.memWrite(memWriteD), 
										.branch(branchD),
										//.resultSrc(resultSrcD),
										.aluControl(aluControlD)
										);

	
	// instancia para el registro decode/execute
	ID_EXE_Reg decode(.clk(clk),
							.reset(rst),
							.stop(stopPipe),
							.op01_in(dataDeco01),
							.op02_in(dataDeco02),
							.op11_in(dataDeco11),
							.op12_in(dataDeco12),
							.op21_in(dataDeco21),
							.op22_in(dataDeco22),
							.op31_in(dataDeco31),
							.op32_in(dataDeco32),
							
							.rd_in(inst[11:8]),
							.regWrite_in(regWriteD), .memWrite_in(memWriteD),
							.branch_in(branchD), // .aluSrc_in(aluSrc), 	// este de fijo se usa pero lo voy a quitar por el momento (mux antes de la alu) seleccion entre dato de creos o dato del registro
							.resultSrc_in(resultSrcD),
							.aluControl_in(aluControlD),
	 
							.op01_out(RD01E),
							.op02_out(RD02E),
							
							.op11_out(RD11E),
							.op12_out(RD12E),
							
							.op21_out(RD21E),
							.op22_out(RD22E),
							
							.op31_out(RD31E),
							.op32_out(RD32E),
							
							.rd_out(RdE),
							.regWrite_out(regWriteE), .memWrite_out(memWriteE), 
							.branch_out(branchE), //.aluSrc_out(aluSrcE),
							.resultSrc_out(resultSrcE),
							.aluControl_out(aluControlE)
							);

endmodule 