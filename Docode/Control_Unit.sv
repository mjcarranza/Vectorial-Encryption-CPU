module Control_Unit(
	input [3:0] operation, 									// 4 Bits para el codigo de operacion
	input [1:0] col_input,
	output regWrite, memWrite, branch, updateCount, selectWB, 	// banderas de 1 bit
	output [1:0] column,				
	output [3:0] aluControl  								// bandera de 3 bits
	);
	
	logic [1:0] col;				// cambiar dependiendo de la cantidad de entradas del mux 
	logic [3:0] Control;
	logic rWrite, mWrite, b, counter, select;  	
	
	// AGREGAR LAS BANDERAS NECESARIAS /-------------------------------------------------------------------------------------/
	
	always @(*)
	
		case (operation)
			 
			 5'b00001: begin // acciones para SET COUNTER a 10 o 9 (SETC)
					rWrite = 0;			// habilita bandera para escribir en registro
					counter = 1;		// bandera para escribir el contador
					col = 2'b00;  		// guarda en registro el result de la alu				// cambiar al que corresponda en WriteBack
					mWrite = 0;			// no escribe en memoria
					b = 0;				// no hay branch
					Control = 5'b00001;// numero de operacion para la alu
					select = 0;			// seleccion de resultado para el writeBack
					
			 end
			 5'b00010: begin // acciones para DECREASE COUNTER (DEC)
					rWrite = 0;			// habilita bandera para escribir en registro
					counter = 0;
					col = 2'b00;		  	// guarda en registro el result de la alu 			// cambiar al que corresponda en WriteBack
					mWrite = 0;			// no escribe en memoria
					b = 1;				// no hay branch
					Control = 5'b00010;// numero de operacion para la alu
					select = 0;
			 end
			 5'b00011: begin // acciones para BRANCH IF COUNTER IS NOT ZERO (BNZ)
					rWrite = 1;			// habilita bandera para escribir en registro	
					counter = 0;		// bandera para decrementar el contador	
					col = 2'b00;  		// guarda en registro el result de la alu				// cambiar al que corresponda en WriteBack
					mWrite = 0;			// no escribe en memoria
					b = 0;				// no hay branch
					Control = 5'b00011;// numero de operacion para la alu
					select = 0;
			 end
			 5'b00100: begin // acciones para MATRIX SET (MATSET)
					rWrite = 1;			// habilita bandera para escribir en registro
					counter = 0;		// bandera para decrementar el contador
					col = 2'b00;  		// guarda en registro el result de la alu				// cambiar al que corresponda en WriteBack
					mWrite = 0;			// no escribe en memoria
					b = 0;				// no hay branch
					Control = 5'b00100;// numero de operacion para la alu
					select = 0;
			 end

			 5'b00101: begin // acciones para MATRIX XOR (MATXOR)
					rWrite = 1;			// habilita bandera para escribir en registro
					counter = 0;		// bandera para decrementar el contador
					col = 2'b00;  		// guarda en registro el result de la memoria		// cambiar al que corresponda en WriteBack
					mWrite = 0;			// no escribe en memoria
					b = 0;				// no hay branch
					Control = 5'b00101;// numero de operacion para la alu
					select = 0;
			 end
			 5'b00110: begin // acciones para COLUMN UP ROTATION S-BOX REPLACEMENT
					rWrite = 1;			// habilita bandera para escribir en registro
					counter = 0;		// bandera para decrementar el contador
					col = 2'b00;  		// guarda en registro el result de la memoria		// cambiar al que corresponda en WriteBack
					mWrite = 0;			// no escribe en memoria
					b = 0;				// no hay branch
					Control = 5'b00110;// numero de operacion para la alu
					select = 0;
			 end
			 5'b00111: begin // acciones para XOR FIRST AND LAST COLUMN
					rWrite = 1;			// habilita bandera para escribir en registro
					counter = 0;		// bandera para decrementar el contador
					col = 2'b00;  		// guarda en registro el result de la memoria		// cambiar al que corresponda en WriteBack
					mWrite = 0;			// no escribe en memoria
					b = 0;				// no hay branch
					Control = 5'b00111;// numero de operacion para la alu
					select = 0;
			 end
			 5'b01000: begin // acciones para XOR GET NEW COLUMN OF KEY
					rWrite = 1;			// habilita bandera para escribir en registro
					counter = 0;		// bandera para decrementar el contador
					col = col_input; 		// guarda en registro el result de la memoria		// cambiar al que corresponda en WriteBack
					mWrite = 0;			// no escribe en memoria
					b = 0;				// hay branch
					Control = 5'b01000;// numero de operacion para la alu
					select = 0;
			 end
			 5'b01001: begin // acciones para MATRIX LOGICAL SHIFT LEFT
					rWrite = 1;			// habilita bandera para escribir en registro
					counter = 0;		// bandera para decrementar el contador
					col = 2'b00;  		// guarda en registro el result de la memoria		// cambiar al que corresponda en WriteBack
					mWrite = 0;			// no escribe en memoria
					b = 0;				// no hay branch
					Control = 5'b01001;// numero de operacion para la alu
					select = 0;
			 end
			 5'b01010: begin // acciones para MATRIX DIRECT SUB BYTES
					rWrite = 1;			// habilita bandera para escribir en registro
					counter = 0;		// bandera para decrementar el contador
					col = 2'b00;  		// guarda en registro el result de la memoria		// cambiar al que corresponda en WriteBack
					mWrite = 0;			// no escribe en memoria
					b = 0;				// no hay branch
					Control = 5'b01010;// numero de operacion para la alu
					select = 0;
			 end
			 5'b01011: begin // acciones para MATRIX DIRECT SHIFT ROWS
					rWrite = 1;			// habilita bandera para escribir en registro
					counter = 0;		// bandera para decrementar el contador
					col = 2'b00;  		// guarda en registro el result de la memoria		// cambiar al que corresponda en WriteBack
					mWrite = 0;			// no escribe en memoria
					b = 0;				// no hay branch
					Control = 5'b01011;// numero de operacion para la alu
					select = 0;
			 end
			 5'b01100: begin // acciones para MATRIX DIRECT MIX COLUMNS
					rWrite = 1;			// habilita bandera para escribir en registro
					counter = 0;		// bandera para decrementar el contador
					col = 2'b00;  		// guarda en registro el result de la memoria		// cambiar al que corresponda en WriteBack
					mWrite = 0;			// no escribe en memoria
					b = 0;				// no hay branch
					Control = 5'b01100;// numero de operacion para la alu
					select = 0;
			 end
			 5'b01101: begin // acciones para MATRIX DIRECT MIX COLUMNS
					rWrite = 1;			// habilita bandera para escribir en registro
					counter = 0;		// bandera para decrementar el contador
					col = 2'b00;  		// guarda en registro el result de la memoria		// cambiar al que corresponda en WriteBack
					mWrite = 0;			// no escribe en memoria
					b = 0;				// no hay branch
					Control =5'b01101;// numero de operacion para la alu
					select = 0;
			 end
			 5'b01111: begin // acciones para MATRIX DIRECT MIX COLUMNS
					rWrite = 1;			// habilita bandera para escribir en registro
					counter = 0;		// bandera para decrementar el contador
					col = 2'b00;  		// guarda en registro el result de la memoria		// cambiar al que corresponda en WriteBack
					mWrite = 0;			// no escribe en memoria
					b = 0;				// no hay branch
					Control = 5'b01111;// numero de operacion para la alu
					select = 0;
			 end
			 5'b10000: begin // acciones para MATRIX DIRECT MIX COLUMNS
					rWrite = 1;			// habilita bandera para escribir en registro
					counter = 0;		// bandera para decrementar el contador
					col = 2'b00;  		// guarda en registro el result de la memoria		// cambiar al que corresponda en WriteBack
					mWrite = 0;			// no escribe en memoria
					b = 0;				// no hay branch
					Control = 4'b10000;// numero de operacion para la alu
					select = 0;
			 end
			 5'b10001: begin // acciones para MATRIX DIRECT MIX COLUMNS
					rWrite = 1;			// habilita bandera para escribir en registro
					counter = 0;		// bandera para decrementar el contador
					col = 2'b00;  		// guarda en registro el result de la memoria		// cambiar al que corresponda en WriteBack
					mWrite = 0;			// no escribe en memoria
					b = 0;				// no hay branch
					Control = 5'b10010;// numero de operacion para la alu
					select = 0;
			 end
			 5'b10010: begin // acciones para MATRIX DIRECT MIX COLUMNS
					rWrite = 1;			// habilita bandera para escribir en registro
					counter = 0;		// bandera para decrementar el contador
					col = 2'b00;  		// guarda en registro el result de la memoria		// cambiar al que corresponda en WriteBack
					mWrite = 0;			// no escribe en memoria
					b = 0;				// no hay branch
					Control = 5'b10010;// numero de operacion para la alu
					select = 0;
			 end
			 
			 default: begin // acciones para END PROGRAM
					rWrite = 0;			// no habilita bandera para escribir en registro
					counter = 0;		// bandera para decrementar el contador
					col = 2'b00;
					mWrite = 0;			// no escribe en memoria
					b = 0;				// no hay branch
					Control = 4'b0000;// numero de operacion para la alu
					select = 0;
			 end
		endcase
		
	assign regWrite = rWrite;
	assign updateCount = counter;
	assign memWrite = mWrite;
	assign branch = b;
	assign aluControl = Control;
	assign column = col_input;
	assign selectWB = select;
	
endmodule 