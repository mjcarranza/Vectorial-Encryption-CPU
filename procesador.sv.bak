module procesador(input logic clkFPGA, rst,
			output logic vgaclk, // 25.175 MHz VGA clock
			output logic hsync, vsync,
			output logic sync_b, blank_b, // To monitor & DAC
			output logic [7:0] r, g, b);

	logic [15:0] pc, pc_out, Inst, PCPlus4F, PCPlus4, PCTargetE;
	logic [15:0] pcDeco, pcP4, instDeco;
	logic PCSrcE, MemtoReg, MemWrite, RegWrite, cout, negative, zero, ALUSrc;
	logic [1:0] ImmSrc, RegSrc, ALUControl;
	logic [3:0] RA1, RA2;

	logic clk, clk_mem, clk_rom;
	
	// mod frecuencia para memoria
	//new_clk #(.frec(1)) frec_mem (clk_mem, clkFPGA);
	new_clk #(.frec(2)) frec_rom (clk_rom, clkFPGA);
	new_clk #(.frec(16)) frec_clk (clk, clkFPGA);

	// mux PC
	mux2_1 muxPC(.data0(PCPlus4F),
                .data1(PCTargetE),
                .select(PCSrcE),
                .result(pc)
                );
	
	// registro PC
	program_counter pc_inst(.clk(clk), .rst(rst), .d(pc), .q(pc_out));
	
	// sumar pc+4
	sumador sum_inst(.A(pc_out), .B(16'h4), .C(PCPlus4));

	// instancia de memoria de instrucciones
	IMem IMem_inst(.address(pc_out[7:0]), .clock(clk_rom), .q(Inst));
	
	IF_ID_Reg fetch(.clk(clkFPGA), 
						.reset(rst), 
						.pc_in(pc_out), 
						.pc_plus4_in(PCPlus4), 
						.instruction_in(Inst), 
						.pc_out(pcDeco), 
						.pc_plus4_out(pcP4), 
						.instruction_out(instDeco));

endmodule 