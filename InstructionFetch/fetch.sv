module fetch(

			input logic clk, rst, PCSrcE, stop,
			input logic [11:0] jumpPC,
			output logic [11:0] InstrD, pcsuma//, PCPlus2D
	);
			
	logic [11:0] pc, pc_out, Inst, PCD, nextPC;
	
	// mux PC
	mux2_1 muxPC(.data0(nextPC),
                .data1(jumpPC),
                .select(PCSrcE),
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
						.instruction_out(InstrD));
	assign pcsuma = pc_out;
endmodule 