module procesador(
			input logic clk, rst, regWriteWB, updateCount, zeroFlag,
			input logic [15:0] resCount, res0, res1, res2, res3, // entrada individual
			input logic [3:0] RdestW, // entrada general
			
			output logic [11:0] pcsuma,
			
			// salidas del cicle decode
			output logic [15:0] RD01E, RD02E, RD11E, RD12E, RD21E, RD22E, RD31E, RD32E, dataOp1, dataOp2,instruction,
			output logic [3:0] RdE,
			output logic regWriteE, memWriteE, updateCnt,
			output logic [2:0] aluControlE
			);

	logic [15:0] pc, pc_out, Inst, inst, PCD, nextPC;
	logic [15:0] extended,ext, dataDeco01, dataDeco02, dataDeco11, dataDeco12, dataDeco21, dataDeco22, dataDeco31, dataDeco32, dataCont1, dataCont2;
	logic regWriteD, RWrite, memWriteD, MWrite, jumpD, jump, branchD, branch, aluSrcD, aluSrc, a1Source, source, selPC, stop, update;
	logic [2:0] aluControlD, aluCtrl;
	logic [3:0] a1Data, a2Data;
	
	
	

	// --------------------------------------- ciclo fetch ---------------------------------------------------//
	
	
	
	// mux PC
	mux2_1 muxPC(.data0(nextPC),
                .data1(inst[7:0]),
                .select(selPC),
                .result(pc)
                );
					 
	// registro PC
	program_counter pc_inst(.clk(clk), .rst(rst), .d(pc), .q(pc_out));
	
	// sumar pc+2
	sumador sum_inst(.A(pc_out), .B(12'h1), .C(nextPC));		/// cambiar el valor de la suma si es necesario

	// instancia de memoria de instrucciones
	IMem IMem_inst(.address(pc_out), .clock(clk), .q(Inst));
	
	IF_ID_Reg fetch(.clk(clk), 
						.reset(rst), 
						.stop(stop),
						.instruction_in(Inst), 
						.instruction_out(inst));
	assign pcsuma = pc_out;
	assign instruction = inst;
	
	
	// ------------------------------------- ciclo decode --------------------------------------------------- //
	
	// unidad de hazard
	hazardUnit hazard(
								.clk(clk),
								.reset(rst),
								.zeroFlag(zeroFlag),         	// Bandera de cero de la ALU que compara el contador
								.OpCode(inst[11:8]), 	// Código de operación de la instrucción actual
								.stopSignal(stop),  // Señal para detener el pipeline (ENTRA EN TODOS LOS REGISTROS, EXECPTO EL PC)
								.selectPCMux(selPC) 		// senal de seleccion del pc a utilizar
	);
	
	// instancia de register file 0
	register_file regFile_0(.clk(clk), 
										.rst(rst), 
										.regWrite(regWriteWB), 
										.A1(inst[7:4]), 
										.A2(inst[3:0]), 
										.A3(RdestW), 
										.WD3(res0),	
										.RD1(dataDeco01), 
										.RD2(dataDeco02)
										); 
	// instancia de register file
	register_file regFile_1(.clk(clk), 
										.rst(rst), 
										.regWrite(regWriteWB), 
										.A1(inst[7:4]), 
										.A2(inst[3:0]), 
										.A3(RdestW), 
										.WD3(res1),	
										.RD1(dataDeco11), 
										.RD2(dataDeco12)
										);
									
	// instancia de register file
	register_file regFile_2(.clk(clk), 
										.rst(rst), 
										.regWrite(regWriteWB), 
										.A1(inst[7:4]), 
										.A2(inst[3:0]), 
										.A3(RdestW), 
										.WD3(res2),	
										.RD1(dataDeco21), 
										.RD2(dataDeco22)
										);
									
	// instancia de register file
	register_file regFile_3(.clk(clk), 
										.rst(rst), 
										.regWrite(regWriteWB), 
										.A1(inst[7:4]), 
										.A2(inst[3:0]), 
										.A3(RdestW), 
										.WD3(res3),	
										.RD1(dataDeco31), 
										.RD2(dataDeco32)
										);	
										
	reg_Count reg_Count(.clk(clk), 
										.rst(rst), 
										.regWrite(updateCount), 			// siempre se escribe el valor del contador
										.A1(4'h0), 			// registro donde se guarda el numero a comparar para salir del loop (reg 0)
										.A2(4'h1), 			// registro donde se guarda el contador a comparar con 0 (reg 1)
										.A3(4'b0001), 				// registro 1 siempre
										.WD3(resCount),			// resultado de la alu del contador
										.RD1(dataCont1),
										.RD2(dataCont2)
										);
									
	// instancia para la unidad de control
	Control_Unit control_inst( .operation(inst[11:8]),
										.regWrite(regWriteD), 
										.memWrite(memWriteD), 
										//.branch(branchD),
										.updateCount(update),
										//.resultSrc(resultSrcD),
										.aluControl(aluControlD)
										);

	
	// instancia para el registro decode/execute
	ID_EXE_Reg decode(.clk(clk),
							.reset(rst),
							.stop(stop),
							.op01_in(dataDeco01),
							.op02_in(dataDeco02),
							.op11_in(dataDeco11),
							.op12_in(dataDeco12),
							.op21_in(dataDeco21),
							.op22_in(dataDeco22),
							.op31_in(dataDeco31),
							.op32_in(dataDeco32),
							.op1(dataCont1),
							.op2(dataCont2),
							
							.updateCount_in(update),//
							.rd_in(inst[11:8]),
							.regWrite_in(regWriteD), .memWrite_in(memWriteD),
							//.branch_in(branchD),
							//.resultSrc_in(resultSrcD),
							.aluControl_in(aluControlD),
	 
							.op01_out(RD01E),
							.op02_out(RD02E),
							.op11_out(RD11E),
							.op12_out(RD12E),
							.op21_out(RD21E),
							.op22_out(RD22E),
							.op31_out(RD31E),
							.op32_out(RD32E),
							.op1_out(dataOp1),
							.op2_out(dataOp2),
							
							.rd_out(RdE),
							.updateCount_out(updateCnt),//
							.regWrite_out(regWriteE), .memWrite_out(memWriteE), 
							//.branch_out(branchE),
							//.resultSrc_out(resultSrcE),
							.aluControl_out(aluControlE)
							);
	
	
	// ------------------------------------- Etapa de ejecucion ---------------------------------------------- //
	

	
	
	// ------------------------------------- Etapa de memoria y Write Back------------------------------------ //
							

	
			
endmodule 







	// --------------------------------------- VGA --------------------------------------------------//
	
	//vga vga_inst(
	//			.clk(clk),
	//			.rst(rst),
	//			.pixeles(pixeles),
	//			.vgaclk(vgaclk),
	//			.hsync(hsync), 
	//			.vsync(vsync),
	//			.sync_b(sync_b), 
	//			.blank_b(blank_b),
	//			.readAddress(nextDir),
	//			.r(r), 
	//			.g(g), 
	//			.b(b)
	//			);
	