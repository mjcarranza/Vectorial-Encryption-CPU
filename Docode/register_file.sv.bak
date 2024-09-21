
module register_file(input logic clk, rst, WE3, 
							input logic [3:0] A1, A2, A3, 
							input logic [31:0] WD3, R15,
							output logic [31:0] RD1, RD2);
							
	logic [31:0] registers [15:0];
	logic [31:0] RD1_temp = 32'h0;
	logic [31:0] RD2_temp = 32'h0;
	
	
	// escritura se supone que es el posedge
	always_ff @(negedge clk or posedge rst) begin
	
		if (rst) begin
			// Reset behavior
			registers[0] <= 32'd0;
			registers[1] <= 32'd1;
			registers[2] <= 32'd2;
			registers[3] <= 32'h00000;
			registers[4] <= 32'h00000;
			registers[5] <= 32'd5;
			registers[6] <= 32'd6;
			registers[7] <= 32'd7;
			registers[8] <= 32'd8;
			registers[9] <= 32'd9;
			registers[10] <= 32'd0;
			registers[11] <= 32'd0;
			registers[12] <= 32'd0;
			registers[13] <= 32'd0;
			registers[14] <= 32'd0;
			registers[15] <= 32'd0;
		end 
		else begin
		
			if (WE3) begin
			
				registers[A3] <= WD3;
			
			end
			
			registers[15] <= R15;
			
		end
	
	end
	
	// lectura se supone que es negedge
	//always_ff @(posedge clk or posedge rst) begin
	always_ff @(*) begin
	
		if (rst) begin
		 // Reset behavior
			RD1_temp <= 32'h0;
			RD2_temp <= 32'h0;
			
		end 
		
		else begin
			RD1_temp <= registers[A1];
			RD2_temp <= registers[A2];
		end
	
	end
	
	assign RD1 = RD1_temp;
	assign RD2 = RD2_temp;

endmodule