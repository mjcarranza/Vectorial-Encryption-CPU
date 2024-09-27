module Columnmaker_tb;
	
	logic [7:0] DataA;
	logic [7:0] DataB;
	logic [7:0] DataC;
	logic [7:0] DataD;
   logic [31:0] Column;
	
	Columnmaker Columnmaker_test(DataA,DataB,DataC,DataD,Column);
	 

// Estímulos
initial begin
    
    DataA = 8'hAA;  
    DataB = 8'hBB;  
    DataC = 8'hCC; 
    DataD = 8'hDD; 
    #10;
	 
	 DataA = 8'h67;  
    DataB = 8'hB5;  
    DataC = 8'h4A; 
    DataD = 8'h10; 
      
	 
end

endmodule