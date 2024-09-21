module compuerta (
    input zeroE, jumpE, branchE, negative,
    output reg pcSrcE
);
	logic resAND1, resAND2, resAND3, resOR1;
	

    always @* begin
        // AND gate 1
        resAND1 = !zeroE && !negative;
		  
		  // And gate 2
		  resAND2 = zeroE && !negative;
		  
		  // or gate 1
		  resOR1 = resAND1 || resAND2;
		  
		  // And gate 3
		  resAND3 = resOR1 && branchE;
        
        // OR gate
        pcSrcE = jumpE || resAND3;
    end

endmodule
