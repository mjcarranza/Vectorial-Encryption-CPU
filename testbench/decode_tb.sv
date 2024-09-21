module decode_tb;

    // Señales para el testbench
    logic clk, rst, regWriteWB;
    logic [15:0] inst, resultWB;
    logic [3:0] RdestW0, RdestW1, RdestW2, RdestW3;
    logic [15:0] RD01E, RD02E, RD11E, RD12E, RD21E, RD22E, RD31E, RD32E;
    logic [3:0] RdE;
    logic regWriteE, memWriteE, branchE;
    logic [2:0] aluControlE;
    logic resultSrcE;

    // Instanciar el DUT (Device Under Test)
    decode uut (
        .clk(clk), 
        .rst(rst), 
        .regWriteWB(regWriteWB),
        .inst(inst), 
        .resultWB(resultWB),
        .RdestW0(RdestW0), 
        .RdestW1(RdestW1), 
        .RdestW2(RdestW2), 
        .RdestW3(RdestW3),
        .RD01E(RD01E), 
        .RD02E(RD02E), 
        .RD11E(RD11E), 
        .RD12E(RD12E), 
        .RD21E(RD21E), 
        .RD22E(RD22E), 
        .RD31E(RD31E), 
        .RD32E(RD32E),
        .RdE(RdE),
        .regWriteE(regWriteE), 
        .memWriteE(memWriteE), 
        .branchE(branchE),
        .aluControlE(aluControlE),
        .resultSrcE(resultSrcE)
    );

    // Generar la señal de reloj
    always #5 clk = ~clk;

    // Procedimiento de inicialización
    initial begin
        // Inicializar señales
        clk = 0;
        rst = 1;
        regWriteWB = 0;
        inst = 16'h0000;
        resultWB = 16'h0000; 
        RdestW0 = 4'h0;
        RdestW1 = 4'h0;
        RdestW2 = 4'h0;
        RdestW3 = 4'h0;

        // Esperar para salir del reset
        #10 rst = 0;

        // Escribir valores en los registros de destino
		  regWriteWB = 1;
		  inst = 16'h1000;      // Instrucción para seleccionar registros A1 y A2
		  #5;
        resultWB = 16'h1234;  // Valor para escribir en registro
        RdestW0 = 4'h1;       // Escribir en regFile_0
		  RdestW1 = 4'h1;       // Escribir en regFile_0
		  RdestW2 = 4'h1;       // Escribir en regFile_0
		  RdestW3 = 4'h1;       // Escribir en regFile_0
		  
		  #5 regWriteWB = 0;
		  inst = 16'h1001; // Instrucción para leer registros de regFile_0
        $display("RD01E = %h, Esperado: 0000", RD01E);
        $display("RD02E = %h, Esperado: 1234", RD02E); // A2 no fue modificado
		  
		  $display("RD11E = %h, Esperado: 0000", RD11E);
        $display("RD12E = %h, Esperado: 1234", RD12E);
		  
		  $display("RD21E = %h, Esperado: 0000", RD21E);
        $display("RD22E = %h, Esperado: 1234", RD22E);
		  
		  $display("RD31E = %h, Esperado: 0000", RD31E);
        $display("RD32E = %h, Esperado: 1234", RD32E);
		  
		  #10;

        // Escribir valores en los registros de destino
		  regWriteWB = 1;
		  inst = 16'h1000;      // Instrucción para seleccionar registros A1 y A2
		  #5;
        resultWB = 16'h5678;  // Valor para escribir en registro
        RdestW0 = 4'h1;       // Escribir en regFile_0
		  RdestW1 = 4'h1;       // Escribir en regFile_0
		  RdestW2 = 4'h1;       // Escribir en regFile_0
		  RdestW3 = 4'h1;       // Escribir en regFile_0
		  
		  #5 regWriteWB = 0;
		  inst = 16'h1001; // Instrucción para leer registros de regFile_0
        $display("RD01E = %h, Esperado: 0000", RD01E);
        $display("RD02E = %h, Esperado: 1234", RD02E); // A2 no fue modificado
		  
		  $display("RD11E = %h, Esperado: 0000", RD11E);
        $display("RD12E = %h, Esperado: 1234", RD12E);
		  
		  $display("RD21E = %h, Esperado: 0000", RD21E);
        $display("RD22E = %h, Esperado: 1234", RD22E);
		  
		  $display("RD31E = %h, Esperado: 0000", RD31E);
        $display("RD32E = %h, Esperado: 1234", RD32E);
		  
		  #10;

        // Escribir valores en los registros de destino
		  regWriteWB = 1;
		  inst = 16'h1000;      // Instrucción para seleccionar registros A1 y A2
		  #5;
        resultWB = 16'h9abc;  // Valor para escribir en registro
        RdestW0 = 4'h1;       // Escribir en regFile_0
		  RdestW1 = 4'h1;       // Escribir en regFile_0
		  RdestW2 = 4'h1;       // Escribir en regFile_0
		  RdestW3 = 4'h1;       // Escribir en regFile_0
		  
		  #5 regWriteWB = 0;
		  inst = 16'h1001; // Instrucción para leer registros de regFile_0
        $display("RD01E = %h, Esperado: 0000", RD01E);
        $display("RD02E = %h, Esperado: 1234", RD02E); // A2 no fue modificado
		  
		  $display("RD11E = %h, Esperado: 0000", RD11E);
        $display("RD12E = %h, Esperado: 1234", RD12E);
		  
		  $display("RD21E = %h, Esperado: 0000", RD21E);
        $display("RD22E = %h, Esperado: 1234", RD22E);
		  
		  $display("RD31E = %h, Esperado: 0000", RD31E);
        $display("RD32E = %h, Esperado: 1234", RD32E);



    end

endmodule
