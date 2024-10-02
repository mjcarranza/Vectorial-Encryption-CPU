module EXE_MEM_Reg_tb;

  // Señales de prueba
  logic clk, reset, stop;
  logic regWrite_in, updateCnt_in, memWrite_in, select_in;
  logic [3:0] rd_in, resCompare;
  logic [31:0] aluRes0, aluRes1, aluRes2, aluRes3;
  
  // Señales de salida del DUT (Device Under Test)
  logic regWrite_out, memWrite_out, updateCnt_out, select_out;
  logic [3:0] rd_out, resCompare_out;
  logic [31:0] aluRes0_out, aluRes1_out, aluRes2_out, aluRes3_out;

  // Instancia del módulo a probar
  EXE_MEM_Reg dut(
    .clk(clk), 
    .reset(reset), 
    .stop(stop), 
    .regWrite_in(regWrite_in), 
    .updateCnt_in(updateCnt_in), 
    .memWrite_in(memWrite_in), 
    .select_in(select_in), 
    .rd_in(rd_in), 
    .resCompare(resCompare), 
    .aluRes0(aluRes0), 
    .aluRes1(aluRes1), 
    .aluRes2(aluRes2), 
    .aluRes3(aluRes3), 
    .regWrite_out(regWrite_out), 
    .memWrite_out(memWrite_out), 
    .updateCnt_out(updateCnt_out), 
    .select_out(select_out), 
    .rd_out(rd_out), 
    .resCompare_out(resCompare_out), 
    .aluRes0_out(aluRes0_out), 
    .aluRes1_out(aluRes1_out), 
    .aluRes2_out(aluRes2_out), 
    .aluRes3_out(aluRes3_out)
  );

  // Generación del reloj
  always #5 clk = ~clk;

  // Procedimiento de prueba
  initial begin
    // Inicialización de señales
    clk = 0;
    reset = 0;
    stop = 0;
    regWrite_in = 0;
    updateCnt_in = 0;
    memWrite_in = 0;
    select_in = 0;
    rd_in = 4'b0000;
    resCompare = 4'b0000;
    aluRes0 = 32'b0;
    aluRes1 = 32'b0;
    aluRes2 = 32'b0;
    aluRes3 = 32'b0;

    // Aplicar reset
    reset = 1;
    #10;
    reset = 0;

    // Test 1: Aplicar entradas y verificar salidas
    regWrite_in = 1;
    updateCnt_in = 1;
    memWrite_in = 1;
    select_in = 1;
    rd_in = 4'b1010;
    resCompare = 4'b1100;
    aluRes0 = 32'hAAAA_BBBB;
    aluRes1 = 32'hCCCC_DDDD;
    aluRes2 = 32'hEEEE_FFFF;
    aluRes3 = 32'h1111_2222;
    #10;

    // Verificar que las salidas sigan los valores de entrada
    assert(regWrite_out == 1) else $error("Test 1 Failed: regWrite_out incorrect");
    assert(memWrite_out == 1) else $error("Test 1 Failed: memWrite_out incorrect");
    assert(select_out == 1) else $error("Test 1 Failed: select_out incorrect");
    assert(rd_out == 4'b1010) else $error("Test 1 Failed: rd_out incorrect");
    assert(resCompare_out == 4'b1100) else $error("Test 1 Failed: resCompare_out incorrect");
    assert(aluRes0_out == 32'hAAAA_BBBB) else $error("Test 1 Failed: aluRes0_out incorrect");
    assert(aluRes1_out == 32'hCCCC_DDDD) else $error("Test 1 Failed: aluRes1_out incorrect");
    assert(aluRes2_out == 32'hEEEE_FFFF) else $error("Test 1 Failed: aluRes2_out incorrect");
    assert(aluRes3_out == 32'h1111_2222) else $error("Test 1 Failed: aluRes3_out incorrect");

    // Test 2: Resetear el módulo y verificar que las salidas se limpian
    reset = 1;
    #10;
    reset = 0;
    #10;

    // Verificar que las salidas están en 0
    assert(regWrite_out == 0) else $error("Test 2 Failed: regWrite_out not reset");
    assert(memWrite_out == 0) else $error("Test 2 Failed: memWrite_out not reset");
    assert(select_out == 0) else $error("Test 2 Failed: select_out not reset");
    assert(rd_out == 4'b0000) else $error("Test 2 Failed: rd_out not reset");
    assert(resCompare_out == 4'b0000) else $error("Test 2 Failed: resCompare_out not reset");
    assert(aluRes0_out == 32'b0) else $error("Test 2 Failed: aluRes0_out not reset");
    assert(aluRes1_out == 32'b0) else $error("Test 2 Failed: aluRes1_out not reset");
    assert(aluRes2_out == 32'b0) else $error("Test 2 Failed: aluRes2_out not reset");
    assert(aluRes3_out == 32'b0) else $error("Test 2 Failed: aluRes3_out not reset");

    $display("All tests passed!");
    $finish;
  end

endmodule
