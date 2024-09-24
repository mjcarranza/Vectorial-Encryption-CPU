module ALU(
	 input logic [1:0] index,
    input logic [3:0] ALUcontrol,
    input logic [31:0] SrcA,
    input logic [31:0] SrcB,
	 input logic [31:0] SrcC,
	 input logic [1:0] column,
	 input logic [7:0] lastData,
    output logic [31:0] ALUresult
	 //output logic [7:0] c0,c1,c2,c3,
);
// logic indexM = 0;
// Definir e inicializar la matriz de MixColumns
 const logic [7:0] mix_columns_matrix [0:3][0:3] = '{
    '{8'h02, 8'h03, 8'h01, 8'h01},
    '{8'h01, 8'h02, 8'h03, 8'h01},
    '{8'h01, 8'h01, 8'h02, 8'h03},
    '{8'h03, 8'h01, 8'h01, 8'h02}
 };
 
 logic [7:0] xtime2 [0:15][0:15] = '{
        '{8'h00, 8'h02, 8'h04, 8'h06, 8'h08, 8'h0A, 8'h0C, 8'h0E, 8'h10, 8'h12, 8'h14, 8'h16, 8'h18, 8'h1A, 8'h1C, 8'h1E},
        '{8'h20, 8'h22, 8'h24, 8'h26, 8'h28, 8'h2A, 8'h2C, 8'h2E, 8'h30, 8'h32, 8'h34, 8'h36, 8'h38, 8'h3A, 8'h3C, 8'h3E},
        '{8'h40, 8'h42, 8'h44, 8'h46, 8'h48, 8'h4A, 8'h4C, 8'h4E, 8'h50, 8'h52, 8'h54, 8'h56, 8'h58, 8'h5A, 8'h5C, 8'h5E},
        '{8'h60, 8'h62, 8'h64, 8'h66, 8'h68, 8'h6A, 8'h6C, 8'h6E, 8'h70, 8'h72, 8'h74, 8'h76, 8'h78, 8'h7A, 8'h7C, 8'h7E},
        '{8'h80, 8'h82, 8'h84, 8'h86, 8'h88, 8'h8A, 8'h8C, 8'h8E, 8'h90, 8'h92, 8'h94, 8'h96, 8'h98, 8'h9A, 8'h9C, 8'h9E},
        '{8'hA0, 8'hA2, 8'hA4, 8'hA6, 8'hA8, 8'hAA, 8'hAC, 8'hAE, 8'hB0, 8'hB2, 8'hB4, 8'hB6, 8'hB8, 8'hBA, 8'hBC, 8'hBE},
        '{8'hC0, 8'hC2, 8'hC4, 8'hC6, 8'hC8, 8'hCA, 8'hCC, 8'hCE, 8'hD0, 8'hD2, 8'hD4, 8'hD6, 8'hD8, 8'hDA, 8'hDC, 8'hDE},
        '{8'hE0, 8'hE2, 8'hE4, 8'hE6, 8'hE8, 8'hEA, 8'hEC, 8'hEE, 8'hF0, 8'hF2, 8'hF4, 8'hF6, 8'hF8, 8'hFA, 8'hFC, 8'hFE},
        '{8'h1B, 8'h19, 8'h1F, 8'h1D, 8'h13, 8'h11, 8'h17, 8'h15, 8'h0B, 8'h09, 8'h0F, 8'h0D, 8'h03, 8'h01, 8'h07, 8'h05},
        '{8'h3B, 8'h39, 8'h3F, 8'h3D, 8'h33, 8'h31, 8'h37, 8'h35, 8'h2B, 8'h29, 8'h2F, 8'h2D, 8'h23, 8'h21, 8'h27, 8'h25},
        '{8'h5B, 8'h59, 8'h5F, 8'h5D, 8'h53, 8'h51, 8'h57, 8'h55, 8'h4B, 8'h49, 8'h4F, 8'h4D, 8'h43, 8'h41, 8'h47, 8'h45},
        '{8'h7B, 8'h79, 8'h7F, 8'h7D, 8'h73, 8'h71, 8'h77, 8'h75, 8'h6B, 8'h69, 8'h6F, 8'h6D, 8'h63, 8'h61, 8'h67, 8'h65},
        '{8'h9B, 8'h99, 8'h9F, 8'h9D, 8'h93, 8'h91, 8'h97, 8'h95, 8'h8B, 8'h89, 8'h8F, 8'h8D, 8'h83, 8'h81, 8'h87, 8'h85},
        '{8'hBB, 8'hB9, 8'hBF, 8'hBD, 8'hB3, 8'hB1, 8'hB7, 8'hB5, 8'hAB, 8'hA9, 8'hAF, 8'hAD, 8'hA3, 8'hA1, 8'hA7, 8'hA5},
        '{8'hDB, 8'hD9, 8'hDF, 8'hDD, 8'hD3, 8'hD1, 8'hD7, 8'hD5, 8'hCB, 8'hC9, 8'hCF, 8'hCD, 8'hC3, 8'hC1, 8'hC7, 8'hC5},
        '{8'hFB, 8'hF9, 8'hFF, 8'hFD, 8'hF3, 8'hF1, 8'hF7, 8'hF5, 8'hEB, 8'hE9, 8'hEF, 8'hED, 8'hE3, 8'hE1, 8'hE7, 8'hE5}
};
logic [7:0] xtime3 [0:15][0:15] = '{
        '{8'h00, 8'h03, 8'h06, 8'h05, 8'h0C, 8'h0F, 8'h0A, 8'h09, 8'h18, 8'h1B, 8'h1E, 8'h1D, 8'h14, 8'h17, 8'h12, 8'h11},
        '{8'h30, 8'h33, 8'h36, 8'h35, 8'h3C, 8'h3F, 8'h3A, 8'h39, 8'h28, 8'h2B, 8'h2E, 8'h2D, 8'h24, 8'h27, 8'h22, 8'h21},
        '{8'h60, 8'h63, 8'h66, 8'h65, 8'h6C, 8'h6F, 8'h6A, 8'h69, 8'h78, 8'h7B, 8'h7E, 8'h7D, 8'h74, 8'h77, 8'h72, 8'h71},
        '{8'h50, 8'h53, 8'h56, 8'h55, 8'h5C, 8'h5F, 8'h5A, 8'h59, 8'h48, 8'h4B, 8'h4E, 8'h4D, 8'h44, 8'h47, 8'h42, 8'h41},
        '{8'hC0, 8'hC3, 8'hC6, 8'hC5, 8'hCC, 8'hCF, 8'hCA, 8'hC9, 8'hD8, 8'hDB, 8'hDE, 8'hDD, 8'hD4, 8'hD7, 8'hD2, 8'hD1},
        '{8'hF0, 8'hF3, 8'hF6, 8'hF5, 8'hFC, 8'hFF, 8'hFA, 8'hF9, 8'hE8, 8'hEB, 8'hEE, 8'hED, 8'hE4, 8'hE7, 8'hE2, 8'hE1},
        '{8'hA0, 8'hA3, 8'hA6, 8'hA5, 8'hAC, 8'hAF, 8'hAA, 8'hA9, 8'hB8, 8'hBB, 8'hBE, 8'hBD, 8'hB4, 8'hB7, 8'hB2, 8'hB1},
        '{8'h90, 8'h93, 8'h96, 8'h95, 8'h9C, 8'h9F, 8'h9A, 8'h99, 8'h88, 8'h8B, 8'h8E, 8'h8D, 8'h84, 8'h87, 8'h82, 8'h81},
        '{8'h9B, 8'h98, 8'h9D, 8'h9E, 8'h97, 8'h94, 8'h91, 8'h92, 8'h83, 8'h80, 8'h85, 8'h86, 8'h8F, 8'h8C, 8'h89, 8'h8A},
        '{8'hAB, 8'hA8, 8'hAD, 8'hAE, 8'hA7, 8'hA4, 8'hA1, 8'hA2, 8'hB3, 8'hB0, 8'hB5, 8'hB6, 8'hBF, 8'hBC, 8'hB9, 8'hBA},
        '{8'hFB, 8'hF8, 8'hFD, 8'hFE, 8'hF7, 8'hF4, 8'hF1, 8'hF2, 8'hE3, 8'hE0, 8'hE5, 8'hE6, 8'hEF, 8'hEC, 8'hE9, 8'hEA},
        '{8'hCB, 8'hC8, 8'hCD, 8'hCE, 8'hC7, 8'hC4, 8'hC1, 8'hC2, 8'hD3, 8'hD0, 8'hD5, 8'hD6, 8'hDF, 8'hDC, 8'hD9, 8'hDA},
        '{8'h5B, 8'h58, 8'h5D, 8'h5E, 8'h57, 8'h54, 8'h51, 8'h52, 8'h43, 8'h40, 8'h45, 8'h46, 8'h4F, 8'h4C, 8'h49, 8'h4A},
        '{8'h7B, 8'h78, 8'h7D, 8'h7E, 8'h77, 8'h74, 8'h71, 8'h72, 8'h63, 8'h60, 8'h65, 8'h66, 8'h6F, 8'h6C, 8'h69, 8'h6A},
        '{8'h3B, 8'h38, 8'h3D, 8'h3E, 8'h37, 8'h34, 8'h31, 8'h32, 8'h23, 8'h20, 8'h25, 8'h26, 8'h2F, 8'h2C, 8'h29, 8'h2A},
        '{8'h1B, 8'h18, 8'h1D, 8'h1E, 8'h17, 8'h14, 8'h11, 8'h12, 8'h03, 8'h00, 8'h05, 8'h06, 8'h0F, 8'h0C, 8'h09, 8'h0A}
};

logic [7:0] sbox [0:15][0:15] = '{
    '{8'h63, 8'h7C, 8'h77, 8'h7B, 8'hF2, 8'h6B, 8'h6F, 8'hC5, 8'h30, 8'h01, 8'h67, 8'h2B, 8'hFE, 8'hD7, 8'hAB, 8'h76},
    '{8'hCA, 8'h82, 8'hC9, 8'h7D, 8'hFA, 8'h59, 8'h47, 8'hF0, 8'hAD, 8'hD4, 8'hA2, 8'hAF, 8'h9C, 8'hA4, 8'h72, 8'hC0},
    '{8'hB7, 8'hFD, 8'h93, 8'h26, 8'h36, 8'h3F, 8'hF7, 8'hCC, 8'h34, 8'hA5, 8'hE5, 8'hF1, 8'h71, 8'hD8, 8'h31, 8'h15},
    '{8'h04, 8'hC7, 8'h23, 8'hC3, 8'h18, 8'h96, 8'h05, 8'h9A, 8'h07, 8'h12, 8'h80, 8'hE2, 8'hEB, 8'h27, 8'hB2, 8'h75},
    '{8'h09, 8'h83, 8'h2C, 8'h1A, 8'h1B, 8'h6E, 8'h5A, 8'hA0, 8'h52, 8'h3B, 8'hD6, 8'hB3, 8'h29, 8'hE3, 8'h2F, 8'h84},
    '{8'h53, 8'hD1, 8'h00, 8'hED, 8'h20, 8'hFC, 8'hB1, 8'h5B, 8'h6A, 8'hCB, 8'hBE, 8'h39, 8'h4A, 8'h4C, 8'h58, 8'hCF},
    '{8'hD0, 8'hEF, 8'hAA, 8'hFB, 8'h43, 8'h4D, 8'h33, 8'h85, 8'h45, 8'hF9, 8'h02, 8'h7F, 8'h50, 8'h3C, 8'h9F, 8'hA8},
    '{8'h51, 8'hA3, 8'h40, 8'h8F, 8'h92, 8'h9D, 8'h38, 8'hF5, 8'hBC, 8'hB6, 8'hDA, 8'h21, 8'h10, 8'hFF, 8'hF3, 8'hD2},
    '{8'hCD, 8'h0C, 8'h13, 8'hEC, 8'h5F, 8'h97, 8'h44, 8'h17, 8'hC4, 8'hA7, 8'h7E, 8'h3D, 8'h64, 8'h5D, 8'h19, 8'h73},
    '{8'h60, 8'h81, 8'h4F, 8'hDC, 8'h22, 8'h2A, 8'h90, 8'h88, 8'h46, 8'hEE, 8'hB8, 8'h14, 8'hDE, 8'h5E, 8'h0B, 8'hDB},
    '{8'hE0, 8'h32, 8'h3A, 8'h0A, 8'h49, 8'h06, 8'h24, 8'h5C, 8'hC2, 8'hD3, 8'hAC, 8'h62, 8'h91, 8'h95, 8'hE4, 8'h79},
    '{8'hE7, 8'hC8, 8'h37, 8'h6D, 8'h8D, 8'hD5, 8'h4E, 8'hA9, 8'h6C, 8'h56, 8'hF4, 8'hEA, 8'h65, 8'h7A, 8'hAE, 8'h08},
    '{8'hBA, 8'h78, 8'h25, 8'h2E, 8'h1C, 8'hA6, 8'hB4, 8'hC6, 8'hE8, 8'hDD, 8'h74, 8'h1F, 8'h4B, 8'hBD, 8'h8B, 8'h8A},
    '{8'h70, 8'h3E, 8'hB5, 8'h66, 8'h48, 8'h03, 8'hF6, 8'h0E, 8'h61, 8'h35, 8'h57, 8'hB9, 8'h86, 8'hC1, 8'h1D, 8'h9E},
    '{8'hE1, 8'hF8, 8'h98, 8'h11, 8'h69, 8'hD9, 8'h8E, 8'h94, 8'h9B, 8'h1E, 8'h87, 8'hE9, 8'hCE, 8'h55, 8'h28, 8'hDF},
    '{8'h8C, 8'hA1, 8'h89, 8'h0D, 8'hBF, 8'hE6, 8'h42, 8'h68, 8'h41, 8'h99, 8'h2D, 8'h0F, 8'hB0, 8'h54, 8'hBB, 8'h16}
};

logic [7:0] c0,c1,c2,c3;
always @(*) begin
	 
    case(ALUcontrol)
        4'b0000: ALUresult = SrcA ^ SrcB; // XOR {Cout, ALUresult} = SrcA + SrcB + Cin; // Suma
        4'b0001: begin
				case(index)
				  2'b00: ALUresult = SrcA; // ALU para la primera fila (no shift)
				  2'b01: ALUresult = (SrcA << 8) + (SrcA >> 24); // ALU para la segunda fila (1 shift)
				  2'b10: ALUresult = (SrcA << 16) + (SrcA >> 16); // ALU para la tercera fila (2 shifts)
				  2'b11: ALUresult= (SrcA << 24) + (SrcA >> 8); // ALU para la cuarta fila (3 shifts)
				  default: ALUresult = SrcA; // Por defecto, sin shift
				endcase
			end
        4'b0010: begin
				ALUresult = {sbox[SrcA[31:28]][SrcA[27:24]],sbox[SrcA[23:20]][SrcA[19:16]],sbox[SrcA[15:12]][SrcA[11:8]],sbox[SrcA[7:4]][SrcA[3:0]]};
			end
		  4'b0011: begin //
				c0 = xtime2[SrcC[31:28]][SrcC[27:24]] ^ xtime3[SrcC[23:20]][SrcC[19:16]] ^ SrcC[15:8] ^ SrcC[7:0];
            c1 = SrcC[31:24] ^ xtime2[SrcC[23:20]][SrcC[19:16]] ^ xtime3[SrcC[15:12]][SrcC[11:8]] ^ SrcC[7:0];
				c2 = SrcC[31:24] ^ SrcC[23:16] ^ xtime2[SrcC[15:12]][SrcC[11:8]] ^ xtime3[SrcC[7:4]][SrcC[3:0]];
				c3 = xtime3[SrcC[31:28]][SrcC[27:24]] ^ SrcC[23:16] ^ SrcC[15:8] ^ xtime2[SrcC[7:4]][SrcC[3:0]];
				ALUresult = {c0,c1,c2,c3};
			end
		  4'b0100: begin //
				ALUresult = (SrcA - SrcA[7:0]) | sbox[lastData[7:4]][lastData[3:0]];
			end
		  4'b0101: ALUresult = {SrcA[31:8],SrcA[31:24] ^ SrcA[7:0]};
		  4'b0110: ALUresult = SrcA << 8;
		  4'b0111: begin
				case(column)
				  2'b00: ALUresult = SrcA;
				  2'b01: ALUresult = {SrcA[31:24],SrcA[31:24]^SrcB[23:16],SrcA[15:0]}; 
				  2'b10: ALUresult = {SrcA[31:16],SrcA[23:16]^SrcB[15:8],SrcA[7:0]}; 
				  2'b11: ALUresult= {SrcA[31:8],SrcA[15:8]^SrcB[7:0]}; 
				  default: ALUresult = SrcA; 
				endcase
			end
		  4'b1000: ALUresult = {8'h00,SrcA[31:24]^SrcA[23:16],SrcA[23:16]^SrcA[15:8],SrcA[15:8]^SrcA[7:0]};
        4'b1001: ALUresult = {SrcB[31:24] ^ SrcA[7:0], SrcA[23:0]};
		  4'b1010: ALUresult = {SrcA[31:24],SrcB[23:0]};
		  default: ALUresult = 32'b0; // Por defecto
    endcase
end

endmodule