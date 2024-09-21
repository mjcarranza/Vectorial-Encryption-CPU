module shiftLPC(input  logic [11:0] pc,
              output logic [15:0] realPC);
 
  always_comb
		// hacer shift left logical para obtener el pc real
      realPC = pc << 1;
	 
endmodule 