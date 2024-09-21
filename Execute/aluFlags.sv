
module aluFlags(input logic clk, rst, n, z,
					output logic nOut, zOut);

always_ff @(posedge clk)
	if (rst == 1) begin
		nOut <= 0;
		zOut <= 0;
	end
	else begin 
		nOut <= n;
		zOut <= z;
	end

endmodule