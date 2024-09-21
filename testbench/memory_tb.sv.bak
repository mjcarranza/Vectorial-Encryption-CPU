`timescale 1ns / 1ps

module memory_tb;

    // Inputs to the memory module
    logic clk, rst, regWriteM, memWriteM;
    logic [15:0] aluResM, writeDataM, PCPlus2M;
    logic [3:0] RdM;
    logic [1:0] resultSrcM;

    // Outputs from the memory module
    logic [15:0] PCPlus2W, aluResW, readDataW;
    logic [3:0] RdW;
    logic regWriteW;
    logic [1:0] resultSrcW;

    // Instance of the memory module
    memory uut (
        .clk(clk), .rst(rst),
        .regWriteM(regWriteM), .memWriteM(memWriteM),
        .aluResM(aluResM), .writeDataM(writeDataM), .PCPlus2M(PCPlus2M),
        .RdM(RdM), .resultSrcM(resultSrcM),
        .PCPlus2W(PCPlus2W), .aluResW(aluResW), .readDataW(readDataW),
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
        memWriteM = 0;
        aluResM = 16'h0000;
        writeDataM = 16'h0000;
        PCPlus2M = 16'h0002;
        RdM = 4'h0;
        resultSrcM = 2'b00;

        // Release reset
        #10 rst = 0;
        #10 regWriteM = 1;
            memWriteM = 1;
            aluResM = 16'h1000; // Example address
            writeDataM = 16'h1234; // Data to write
            RdM = 4'h3;
            resultSrcM = 2'b01;

        // Change conditions
        #20 writeDataM = 16'h5678; // Update data
            aluResM = 16'h2000; // New address
            PCPlus2M = 16'h0004;
            resultSrcM = 2'b10;
    end

endmodule
