module Control_Unit(
	input [3:0] operation, 									// 4 Bits para el codigo de operacion
	output regWrite, memWrite, branch, resultSrc, 	// banderas de 1 bit 
	output [3:0] aluControl  								// bandera de 3 bits
	);
	
	logic [1:0] resSrc;				// cambiar dependiendo de la cantidad de entradas del mux 
	logic [3:0] Control;
	logic rWrite, mWrite, b;  	
	
	// AGREGAR LAS BANDERAS NECESARIAS /-------------------------------------------------------------------------------------/
	
	always @(*)
	
		case (operation)
			 
			 4'b0001: begin // acciones para SET COUNTER a 10 o 9 (SETC)
					rWrite = 1;			// habilita bandera para escribir en registro
					resSrc = 0;  		// guarda en registro el result de la alu				// cambiar al que corresponda en WriteBack
					mWrite = 0;			// no escribe en memoria
					b = 0;				// no hay branch
					Control = 4'b0001;// numero de operacion para la alu
			 end
			 4'b0010: begin // acciones para DECREASE COUNTER (DEC)
					rWrite = 1;			// habilita bandera para escribir en registro
					resSrc = 0;		  	// guarda en registro el result de la alu 			// cambiar al que corresponda en WriteBack
					mWrite = 0;			// no escribe en memoria
					b = 0;				// no hay branch
					Control = 4'b0010;// numero de operacion para la alu
			 end
			 4'b0011: begin // acciones para BRANCH IF COUNTER IS NOT ZERO (BNZ)
					rWrite = 1;			// habilita bandera para escribir en registro		
					resSrc = 0;  		// guarda en registro el result de la alu				// cambiar al que corresponda en WriteBack
					mWrite = 0;			// no escribe en memoria
					b = 0;				// no hay branch
					Control = 4'b0011;// numero de operacion para la alu
			 end
			 4'b0100: begin // acciones para MATRIX SET (MATSET)
					rWrite = 1;			// habilita bandera para escribir en registro
					resSrc = 0;  		// guarda en registro el result de la alu				// cambiar al que corresponda en WriteBack
					mWrite = 0;			// no escribe en memoria
					b = 0;				// no hay branch
					Control = 4'b0100;// numero de operacion para la alu
			 end

			 4'b0101: begin // acciones para MATRIX XOR (MATXOR)
					rWrite = 1;			// habilita bandera para escribir en registro
					resSrc = 1;  		// guarda en registro el result de la memoria		// cambiar al que corresponda en WriteBack
					mWrite = 0;			// no escribe en memoria
					b = 0;				// no hay branch
					Control = 4'b0101;// numero de operacion para la alu
			 end
			 4'b0110: begin // acciones para COLUMN UP ROTATION S-BOX REPLACEMENT
					rWrite = 0;			// habilita bandera para escribir en registro
					resSrc = 1;  		// guarda en registro el result de la memoria		// cambiar al que corresponda en WriteBack
					mWrite = 1;			// no escribe en memoria
					b = 0;				// no hay branch
					Control = 4'b0110;// numero de operacion para la alu
			 end
			 4'b0111: begin // acciones para XOR FIRST AND LAST COLUMN
					rWrite = 0;			// habilita bandera para escribir en registro
					resSrc = 1;  		// guarda en registro el result de la memoria		// cambiar al que corresponda en WriteBack
					mWrite = 0;			// no escribe en memoria
					b = 1;				// no hay branch
					Control = 4'b0111;// numero de operacion para la alu
			 end
			 4'b1000: begin // acciones para XOR GET NEW COLUMN OF KEY
					rWrite = 0;			// habilita bandera para escribir en registro
					resSrc = 1; 		// guarda en registro el result de la memoria		// cambiar al que corresponda en WriteBack
					mWrite = 0;			// no escribe en memoria
					b = 1;				// hay branch
					Control = 4'b1000;// numero de operacion para la alu
			 end
			 4'b1001: begin // acciones para MATRIX LOGICAL SHIFT LEFT
					rWrite = 0;			// habilita bandera para escribir en registro
					resSrc = 0;  		// guarda en registro el result de la memoria		// cambiar al que corresponda en WriteBack
					mWrite = 0;			// no escribe en memoria
					b = 0;				// no hay branch
					Control = 4'b1001;// numero de operacion para la alu
			 end
			 4'b1010: begin // acciones para MATRIX DIRECT SUB BYTES
					rWrite = 0;			// habilita bandera para escribir en registro
					resSrc = 0;  		// guarda en registro el result de la memoria		// cambiar al que corresponda en WriteBack
					mWrite = 0;			// no escribe en memoria
					b = 0;				// no hay branch
					Control = 4'b1010;// numero de operacion para la alu
			 end
			 4'b1011: begin // acciones para MATRIX DIRECT SHIFT ROWS
					rWrite = 0;			// habilita bandera para escribir en registro
					resSrc = 0;  		// guarda en registro el result de la memoria		// cambiar al que corresponda en WriteBack
					mWrite = 0;			// no escribe en memoria
					b = 0;				// no hay branch
					Control = 4'b1011;// numero de operacion para la alu
			 end
			 4'b1100: begin // acciones para MATRIX DIRECT MIX COLUMNS
					rWrite = 0;			// habilita bandera para escribir en registro
					resSrc = 0;  		// guarda en registro el result de la memoria		// cambiar al que corresponda en WriteBack
					mWrite = 0;			// no escribe en memoria
					b = 0;				// no hay branch
					Control = 4'b1100;// numero de operacion para la alu
			 end
			 
			 default: begin // acciones para END PROGRAM
					rWrite = 0;			// no habilita bandera para escribir en registro
					mWrite = 0;			// no escribe en memoria
					b = 0;				// no hay branch
					Control = 4'b0000;// numero de operacion para la alu
					resSrc = 0;  		// guarda en registro el result de la memoria (no se escribe debido a rWrite=0)
			 end
		endcase
		
	assign regWrite = rWrite;
	assign memWrite = mWrite;
	assign branch = b;
	assign aluControl = Control;
	assign resultSrc = resSrc;
	
endmodule 