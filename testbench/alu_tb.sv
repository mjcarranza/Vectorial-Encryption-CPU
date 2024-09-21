`timescale 1ns / 1ps

module alu_tb;

    // Definición de constantes
    localparam CLK_PERIOD = 10; // Periodo del reloj en ns
    
    // Señales de entrada
    logic [15:0] A, B;
    logic [3:0] sel;
    
    // Señales de salida
    logic [15:0] alu_out;
    logic zero, negative;
    
    // Instancia del módulo alu
    alu alu_inst(
        .A(A),
        .B(B),
        .sel(sel), 
        .alu_out(alu_out),
        .zero(zero), 
        .negative(negative) 
    );
    
    // Generación de clock
    always #CLK_PERIOD sel = sel + 1;
    
    // Inicialización de señales
    initial begin
        A = 16'h0000;
        B = 16'h0000;
        sel = 4'b0000;
        
        // Espera un poco
        #10;
        
        // Prueba de suma
        A = 16'h0005;
        B = 16'h000A;
        sel = 4'b0000; // Suma
        #20;
        
        // Prueba de resta
        A = 16'h000A;
        B = 16'h0005;
        sel = 4'b0001; // Resta
        #20;
        
        // Prueba de AND
        A = 16'hFFFF;
        B = 16'h00FF;
        sel = 4'b0010; // AND
        #20;
        
        // Prueba de OR
        A = 16'h00FF;
        B = 16'hF0F0;
        sel = 4'b0011; // OR
        #20;
        
        // Prueba de desplazamiento lógico a la izquierda
        A = 16'h0003;
        B = 4'b0001;
        sel = 4'b0100; // LSL
        #20;
        
        // Prueba de comparación
        A = 16'h000F;
        B = 16'h000A;
        sel = 4'b0101; // CMP
        #20;
        
        // Prueba de SET
        A = 16'h1234;
        B = 16'h5678;
        sel = 4'b0110; // SET
        #20;
        
        // Prueba de LDR
        A = 16'hABCDE;
        B = 16'h0000;
        sel = 4'b0111; // LDR
        #20;
        
        // Prueba de STR
        A = 16'hAAAA;
        B = 16'h0000;
        sel = 4'b1000; // STR
        #20;
        
        // Prueba de Branch
        A = 16'h0000;
        B = 16'h0000;
        sel = 4'b1001; // Branch
        #20;
        
        // Prueba de BEQ
        A = 16'h0000;
        B = 16'h0000;
        sel = 4'b1010; // BEQ
        #20;
        
        // Prueba de BGE
        A = 16'h0000;
        B = 16'h0000;
        sel = 4'b1011; // BGE
        #20;
        
        // Prueba de stall
        A = 16'h0000;
        B = 16'h0000;
        sel = 4'b1100; // stall
        #20;
    end
    
endmodule
