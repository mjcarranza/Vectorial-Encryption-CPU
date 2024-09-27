
`timescale 1ns / 1ps
module ID_EXE_Reg_tb;

    // Definición de señales
    logic clk;
    logic reset;
    logic stop;
    logic regWrite_in, memWrite_in, jump_in, branch_in, resultSrc_in, updateCount_in;
    logic [15:0] op01_in, op11_in, op21_in, op31_in, op1;
    logic [15:0] op02_in, op12_in, op22_in, op32_in, op2;
    logic [3:0] rd_in;
    logic [3:0] aluControl_in;

    logic [15:0] op01_out, op11_out, op21_out, op31_out, op1_out;
    logic [15:0] op02_out, op12_out, op22_out, op32_out, op2_out;
    logic [3:0] rd_out;
    logic regWrite_out, memWrite_out, branch_out, resultSrc_out, updateCount_out;
    logic [3:0] aluControl_out;

    // Instanciar el módulo que queremos testear
    ID_EXE_Reg uut (
        .clk(clk),
        .reset(reset),
        .stop(stop),
        .regWrite_in(regWrite_in),
        .memWrite_in(memWrite_in),
        .jump_in(jump_in),
        .branch_in(branch_in),
        .resultSrc_in(resultSrc_in),
        .updateCount_in(updateCount_in),
        .op01_in(op01_in),
        .op11_in(op11_in),
        .op21_in(op21_in),
        .op31_in(op31_in),
        .op1(op1),
        .op02_in(op02_in),
        .op12_in(op12_in),
        .op22_in(op22_in),
        .op32_in(op32_in),
        .op2(op2),
        .rd_in(rd_in),
        .aluControl_in(aluControl_in),

        .op01_out(op01_out),
        .op11_out(op11_out),
        .op21_out(op21_out),
        .op31_out(op31_out),
        .op1_out(op1_out),
        .op02_out(op02_out),
        .op12_out(op12_out),
        .op22_out(op22_out),
        .op32_out(op32_out),
        .op2_out(op2_out),
        .rd_out(rd_out),
        .regWrite_out(regWrite_out),
        .memWrite_out(memWrite_out),
        .branch_out(branch_out),
        .resultSrc_out(resultSrc_out),
        .updateCount_out(updateCount_out),
        .aluControl_out(aluControl_out)
    );

    // Generador de reloj
    always #5 clk = ~clk;

    // Procedimiento de prueba
    initial begin
        // Inicializamos señales
        clk = 0;
        reset = 0;
        stop = 0;
        regWrite_in = 0;
        memWrite_in = 0;
        jump_in = 0;
        branch_in = 0;
        resultSrc_in = 0;
        updateCount_in = 0;
        op01_in = 16'h0000;
        op02_in = 16'h0000;
        op11_in = 16'h0000;
        op12_in = 16'h0000;
        op21_in = 16'h0000;
        op22_in = 16'h0000;
        op31_in = 16'h0000;
        op32_in = 16'h0000;
        op1 = 16'h0000;
        op2 = 16'h0000;
        rd_in = 4'b0000;
        aluControl_in = 4'b0000;

        // Caso 1: Aplicamos reset
        reset = 1;
        #10;
        reset = 0;
        #10;

        // Caso 2: Probar entradas sin detener (stop = 0)
        op01_in = 16'hAAAA;
        op02_in = 16'hBBBB;
        op11_in = 16'hCCCC;
        op12_in = 16'hDDDD;
        op21_in = 16'hEEEE;
        op22_in = 16'hFFFF;
        op31_in = 16'h1111;
        op32_in = 16'h2222;
        op1 = 16'h3333;
        op2 = 16'h4444;
        rd_in = 4'b1010;
        aluControl_in = 4'b1100;
        regWrite_in = 1;
        memWrite_in = 1;
        branch_in = 1;
        resultSrc_in = 1;
        updateCount_in = 1;

        #10;

        // Caso 3: Detener actualización con stop = 1
        stop = 1;
        op01_in = 16'h5555;
        op02_in = 16'h6666;
        #10;
        stop = 0;

        // Verificar que los valores no cambien cuando stop está activo
        #10;


    end

endmodule
