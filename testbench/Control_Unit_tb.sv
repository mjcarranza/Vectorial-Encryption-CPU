`timescale 1ns / 1ps

module Control_Unit_tb;

    // Inputs
    reg [3:0] operation;
    reg imm;

    // Outputs
    wire regWrite;
    wire memWrite;
    wire jump;
    wire branch;
    wire aluSrc;
    wire [1:0] resultSrc;
    wire [2:0] aluControl;

    // Instancia del módulo Control_Unit
    Control_Unit uut (
        .operation(operation),
        .imm(imm),
        .regWrite(regWrite),
        .memWrite(memWrite),
        .jump(jump),
        .branch(branch),
        .aluSrc(aluSrc),
        .resultSrc(resultSrc),
        .aluControl(aluControl)
    );

    // Procedimiento inicial para simular
    initial begin
        // Inicializa las entradas
        operation = 0;
        imm = 0;

        // Procedimiento de prueba
        // Se aplican varios códigos de operación para ver la respuesta del módulo
        #10; operation = 4'b0000; // ADD
        #10; operation = 4'b0001; // SUB
        #10; operation = 4'b0010; // AND
        #10; operation = 4'b0011; // ORR
        #10; operation = 4'b0100; // LSL
        #10; operation = 4'b0101; imm = 1; // CMP con inmediato
        #10; operation = 4'b0101; imm = 0; // CMP sin inmediato
        #10; operation = 4'b0110; imm = 1; // SET con inmediato
        #10; operation = 4'b0110; imm = 0; // SET sin inmediato
        #10; operation = 4'b0111; // LDR
        #10; operation = 4'b1000; // STR
        #10; operation = 4'b1001; // B
        #10; operation = 4'b1010; // BEQ
        #10; operation = 4'b1011; // BGE
        #10; operation = 4'b1111; // Acción por defecto (NOT)
    end

    // Monitorizar cambios en las salidas para ver los resultados de las operaciones
    initial begin
        $monitor("Time = %t | Operation = %b | imm = %b | regWrite = %b | memWrite = %b | jump = %b | branch = %b | aluSrc = %b | resultSrc = %b | aluControl = %b",
                 $time, operation, imm, regWrite, memWrite, jump, branch, aluSrc, resultSrc, aluControl);
    end

endmodule
