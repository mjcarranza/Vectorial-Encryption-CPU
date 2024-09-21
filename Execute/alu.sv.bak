module alu(
	input [31:0] A, B,
	input [1:0] sel,
	output [31:0] alu_out,
	output zero, negative, carry
	);
	
	reg [31:0] alu_out_temp;
	wire [8:0] tmp;
	
	
	
	always @(*)
	
		case (sel)
		
			// caso de la suma
			2'b00: alu_out_temp = A + B; 
			
			// caso de la resta
			2'b01: alu_out_temp = A - B;
			
			// caso de copiar el B
			2'b10: alu_out_temp = B;
			
			default: alu_out_temp = A + B; 
		
		endcase 
		
	compare #(.width(32)) dut_compare(A, B, sel[0], negative);
		
	// resultado de la alu
	assign alu_out = alu_out_temp;
	
	// banderas
	assign zero = (alu_out_temp == 31'd0);	// bandera de cero (Z)
	
	assign carry = 1'b0;
	
endmodule 