`timescale 1ns/1ps

module procesador_tb();

  // Señales de entrada
  logic clk, rst, regWriteWB, updateCount, zeroFlag;
  logic [15:0] resCount, res0, res1, res2, res3;
  logic [3:0] RdestW;

  // Señales de salida
  logic [11:0] pcsuma;
  logic [15:0] RD01E, RD02E, RD11E, RD12E, RD21E, RD22E, RD31E, RD32E, dataOp1, dataOp2, instruction;
  logic [3:0] RdE;
  logic regWriteE, memWriteE, updateCnt;
  logic [2:0] aluControlE;

  // Instancia del módulo a probar
  procesador uut (
    .clk(clk),
    .rst(rst),
    .regWriteWB(regWriteWB),
    .updateCount(updateCount),
    .zeroFlag(zeroFlag),
    .resCount(resCount),
    .res0(res0),
    .res1(res1),
    .res2(res2),
    .res3(res3),
    .RdestW(RdestW),
    .pcsuma(pcsuma),
    .RD01E(RD01E),
    .RD02E(RD02E),
    .RD11E(RD11E),
    .RD12E(RD12E),
    .RD21E(RD21E),
    .RD22E(RD22E),
    .RD31E(RD31E),
    .RD32E(RD32E),
    .dataOp1(dataOp1),
    .dataOp2(dataOp2),
    .RdE(RdE),
	 .instruction(instruction),
    .regWriteE(regWriteE),
    .memWriteE(memWriteE),
    .updateCnt(updateCnt),
    .aluControlE(aluControlE)
  );

  // Generar señal de reloj
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // Período de 10 unidades de tiempo
  end

  // Inicialización y estímulos
  initial begin
    // Inicialización de señales
    rst = 1;
    regWriteWB = 0;
    updateCount = 0;
    zeroFlag = 0;
    resCount = 16'h0000;
    res0 = 16'h0000;
    res1 = 16'h0000;
    res2 = 16'h0000;
    res3 = 16'h0000;
    RdestW = 4'b0000;

    // Reset del sistema
    #20 rst = 0;

    // Estímulos de prueba
    // Simulación de una instrucción y actualización de registros
    #10 regWriteWB = 1;
        res0 = 16'h1234;
        res1 = 16'h5678;
        res2 = 16'h9ABC;
        res3 = 16'hDEF0;
        RdestW = 4'b0010; // Registro de destino

    #10 regWriteWB = 0;

    // Prueba de actualización del contador
    #20 updateCount = 1;
        resCount = 16'h000A; // Valor del contador

    #10 updateCount = 0;
	 
	 #20 zeroFlag = 1;
	 #20 zeroFlag = 0;

  end

endmodule
