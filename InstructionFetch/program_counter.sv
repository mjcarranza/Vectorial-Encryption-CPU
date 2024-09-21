
module program_counter(input logic clk, rst,
							  input logic [11:0] d,
							  output logic [11:0] q);

always_ff @(posedge clk) // siempre en flanco positivo 
	if (rst == 1) begin
		q <= 0;
	end
	else begin 
		q <= d;
	end

endmodule