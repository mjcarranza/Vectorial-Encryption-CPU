module alu(
	input [15:0] A, B,
	input [3:0] sel,
	output [15:0] alu_out,
	output zero, negative
	);
	
	reg [15:0] alu_out_temp;
	logic zeroTemp, negTemp;
	
	
	always @(*)
	
		case (sel)
		
			// caso de la suma
			4'b0000: begin 
				alu_out_temp = A + B; 
				zeroTemp = 1'b0;
				negTemp = 1'b0;
			end
			
			// caso de la resta
			4'b0001: begin 
				alu_out_temp = A - B;
				zeroTemp = 1'b0;
				negTemp = 1'b0;
			end
			
			// caso de AND
			4'b0010: begin
				alu_out_temp = A & B;
				zeroTemp = 1'b0;
				negTemp = 1'b0;
			end

			//caso de OR
			4'b0011: begin
				alu_out_temp = A | B;
				zeroTemp = 1'b0;
				negTemp = 1'b0;
			end
				
			//caso de LSL
			4'b0100: begin 
				alu_out_temp = A << B;
				zeroTemp = 1'b0;
				negTemp = 1'b0;
			end

			//caso de CMP
			4'b0101: begin 
				alu_out_temp = A - B;
				if (alu_out_temp == 0) begin // para branch equal
					zeroTemp = 1'b1;			// set bandera de cero
					negTemp = 1'b0;
				end 
				else if (alu_out_temp < 0) begin // no se toma el branch
					negTemp = 1'b1;
					zeroTemp = 1'b0;
				end
				else if (alu_out_temp > 0) begin // se toma el branch mayor o igual
					negTemp = 1'b0;
					zeroTemp = 1'b0;
				end
				else begin // en casode que no se toma branch
					negTemp = 1'b1; 
					zeroTemp = 1'b1;
				end
			end

			//caso de SET
			4'b0110: begin 
				alu_out_temp = A;  // el resultado es solo A
				zeroTemp = 1'b0;
				negTemp = 1'b0;
			end

			//caso de LDR
			4'b0111: begin 
				alu_out_temp = A; // solo se toma el valor del registro Rm
				zeroTemp = 1'b0;
				negTemp = 1'b0;
			end

			// caso de STR
			4'b1000: begin 
				alu_out_temp = A;
				zeroTemp = 1'b0;
				negTemp = 1'b0;
			end

			// caso de Branch
			4'b1001: begin
				alu_out_temp = 16'b0;
				zeroTemp = 1'b0;
				negTemp = 1'b0;
			end

			// caso de BEQ
			4'b1010: begin	
				alu_out_temp = 16'b0;
				zeroTemp = 1'b0;
				negTemp = 1'b0;
			end

			// caso de BGE
			4'b1011: begin 
				alu_out_temp = 16'b0;
				zeroTemp = 1'b0;
				negTemp = 1'b0;
			end
			
			// caso de stall
			4'b1100: begin 
				alu_out_temp = 16'b0;
				zeroTemp = 1'b0;
				negTemp = 1'b0;
			end
			
			//end
			default: begin 
				alu_out_temp = 16'b0;
				zeroTemp = 1'b0;
				negTemp = 1'b0;
			end
		
		endcase 
		

		
	// resultado de la alu
	assign alu_out = alu_out_temp;
	
	// banderas
	assign zero = zeroTemp;			// bandera de cero (Z)
	assign negative = negTemp;	// bandera de negativo (N)
	
endmodule 