module PackingUnit_tb;
	
	// Señales de entrada
	logic [31:0] ALUresult0, ALUresult1;
   logic MCMode; // Bandera para seleccionar modo MixColumns
	// Señales de salida
	logic [15:0] halfRow0,halfRow1,halfRow2,halfRow3;
   //logic [127:0] PackedResult;
   
	PackingUnit PackingUnit_test(ALUresult0,ALUresult1,MCMode,halfRow0,halfRow1,halfRow2,halfRow3);
	 

// Estímulos
initial begin
    
    ALUresult0 = 32'h01020304;
	 ALUresult1 = 32'h05060708;
    MCMode = 1;
    #10;
    ALUresult0 = 32'h01020304;
	 ALUresult1 = 32'h05060708;
    MCMode = 0;
	 #10;
    ALUresult0 = 32'h0105090d;
	 ALUresult1 = 32'h02060a0e;
    MCMode = 1;
end

endmodule