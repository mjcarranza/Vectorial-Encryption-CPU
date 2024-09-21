`timescale 1ns / 1ps

module fetch_tb;

    // Entradas para el módulo fetch
    logic clk;
    logic rst;
    logic PCSrcE, stop;
    logic [11:0] branchPC;

    // Salidas del módulo fetch
    logic [11:0] InstrD, pcsuma;

    // Instancia del módulo fetch
    fetch uut (
        .clk(clk), 
		  .rst(rst), 
		  .PCSrcE(PCSrcE), // senal para el mux
		  .stop(stop),			// detiene el pipe
		  .jumpPC(branchPC), // direccion de pc para branch
		  .InstrD(InstrD),		// instruccion correspondiente al pc seleccionado
		  .pcsuma(pcsuma)
    );

    // Generador de reloj
    always #5 clk = ~clk; // Reloj con periodo de 10ns

    // Procedimiento de inicialización y prueba
    initial begin
			// Inicialización de señales
			clk = 1;
			rst = 1;  // Iniciar en reset
			stop = 0;
			PCSrcE = 0;
			branchPC = 12'h000;

			// Desactivar reset y aplicar señales de prueba
			#20 rst = 0;

			#10 
				stop = 0;
				PCSrcE = 0; // Volver a seleccionar PCPlus2F
				branchPC = 12'h003;

			#10 
				stop = 1;
				PCSrcE = 1; // Cambiar nuevamente a PCTargetE
				branchPC = 12'h00F;
				
			#10 
				stop = 1;
				PCSrcE = 0; // Cambiar nuevamente a PCTargetE
            branchPC = 12'h002; 
			
			#10 
				stop = 1;
				PCSrcE = 0; // Cambiar nuevamente a PCTargetE
            branchPC = 12'h001; 
				
			#10 
				stop = 0;
				PCSrcE = 0; // Cambiar nuevamente a PCTargetE
            branchPC = 12'h003;
			
			#10 
				stop = 0;
				PCSrcE = 0; // Cambiar nuevamente a PCTargetE
            branchPC = 12'h044;
				
			#10 
				stop = 0;
				PCSrcE = 0; // Cambiar nuevamente a PCTargetE
            branchPC = 12'h006;
				
			#10
				stop = 0;
				PCSrcE = 0; // Cambiar nuevamente a PCTargetE
            branchPC = 12'h007;

    end

endmodule
