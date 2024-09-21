module extend(input  logic [23:0] Instr,
              input  logic [1:0]  ImmSrc,
              output logic [31:0] ExtImm);
 
  always_comb
    case(ImmSrc) 
               // 8-bit unsigned immediate
      2'b00:   ExtImm = { {24{Instr[7]}}, Instr[7:0] };  
               // 12-bit unsigned immediate 
      2'b01:   ExtImm =  { {20{Instr[11]}}, Instr[11:0] }; 
               // 24-bit two's complement shifted branch 
      2'b10:   ExtImm = { {8{Instr[23]}}, Instr }; 
      default: ExtImm = { {24{Instr[7]}}, Instr[7:0] }; // undefined
    endcase
	 
endmodule