module Control_Unit(
	input [3:0] operation, // 4 Bits para el codigo de operacion
	input imm,
	output regWrite, memWrite, branch, resultSrc, // banderas de 1 bit 
	output [3:0] aluControl  // bandera de 3 bits
	);
	
	logic [1:0] resSrc;
	logic [3:0] Control;
	logic rWrite, mWrite, b;  	
	
	
	always @(*)
	
		case (operation)
		
			 4'b0000: begin // acciones para ADD
					rWrite = 1;			// habilita bandera para escribir en registro
					resSrc = 0;  		// guarda en registro el result de la alu
					mWrite = 0;			// no escribe en memoria
					b = 0;			// no hay branch
					Control = 4'b0000;// numero de operacion para la alu
			 end
			 
			 4'b0001: begin // acciones para SUB
					rWrite = 1;			// habilita bandera para escribir en registro
					resSrc = 0;  		// guarda en registro el result de la alu
					mWrite = 0;			// no escribe en memoria
					b = 0;			// no hay branch
					Control = 4'b0001;// numero de operacion para la alu
			 end
			 4'b0010: begin // acciones para AND
					rWrite = 1;			// habilita bandera para escribir en registro
					resSrc = 0;		  	// guarda en registro el result de la alu
					mWrite = 0;			// no escribe en memoria
					b = 0;			// no hay branch
					Control = 4'b010;// numero de operacion para la alu
			 end
			 4'b0011: begin // acciones para ORR
					rWrite = 1;			// habilita bandera para escribir en registro
					resSrc = 0;  		// guarda en registro el result de la alu
					mWrite = 0;			// no escribe en memoria
					b = 0;			// no hay branch
					Control = 4'b011;// numero de operacion para la alu
			 end
			 4'b0100: begin // acciones para LSL
					rWrite = 1;			// habilita bandera para escribir en registro
					resSrc = 0;  		// guarda en registro el result de la alu
					mWrite = 0;			// no escribe en memoria
					b = 0;			// no hay branch
					Control = 4'b100;// numero de operacion para la alu
			 end
			 4'b0101: begin // acciones para CMP  // VERIFICAR BANDERAS DE CERO DE LA ALU
				  if (imm) begin // si tengo un inmediato // 1=si 0=no
						rWrite = 0;			// habilita bandera para escribir en registro // CHECK ------
						resSrc = 0;  		// guarda en registro el result de la alu
						mWrite = 0;			// no escribe en memoria
						b = 0;			// no hay branch
						Control = 4'b101;// numero de operacion para la alu // SUMAR CERO EN ALU
				  end
				  else begin
						rWrite = 0;			// habilita bandera para escribir en registro // CHECK ------ 
						resSrc = 0;  		// guarda en registro el result de la alu
						mWrite = 0;			// no escribe en memoria
						b = 0;			// no hay branch
						Control = 4'b101;// numero de operacion para la alu // SUMAR CERO EN ALU
				  end
				  
			 end
			 4'b0110: begin // acciones para SET
				  if (imm) begin // si tengo un inmediato
						rWrite = 1;			// habilita bandera para escribir en registro  //////////  arreglar  //////////////
						resSrc = 1;  // guarda en registro el result de la alu
						mWrite = 0;			// no escribe en memoria
						b = 0;			// no hay branch
						Control = 4'b0110;// numero de operacion para la alu // SUMAR CERO EN ALU
				  end
				  else begin
						rWrite = 1;			// habilita bandera para escribir en registro
						resSrc = 0;  // guarda en registro el result de la alu
						mWrite = 0;			// no escribe en memoria
						b = 0;			// no hay branch
						Control = 4'b0110;// numero de operacion para la alu // SUMAR CERO EN ALU
				  end
			 end
			 4'b0111: begin // acciones para LDR
					rWrite = 1;			// habilita bandera para escribir en registro
					resSrc = 1;  		// guarda en registro el result de la memoria
					mWrite = 0;			// no escribe en memoria
					b = 0;			// no hay branch
					Control = 4'b0111;// numero de operacion para la alu
			 end
			 4'b1000: begin // acciones para STR
					rWrite = 0;			// habilita bandera para escribir en registro
					resSrc = 1;  		// guarda en registro el result de la memoria
					mWrite = 1;			// no escribe en memoria
					b = 0;				// no hay branch
					Control = 4'b1000;// numero de operacion para la alu
			 end
			 4'b1010: begin // acciones para BEQ
					rWrite = 0;			// habilita bandera para escribir en registro
					resSrc = 1;  		// guarda en registro el result de la memoria
					mWrite = 0;			// no escribe en memoria
					b = 1;				// no hay branch
					Control = 4'b1010;// numero de operacion para la alu
			 end
			 4'b1011: begin // acciones para BGE
					rWrite = 0;			// habilita bandera para escribir en registro
					resSrc = 1; 		// guarda en registro el result de la memoria
					mWrite = 0;			// no escribe en memoria
					b = 1;				// hay branch
					Control = 4'b1011;// numero de operacion para la alu
			 end
			 4'b1100: begin // acciones para NOT (stall)
					rWrite = 0;			// habilita bandera para escribir en registro
					resSrc = 0;  		// guarda en registro el result de la memoria
					mWrite = 0;			// no escribe en memoria
					b = 0;				// no hay branch
					Control = 4'b0000;// numero de operacion para la alu
			 end
			 
			 default: begin // acciones para END
					rWrite = 0;			// habilita bandera para escribir en registro
					mWrite = 0;			// no escribe en memoria
					b = 0;				// no hay branch
					Control = 4'b0000;// numero de operacion para la alu
					resSrc = 0;  		// guarda en registro el result de la memoria
			 end
		endcase
		
	assign regWrite = rWrite;
	assign memWrite = mWrite;
	assign branch = b;
	assign aluControl = Control;
	assign resultSrc = resSrc;
	
endmodule 