`timescale 1ns / 1ps

module shiftLPC_tb;

    // Inputs
    logic [11:0] pc;

    // Outputs
    logic [15:0] realPC;

    // Instancia del módulo shiftLPC
    shiftLPC uut (
        .pc(pc),
        .realPC(realPC)
    );

    // Procedimiento inicial
    initial begin
        // Inicialización
        pc = 12'h123;
        
        // Espera para estabilizar
        #10;

        // Test 1: Valor aleatorio
        pc = 12'hABC;
        #10;

        // Test 2: Valor cero
        pc = 12'h000;
        #10;

        // Test 3: Valor máximo
        pc = 12'hFFF;
        #10;


    end


endmodule
