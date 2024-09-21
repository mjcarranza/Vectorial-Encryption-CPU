module extend(input  logic [6:0] Instr,
              output logic [15:0] ExtImm);
 
  always_comb
		// cuando se usa el valor inmediato, (de 4 bits) se supone que es positivo
      ExtImm = { {9'b00}, Instr[6:0] }; 
	 
endmodule