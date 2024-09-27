
module register_file(input logic clk, rst, regWrite, 	
							input logic [3:0] A1, A2, A3, 	
							input logic [31:0] WD3,				// dato a escribir
							output logic [31:0] RD1, RD2);	
		// # bits         // # registros			
	logic [31:0] registers [15:0];
	logic [31:0] RD1_temp = 16'h0;
	logic [31:0] RD2_temp = 16'h0;
	
	
	// escritura se hace en flanco positivo
	always_ff @(posedge clk or posedge rst) begin
	
		if (rst) begin
			// Reset behavior
			registers[0]  <= 32'd0;
			registers[1]  <= 32'd0;
			registers[2]  <= 32'd0;
			registers[3]  <= 32'd0;
			registers[4]  <= 32'd0;
			registers[5]  <= 32'd0;
			registers[6]  <= 32'd0;
			registers[7]  <= 32'd0;
			registers[8]  <= 32'd0;
			registers[9]  <= 32'd0;
			registers[10] <= 32'd0;
			registers[11] <= 32'd0;
			registers[12] <= 32'd0; //  
			registers[13] <= 32'd0; // registro de ubicación de pixeles (PU)
			registers[14] <= 32'd0; // registro para la memoria (SP)
			registers[15] <= 32'd0; //registro para el contador del programa (PC)
		end 
		else begin
		
			if (regWrite) begin // si esta la senal para escribir
				registers[A3] <= WD3; // se escribe el contenido de WD3 en el valor A3
			end
			
		end
	
	end
	
	// lectura se hace en flanco negativo
	always_ff @(negedge clk or posedge rst) begin
	//always_ff @(*) begin
	
		if (rst) begin
		 // Reset behavior
			RD1_temp <= 16'h0;
			RD2_temp <= 16'h0;
			
		end 
		
		else begin
			RD1_temp <= registers[A1];
			RD2_temp <= registers[A2];
		end
	
	end
	
	assign RD1 = RD1_temp;
	assign RD2 = RD2_temp;

endmodule