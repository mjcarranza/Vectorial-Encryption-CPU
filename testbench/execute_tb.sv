`timescale 1ns / 1ps

module execute_tb;

    // Definición de constantes
    localparam CLK_PERIOD = 10; // Periodo del reloj en ns
    
    // Señales de entrada
    logic clk, rst, regWriteE, memWriteE, jumpE, branchE, aluSrcE;
    logic [1:0] resultSrcE;
    logic [3:0] aluControlE;
    logic [15:0] RD1E, RD2E, PCPlus2E, PCE, extendedE;
    logic [3:0] RdE;
    
    // Señales de salida
    logic regWriteM, memWriteM, PCSrcE;
    logic [1:0] resultSrcM; 
    logic [15:0] PCPlus2M, aluResM, writeDataM;
    logic [3:0] RdM;
    
    // Instancia del módulo execute
    execute execute_inst(
        .clk(clk),
        .rst(rst),
        .regWriteE(regWriteE),
        .memWriteE(memWriteE),
        .jumpE(jumpE),
        .branchE(branchE),
        .aluSrcE(aluSrcE),
        .resultSrcE(resultSrcE),
        .aluControlE(aluControlE),
        .RD1E(RD1E),
        .RD2E(RD2E),
        .PCPlus2E(PCPlus2E),
        .PCE(PCE),
        .extendedE(extendedE),
        .RdE(RdE),
        .regWriteM(regWriteM),
        .memWriteM(memWriteM),
        .PCSrcE(PCSrcE),
        .resultSrcM(resultSrcM),
        .PCPlus2M(PCPlus2M),
        .aluResM(aluResM),
        .writeDataM(writeDataM),
        .RdM(RdM)
    );
    
    // Generación de clock
    always #CLK_PERIOD clk = ~clk;
    
    // Inicialización de señales
    initial begin
        clk = 0;
        rst = 0; // Activa el reset inicialmente
        regWriteE = 0;
        memWriteE = 0;
        jumpE = 0;
        branchE = 0;
        aluSrcE = 1;
        resultSrcE = 0;
        aluControlE = 0;
        RD1E = 16'h0000;
        RD2E = 16'h0000;
        PCPlus2E = 16'h0000;
        PCE = 16'h0000;
        extendedE = 16'h0001;
        RdE = 4'b0000;
        
        // Espera un poco después de aplicar el reset
        #20;
        
        // Desactiva el reset
        rst = 0;
        
        // Simula una secuencia de operaciones
        
        // Operación 1
        RD1E = 16'h0000;
        RD2E = 16'h0001; //registro de ubicación de pixeles (PU)
        PCPlus2E = 16'h0002;
        RdE = 4'b1100;
        aluControlE = 4'b0110; // Suma
        aluSrcE = 0; // RD2E
        regWriteE = 1;
        memWriteE = 0;
        jumpE = 0;
        branchE = 0;
        
        
    end
    
endmodule
