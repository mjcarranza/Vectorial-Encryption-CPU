

module ID_EXE_Reg_tb;
    // Entradas del módulo
    logic clk;
    logic reset;
    logic [15:0] pc_in;
    logic [15:0] pc_plus2_in;
    logic [15:0] op1_in;
    logic [15:0] op2_in;
    logic [3:0] rd_in;
    logic [15:0] extend_in;

    // Salidas del módulo
    logic [15:0] pc_out;
    logic [15:0] pc_plus2_out;
    logic [15:0] op1_out;
    logic [15:0] op2_out;
    logic [3:0] rd_out;
    logic [15:0] extend_out;

    // Instancia del módulo a probar
    ID_EXE_Reg dut (
        .clk(clk),
        .reset(reset),
        .pc_in(pc_in),
        .pc_plus2_in(pc_plus2_in),
        .op1_in(op1_in),
        .op2_in(op2_in),
        .rd_in(rd_in),
        .extend_in(extend_in),
        .pc_out(pc_out),
        .pc_plus2_out(pc_plus2_out),
        .op1_out(op1_out),
        .op2_out(op2_out),
        .rd_out(rd_out),
        .extend_out(extend_out)
    );

    // Generador de reloj
    always #5 clk = ~clk;  // Periodo de reloj de 10 ns

    // Procedimiento de inicialización y test
    initial begin
        // Inicialización de las señales
        clk = 0;
        reset = 0;
        pc_in = 16'd0;
        pc_plus2_in = 16'd2;
        op1_in = 16'd100;
        op2_in = 16'd200;
        rd_in = 4'd10;
        extend_in = 16'd300;

        // Aplicar reset
        //#10;
        //reset = 0;

        // Primer conjunto de entradas
        #10;
        pc_in = 16'd1;
        pc_plus2_in = 16'd3;
        op1_in = 16'd101;
        op2_in = 16'd201;
        rd_in = 4'd11;
        extend_in = 16'd301;

        // Segundo conjunto de entradas
        #20;
        pc_in = 16'd4;
        pc_plus2_in = 32'd6;
        op1_in = 16'd102;
        op2_in = 16'd202;
        rd_in = 4'd12;
        extend_in = 16'd302;

        // Re-activar el reset
        #10 reset = 1;
        #10 reset = 0;

        // Continuar con más tests si es necesario
        #30;
    end

endmodule
