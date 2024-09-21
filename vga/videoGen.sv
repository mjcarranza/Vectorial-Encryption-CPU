module videoGen(
	input logic clk, rst,
	input logic [9:0] x, y,
	input logic [7:0] pixeles,  // 8 bits por pixel
	output logic [7:0] r = 0, g = 0, b = 0
);
	
	always_ff @(posedge clk or posedge rst) begin
		if (rst == 1) begin
			{r, g, b} <= {8'h00, 8'h00, 8'h00};
		end else begin
			if (x >= 250 || y >= 250) begin
				{r, g, b} <= {8'h00, 8'h00, 8'h00};
			end else begin
				if(pixeles == 0) {r, g, b} <= {8'hFF, 8'hFF, 8'hFF}; // pinta de blanco
				else {r, g, b} <= {8'h00, 8'h00, 8'h00}; // pinta de negro
			end
		end
	end
endmodule