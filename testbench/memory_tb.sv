`timescale 1ns / 1ps

module memory_tb;

    // Inputs to the memory module
    logic clk, rst, regWriteM, memWriteM;
    logic [15:0] aluResM, writeDataM, PCPlus2M;
    logic [3:0] RdM;
    logic [1:0] resultSrcM;

    // Outputs from the memory module
    logic [15:0] PCPlus2W, aluResW, readDataW, writeDataW;
    logic [3:0] RdW;
    logic regWriteW;
    logic [1:0] resultSrcW;

    // Instance of the memory module
    memory uut (
        .clk(clk), .rst(rst),
        .regWriteM(regWriteM), .memWriteM(memWriteM),
        .aluResM(aluResM), .writeDataM(writeDataM), .PCPlus2M(PCPlus2M),
        .RdM(RdM), .resultSrcM(resultSrcM),
        .PCPlus2W(PCPlus2W), .aluResW(aluResW), .readDataW(readDataW), .writeDataW(writeDataW),
        .RdW(RdW), .regWriteW(regWriteW), .resultSrcW(resultSrcW)
    );

    // Clock generation
    always #5 clk = ~clk; // 10ns clock period

    // Initial block for testing
    initial begin
        // Initialize inputs
        clk = 0;
        rst = 1;
        regWriteM = 0;
        memWriteM = 0;			 // habilitar escritura
        aluResM = 16'h0001;    // resultado de la alu
        writeDataM = 16'h0000; // dato a escribir en memoria
        PCPlus2M = 16'h0000;
        RdM = 4'h1100;
        resultSrcM = 2'b01;

        // Release reset
        #10 rst = 0;
        #10 regWriteM = 1;
            memWriteM = 1;
            aluResM = 16'h0001; // Example address
            writeDataM = 16'h0000; // Data to write
            RdM = 4'h1100;
            resultSrcM = 2'b01;

        // Change conditions
        #20 writeDataM = 16'h5678; // datos a escribir
            aluResM = 16'h0000; // escriba en posicion 0
            PCPlus2M = 16'h0004;
            resultSrcM = 2'b01;
				
			// Change conditions
        #20 writeDataM = 16'h5008; // datos a escribir
            aluResM = 16'h0001; // escriba en posicion 1
            PCPlus2M = 16'h0004;
            resultSrcM = 2'b01;
				
			// Change conditions
        #20 memWriteM = 0;
				writeDataM = 16'h0000; // datos a escribir
            aluResM = 16'h0000; // verificar escritura en posicion 0000
            PCPlus2M = 16'h0004;
            resultSrcM = 2'b01;
				
			// Change conditions
        #20 writeDataM = 16'h5678; // datos a escribir
            aluResM = 16'h0001; // verificar escritura en posicion 0001
            PCPlus2M = 16'h0004;
            resultSrcM = 2'b01;
    end

endmodule
