
module execute(input logic clk, rst, stop, regWriteE, memWriteE, // senales de un bit
					inout logic [1:0] column_in, 					// senal desde Control Unit
					input logic [3:0] aluControlE,
					input logic [31:0] RD0A, RD0B, RD1A, RD1B, RD2A, RD2B, RD3A, RD3B,		// valor de registros
					input logic [3:0] RDA, RDB, 	// valor de registros para compare
					input logic [3:0] RDest_in, 			// registro de destino
					
					// salidas del modulo
					output logic regWriteM, memWriteM,
					output logic [31:0] RD0, RD1, RD2, RD3,		// resultados de las operaciones
					output logic [3:0] RdM, compResOut,	// reg destino
					output logic zeroFlag		
					);
					
	logic [128:0] srcBE, aluResE;	
	logic [31:0] ALUresult0, ALUresult1, ALUresult2, ALUresult3;
	logic [3:0] resCmp;
					
			
	// instancia para convertir matriz A de filas a columnas

	
	// instancia de la alu
	ALU alu_0(
					 .index(2'b00),			// numero de alu
					 .ALUcontrol(aluControlE), 	// operacion a ejecutar
					 .SrcA(RD0A),			// una fila de la matriz A
					 .SrcB(RD0B),			// una fila de la matriz B
					 //.SrcC(), 			// columna srcA a manera de columna
					 .column(column_in),			// indice de columna
					 //.lastData(),		//	solo para una operacion. un dato de la matriz 
					 .ALUresult(ALUresult0)
					);
	ALU alu_1(
					 .index(2'b01),			// numero de alu
					 .ALUcontrol(aluControlE), 	// operacion a ejecutar
					 .SrcA(RD1A),			// una fila de la matriz A
					 .SrcB(RD1B),			// una fila de la matriz B
					 //.SrcC(), 			// columna srcA a manera de columna
					 .column(column_in),			// indice de columna
					 //.lastData(),		//	solo para una operacion. un dato de la matriz 
					 .ALUresult(ALUresult1)
					);
					
					
	ALU alu_2(
					 .index(2'b10),			// numero de alu
					 .ALUcontrol(aluControlE), 	// operacion a ejecutar
					 .SrcA(RD2A),			// una fila de la matriz A
					 .SrcB(RD2B),			// una fila de la matriz B
					 //.SrcC(), 			// columna srcA a manera de columna
					 .column(column_in),			// indice de columna
					 //.lastData(),		//	solo para una operacion. un dato de la matriz 
					 .ALUresult(ALUresult2)
					);
	
	ALU alu_3(
					 .index(2'b11),			// numero de alu
					 .ALUcontrol(aluControlE), 	// operacion a ejecutar
					 .SrcA(RD3A),			// una fila de la matriz A
					 .SrcB(RD3B),			// una fila de la matriz B
					 //.SrcC(), 			// columna srcA a manera de columna
					 .column(column_in),			// indice de columna
					 //.lastData(),		//	solo para una operacion. un dato de la matriz 
					 .ALUresult(ALUresult3)
					);
					
					
	compareExec compareInst(
								.A(RDA),
								.B(RDB),
								.C(resCmp),
								.zero(zeroFlag)
								);
	
	// instancia para unir los resultados de las ALUS en uno solo y guardarlo en la memoria
	//combineUnit combineInst(
	//				 .Src0(ALUresult0),		// resultado de la alu 0
	//				 .Src1(ALUresult1),		// resultado de la alu 1
	//				 .Src2(ALUresult2),		// resultado de la alu 2
	//				 .Src3(ALUresult3),		// resultado de la alu 3
	//				 .ALUresult(aluResE)	// resultado a guardar en memoria
	//				);

							
	// instancia registro exe-mem
	EXE_MEM_Reg EMReg_inst(
							 .clk(clk),  
							 .reset(rst), 
							 .stop(stop),
							 
							 //ENTRADAS
							 .regWrite_in(regWriteE), 
							 .memWrite_in(memWriteE),
							 .rd_in(RDest_in),     	// Registro destino
							 .resCompare(resCmp),
							 .aluRes0(ALUresult0), 
							 .aluRes1(ALUresult1), 
							 .aluRes2(ALUresult2), 
							 .aluRes3(ALUresult3),
							 
							 //SALIDAS
							 .regWrite_out(regWriteM),
							 .memWrite_out(memWriteM),
							 .rd_out(RdM), 
							 .resCompare_out(compResOut),
							 .aluRes0_out(RD0), 
							 .aluRes1_out(RD1), 
							 .aluRes2_out(RD2), 
							 .aluRes3_out(RD3)
							 
							);
	
	
endmodule 