module hazardUnit_tb;
    // Señales de prueba
    logic clk;
    logic reset;
    logic zeroFlag;
    logic [3:0] OpCode;
    
    // Salidas de la unidad Hazard
    logic stopSignal;
    logic selectPCMux;

    // Instancia de la unidad Hazard
    hazardUnit uut (
        .clk(clk),
        .reset(reset),
        .zeroFlag(zeroFlag),
        .OpCode(OpCode),
        .stopSignal(stopSignal),
        .selectPCMux(selectPCMux)
    );

    // Generador de reloj: alterna clk cada 5 unidades de tiempo
    always #5 clk = ~clk;

    // Procedimiento de prueba
    initial begin
        // Inicialización
        clk = 0;
        reset = 1;
        zeroFlag = 0;
        OpCode = 4'b0000;  // Instrucción sin branch
        #10;               // Esperar 10 unidades de tiempo
        reset = 0;

        // Escenario 1: No hay hazard, OpCode diferente a branch
        OpCode = 4'b0000;  // Código de operación que no es branch
        zeroFlag = 0;
        #20;

        // Escenario 2: Se detecta un hazard (branch con ceroFlag activo)
        OpCode = 4'b0011;  // Branch
        zeroFlag = 1;
        #10;

        // Mantener el hazard por varios ciclos
        #50;

        // Escenario 3: Hazard no detectado, se desactiva zeroFlag
        zeroFlag = 0;
        #20;

        // Escenario 4: Otro hazard, vuelve a activarse el branch
        zeroFlag = 1;
        #50;
    end
endmodule
