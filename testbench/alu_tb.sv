module alu_tb;
	
	// Señales de entrada
	logic [1:0] index;
   logic [3:0] ALUcontrol;
	logic	[31:0] SrcA, SrcB, SrcC;
	logic [7:0] lastData;
	logic [1:0] column;
   // Señales de salida
   logic [31:0] ALUresult;
	
	ALU ALU_test(index,ALUcontrol,SrcA,SrcB,SrcC,column,lastData,ALUresult);
	 

// Estímulos
initial begin
    // Test 1: Suma (ALUcontrol = 00)
    ALUcontrol = 4'b0000;
    SrcA = 8;
    SrcB = 5;
    #10;

    // Test 2: Resta (ALUcontrol = 01)
    ALUcontrol = 4'b0011;
    SrcA = 10;
    SrcB = 3;
	 SrcC = 32'h25423513;
    #10;
	 
    // Test 3: Multiplicación (ALUcontrol = 10)
    ALUcontrol = 4'b0010;
    SrcA = 32'h6649d86c;
    SrcB = 4;
    #10;
	  
	 // Test 3: Multiplicación (ALUcontrol = 10)
    ALUcontrol = 4'b0001;
    SrcA = 32'h1bc492bb;
    SrcB = 4;
	 index = 3;
	 
	 #10;
	 
	 // Test 3: Multiplicación (ALUcontrol = 10)
    ALUcontrol = 4'b0100;
    SrcA = 32'h1bc492bb;
	 lastData = 8'h7c; 
	 
end

endmodule