module procesador(
			input logic clk, rst, //updateCount// zeroFlag, //regWriteWB,
			//input logic [15:0] resCount, res0, res1, res2, res3, // entrada individual
			//input logic [3:0] RdestW, // entrada general
			
			//output logic [11:0] pcsuma,
			
			// salidas del cicle decode
			//output logic [31:0] RD01E, RD02E, RD11E, RD12E, RD21E, RD22E, RD31E, RD32E, dataOp1, dataOp2,
			//output logic [15:0]instruction,
			//output logic [3:0] RdE, RdM,
			//output logic memWriteE, updateCnt //regWriteE
			output logic [128:0] salida
			);

	logic [15:0] pc, pc_out, Inst, inst, PCD, nextPC, hr0, hr1, hr2, hr3, hr4, hr5, hr6, hr7;
	logic [15:0] extended,ext, dataDeco01, dataDeco02, dataDeco11, dataDeco12, dataDeco21, dataDeco22, dataDeco31, dataDeco32, dataCont1, dataCont2;
	logic regWriteD, RWrite, memWriteD, MWrite, jumpD, jump, branchD, branch, aluSrcD, aluSrc, a1Source, source, selPC, stop, update, selectDeco, selExe, selection;
	logic [2:0] aluControlD, aluCtrl, aluControlE;
	logic [3:0] a1Data, a2Data;
	logic [1:0] col;
	logic [31:0] SrcC0, SrcC1, SrcC2, SrcC3, ALUresult0, ALUresult1, ALUresult2, ALUresult3, ALUresult0E, ALUresult1E, ALUresult2E, ALUresult3E, result0, result1, result2, result3;
	logic [128:0] srcBE, aluResE;
	logic [31:0] RD01E, RD02E, RD11E, RD12E, RD21E, RD22E, RD31E, RD32E, dataOp1, dataOp2;
	//logic [15:0] resCount, res0, res1, res2, res3;	
	
	

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
	
	IF_ID_Reg fetch(
					.clk(clk), 
					.reset(rst), 
					.stop(stop),
					.instruction_in(Inst), 
					.instruction_out(inst)
	);
						
	assign pcsuma = pc_out;
	assign instruction = inst;
	
	
	// ------------------------------------- ciclo decode --------------------------------------------------- //
	
	// unidad de hazard
	hazardUnit hazard(
					.clk(clk),
					.reset(rst),
					.zeroFlag(zeroFlag),         	// Bandera de cero de la ALU que compara el contador
					.OpCode(inst[12:8]), 	// Código de operación de la instrucción actual
					.stopSignal(stop),  // Señal para detener el pipeline (ENTRA EN TODOS LOS REGISTROS, EXECPTO EL PC)
					.selectPCMux(selPC) 		// senal de seleccion del pc a utilizar
	);
	
	// instancia de register file 0
	register_file regFile_0(
					.clk(clk), 
					.rst(rst), 
					.regWrite(regWriteM), 
					.A1(inst[5:4]), 
					.A2(inst[3:2]), 
					.A3(RdM), 
					.WD3(result0),	
					.RD1(dataDeco01), 
					.RD2(dataDeco02)
	); 
	// instancia de register file
	register_file regFile_1(
					.clk(clk), 
					.rst(rst), 
					.regWrite(regWriteM), 
					.A1(inst[5:4]), 
					.A2(inst[3:2]), 
					.A3(RdM), 
					.WD3(result1),	
					.RD1(dataDeco11), 
					.RD2(dataDeco12)
	);
									
	// instancia de register file
	register_file regFile_2(
					.clk(clk), 
					.rst(rst), 
					.regWrite(regWriteM), 
					.A1(inst[5:4]), 
					.A2(inst[3:2]), 
					.A3(RdM), 
					.WD3(result2),	
					.RD1(dataDeco21), 
					.RD2(dataDeco22)
	);
									
	// instancia de register file
	register_file regFile_3(
					.clk(clk), 
					.rst(rst), 
					.regWrite(regWriteM), 
					.A1(inst[5:4]), 
					.A2(inst[3:2]), 
					.A3(RdM), 
					.WD3(result3),	
					.RD1(dataDeco31), 
					.RD2(dataDeco32)
	);	
										
	reg_Count reg_Count(
					.clk(clk), 
					.rst(rst), 
					.regWrite(updateC), 			// siempre se escribe el valor del contador
					.A1(4'h0), 			// registro donde se guarda el numero a comparar para salir del loop (reg 0)
					.A2(4'h1), 			// registro donde se guarda el contador a comparar con 0 (reg 1)
					.A3(4'b0001), 				// registro 1 siempre
					.WD3(compResOut),			// resultado de la alu del contador
					.RD1(dataCont1),
					.RD2(dataCont2)
	);
									
	// instancia para la unidad de control
	Control_Unit control_inst( 
					.operation(inst[12:8]),
					.col_input(inst[1:0]),
					.regWrite(regWriteD), 
					.memWrite(memWriteD),
					.updateCount(update),
					.aluControl(aluControlD),
					.column(col),
					.selectWB(selectDeco)
	);

	
	// instancia para el registro decode/execute
	ID_EXE_Reg decode(
					.clk(clk),
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
					.updateCount_in(update),
					.rd_in(inst[7:6]),
					.regWrite_in(regWriteD), .memWrite_in(memWriteD),
					.aluControl_in(aluControlD),
					.select_in(selectDeco),
					.column_in(col),

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
					.updateCount_out(updateCnt),
					.regWrite_out(regWriteE), .memWrite_out(memWriteE), 
					.aluControl_out(aluControlE),
					.select_out(selExe),
					.column_out(colexe)
	);
	
	
	// ------------------------------------- Etapa de ejecucion ---------------------------------------------- //
	
	compareExec(
		.A(dataOp1),
		.B(dataOp2),
		.C(resCmp),
		.zero(zeroFlag)  // Bandera para indicar si el resultado es cero
	);
	
	///
	Columnmaker Columnmaker_test0(
					.DataA(RD01E[31:24]), 	// primer elemento de la primera fila
					.DataB(RD11E[31:24]),   	// primer elemento de la segunda fila
					.DataC(RD21E[31:24]),		// primer elemento de la tercera fila
					.DataD(RD31E[31:24]),		// primer elemento de la cuarta fila
					.Column(SrcC0)				// COLUMNA de 32 bits
					);
					
	Columnmaker Columnmaker_test1(
					.DataA(RD01E[23:16]), 	// segundo elemento de la primera fila
					.DataB(RD11E[31:24]),   	// segundo elemento de la segunda fila
					.DataC(RD21E[23:16]),		// segundo elemento de la tercera fila
					.DataD(RD31E[23:16]),		// segundo elemento de la cuarta fila
					.Column(SrcC1)				// COLUMNA de 32 bits
					);
					
	Columnmaker Columnmaker_test2(
					.DataA(RD01E[15:8]), 		// tercer elemento de la primera fila
					.DataB(RD11E[15:8]),   	// tercer elemento de la segunda fila
					.DataC(RD21E[15:8]),		// tercer elemento de la tercera fila
					.DataD(RD31E[15:8]),		// tercer elemento de la cuarta fila
					.Column(SrcC2)				// COLUMNA de 32 bits
					);
					
	Columnmaker Columnmaker_test3(
					.DataA(RD01E[7:0]), 		// cuarto elemento de la primera fila
					.DataB(RD11E[7:0]),   	// cuarto elemento de la segunda fila
					.DataC(RD21E[7:0]),		// cuarto elemento de la tercera fila
					.DataD(RD31E[7:0]),		// cuarto elemento de la cuarta fila
					.Column(SrcC3)				// COLUMNA de 32 bits
					);
	
	
	
	// instancia alu
	ALU ALU_p0( .index(2'b00),
					.counter(dataOp2), 			// mismo en todas
					.ALUcontrol(aluControlE), 	// cambiarlo a 5 bits
					.SrcA(RD01E), 					// entrada 1 desde los registros
					.SrcB(RD02E),					// entrada 2 desde los registros
					.SrcC(SrcC0),					// columna resultantte dell columnmaker
					.column(colexe),					// se;al desde el contol unit					////////// esto es igual para todos
					.lastData(RD11E[7:0]),		// recibe ultimo elem de fil siguiente (sig reg)
					.ALUresult(ALUresult0E)
	);
	
	
	ALU ALU_p1( .index(2'b01),
					.counter(dataOp2), // mismo en todas
					.ALUcontrol(aluControlE), // cambiarlo a 5 bits
					.SrcA(RD11E), 		// estos debe ser de 32 bits
					.SrcB(RD12E),
					.SrcC(SrcC1),		// columna resultantte dell columnmaker
					.column(colexe),		// columna ultimos 2 bits de la instrucci[on siempre
					.lastData(RD21E[7:0]),	
					.ALUresult(ALUresult1E) 	//resultado es una fila
	);
	
	ALU ALU_p2( .index(2'b10),
					.counter(dataOp2), // mismo en todas
					.ALUcontrol(aluControlE), // cambiarlo a 5 bits //// mismo en todos
					.SrcA(RD21E), 		// estos debe ser de 32 bits
					.SrcB(RD22E),
					.SrcC(SrcC2),		// columna resultantte dell columnmaker
					.column(colexe),		// columna ultimos 2 bits de la instrucci[on siempre
					.lastData(RD31E[7:0]),	
					.ALUresult(ALUresult2E) 	//resultado es una fila
	);
	
	
	ALU ALU_p3( .index(2'b11),
					.counter(dataOp2), // mismo en todas
					.ALUcontrol(aluControlE), // cambiarlo a 5 bits
					.SrcA(RD31E), 		// estos debe ser de 32 bits
					.SrcB(RD32E),
					.SrcC(SrcC3),		// columna resultantte dell columnmaker
					.column(colexe),		// columna ultimos 2 bits de la instrucci[on siempre
					.lastData(RD01E[7:0]),	
					.ALUresult(ALUresult3E) 	//resultado es una fila
	);
	
	
	EXE_MEM_Reg EMReg_inst(
					.clk(clk),  
					.reset(rst), 
					.stop(stop),

					//ENTRADAS
					.regWrite_in(regWriteE), 
					.memWrite_in(memWriteE),
					.rd_in(RdE),     			// Registro destino
					.resCompare(resCmp),
					.aluRes0(ALUresult0E), 
					.aluRes1(ALUresult1E), 
					.aluRes2(ALUresult2E), 
					.aluRes3(ALUresult3E),
					.select_in(selExe),
					.updateCnt_in(updateCnt),

					//SALIDAS
					.regWrite_out(regWriteM),
					.memWrite_out(memWriteM),
					.rd_out(RdM), 
					.resCompare_out(compResOut),
					.aluRes0_out(ALUresult0), 
					.aluRes1_out(ALUresult1), 
					.aluRes2_out(ALUresult2), 
					.aluRes3_out(ALUresult3),
					.select_out(selection),			// agregar bandera a mux
					.updateCnt_out(updateC)
 
	);
	
	
	
	
	
	// ------------------------------------- Etapa de memoria y Write Back------------------------------------ //
		
	combineUnit combUnit(
					.Src0(ALUresult0),			// primera salida del registro
					.Src1(ALUresult1),			// segunda salida del registro
					.Src2(ALUresult2),			// tercera salida del registro
					.Src3(ALUresult3),			// cuarta salida del registro
					.ALUresult(aluResE)	// entrada a la memoria
	);
	
	//instancia para la memoria de datos
	MemData memoriaDatos(
					.address_a(4'h0),		// suponemos que solo se guarda la matriz resultante en memoria
					//address_b(),
					.clock(clk),
					.data_a(aluResE),
					.wren_a(memWriteM),
					.q_a(salida)
	);

	
	// instancias para crear columnas del resultado
	PackingUnit pack1(
				 .ALUresult0(ALUresult0), 
				 .ALUresult1(ALUresult1),
				 .halfRow0(hr0),
				 .halfRow1(hr1),
				 .halfRow2(hr2),
				 .halfRow3(hr3)
	);
	
	PackingUnit pack2(
				 .ALUresult0(ALUresult2), 
				 .ALUresult1(ALUresult3),
				 .halfRow0(hr4),
				 .halfRow1(hr5),
				 .halfRow2(hr6),
				 .halfRow3(hr7)
	);
	
	// instancias para enviar resultados a los registros
	Combine16to32(
				.in0(hr0), 
				.in1(hr4),   // Entradas de 16 bits
				.out(write0)        // Salida de 32 bits
	);
	Combine16to32(
				.in0(hr1), 
				.in1(hr5),   // Entradas de 16 bits
				.out(write1)        // Salida de 32 bits
	);
	Combine16to32(
				.in0(hr2), 
				.in1(hr6),   // Entradas de 16 bits
				.out(write2)        // Salida de 32 bits
	);
	Combine16to32(
				.in0(hr3), 
				.in1(hr7),   // Entradas de 16 bits
				.out(write3)        // Salida de 32 bits
	);

	
	// instancias para mux 2-1  
	mux_WB muxRes0(
					.data0(ALUresult0),
					.data1(write0),
					.select(selection),
					.result(result0)	// poner este resultado en las entradas de los registros
	);
	
	mux_WB muxRes1(
					.data0(ALUresult1),
					.data1(write1),
					.select(selection),
					.result(result1)
	);
	
	mux_WB muxRes2(
					.data0(ALUresult2),
					.data1(write2),
					.select(selection),
					.result(result2)
	);
	
	mux_WB muxRes3(
					.data0(ALUresult3),
					.data1(write3),
					.select(selection),
					.result(result3)
	);
	
			
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
	