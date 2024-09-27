module ALU(
	 input logic [1:0] index,
	 input logic [3:0] counter,
    input logic [4:0] ALUcontrol,
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

// xtime14 - Multiplicación por 0x0E
logic [7:0] xtime14 [0:15][0:15] = '{
    '{8'h00, 8'h0e, 8'h1c, 8'h12, 8'h38, 8'h36, 8'h24, 8'h2a, 8'h70, 8'h7e, 8'h6c, 8'h62, 8'h48, 8'h46, 8'h54, 8'h5a},
    '{8'he0, 8'hee, 8'hfc, 8'hf2, 8'hd8, 8'hd6, 8'hc4, 8'hca, 8'h90, 8'h9e, 8'h8c, 8'h82, 8'ha8, 8'ha6, 8'hb4, 8'hba},
    '{8'hdb, 8'hd5, 8'hc7, 8'hc9, 8'he3, 8'hed, 8'hff, 8'hf1, 8'hab, 8'ha5, 8'hb7, 8'hb9, 8'h93, 8'h9d, 8'h8f, 8'h81},
    '{8'h3b, 8'h35, 8'h27, 8'h29, 8'h03, 8'h0d, 8'h1f, 8'h11, 8'h4b, 8'h45, 8'h57, 8'h59, 8'h73, 8'h7d, 8'h6f, 8'h61},
    '{8'had, 8'ha3, 8'hb1, 8'hbf, 8'h95, 8'h9b, 8'h89, 8'h87, 8'hdd, 8'hd3, 8'hc1, 8'hcf, 8'he5, 8'heb, 8'hf9, 8'hf7},
    '{8'h4d, 8'h43, 8'h51, 8'h5f, 8'h75, 8'h7b, 8'h69, 8'h67, 8'h3d, 8'h33, 8'h21, 8'h2f, 8'h05, 8'h0b, 8'h19, 8'h17},
    '{8'h76, 8'h78, 8'h6a, 8'h64, 8'h4e, 8'h40, 8'h52, 8'h5c, 8'h06, 8'h08, 8'h1a, 8'h14, 8'h3e, 8'h30, 8'h22, 8'h2c},
    '{8'h96, 8'h98, 8'h8a, 8'h84, 8'hae, 8'ha0, 8'hb2, 8'hbc, 8'he6, 8'he8, 8'hfa, 8'hf4, 8'hde, 8'hd0, 8'hc2, 8'hcc},
    '{8'h41, 8'h4f, 8'h5d, 8'h53, 8'h79, 8'h77, 8'h65, 8'h6b, 8'h31, 8'h3f, 8'h2d, 8'h23, 8'h09, 8'h07, 8'h15, 8'h1b},
    '{8'ha1, 8'haf, 8'hbd, 8'hb3, 8'h99, 8'h97, 8'h85, 8'h8b, 8'hd1, 8'hdf, 8'hcd, 8'hc3, 8'he9, 8'he7, 8'hf5, 8'hfb},
    '{8'h9a, 8'h94, 8'h86, 8'h88, 8'ha2, 8'hac, 8'hbe, 8'hb0, 8'hea, 8'he4, 8'hf6, 8'hf8, 8'hd2, 8'hdc, 8'hce, 8'hc0},
    '{8'h7a, 8'h74, 8'h66, 8'h68, 8'h42, 8'h4c, 8'h5e, 8'h50, 8'h0a, 8'h04, 8'h16, 8'h18, 8'h32, 8'h3c, 8'h2e, 8'h20},
    '{8'hec, 8'he2, 8'hf0, 8'hfe, 8'hd4, 8'hda, 8'hc8, 8'hc6, 8'h9c, 8'h92, 8'h80, 8'h8e, 8'ha4, 8'haa, 8'hb8, 8'hb6},
    '{8'h0c, 8'h02, 8'h10, 8'h1e, 8'h34, 8'h3a, 8'h28, 8'h26, 8'h7c, 8'h72, 8'h60, 8'h6e, 8'h44, 8'h4a, 8'h58, 8'h56},
    '{8'h37, 8'h39, 8'h2b, 8'h25, 8'h0f, 8'h01, 8'h13, 8'h1d, 8'h47, 8'h49, 8'h5b, 8'h55, 8'h7f, 8'h71, 8'h63, 8'h6d},
    '{8'hd7, 8'hd9, 8'hcb, 8'hc5, 8'hef, 8'he1, 8'hf3, 8'hfd, 8'ha7, 8'ha9, 8'hbb, 8'hb5, 8'h9f, 8'h91, 8'h83, 8'h8d}
};

// xtime13 - Multiplicación por 0x0D
logic [7:0] xtime13 [0:15][0:15] = '{
    '{8'h00, 8'h0d, 8'h1a, 8'h17, 8'h34, 8'h39, 8'h2e, 8'h23, 8'h68, 8'h65, 8'h72, 8'h7f, 8'h5c, 8'h51, 8'h46, 8'h4b},
    '{8'hd0, 8'hdd, 8'hca, 8'hc7, 8'he4, 8'he9, 8'hfe, 8'hf3, 8'hb8, 8'hb5, 8'ha2, 8'haf, 8'h8c, 8'h81, 8'h96, 8'h9b},
    '{8'hbb, 8'hb6, 8'ha1, 8'hac, 8'h8f, 8'h82, 8'h95, 8'h98, 8'hd3, 8'hde, 8'hc9, 8'hc4, 8'he7, 8'hea, 8'hfd, 8'hf0},
    '{8'h6b, 8'h66, 8'h71, 8'h7c, 8'h5f, 8'h52, 8'h45, 8'h48, 8'h03, 8'h0e, 8'h19, 8'h14, 8'h37, 8'h3a, 8'h2d, 8'h20},
    '{8'h6d, 8'h60, 8'h77, 8'h7a, 8'h59, 8'h54, 8'h43, 8'h4e, 8'h05, 8'h08, 8'h1f, 8'h12, 8'h31, 8'h3c, 8'h2b, 8'h26},
    '{8'hbd, 8'hb0, 8'ha7, 8'haa, 8'h89, 8'h84, 8'h93, 8'h9e, 8'hd5, 8'hd8, 8'hcf, 8'hc2, 8'he1, 8'hec, 8'hfb, 8'hf6},
    '{8'hd6, 8'hdb, 8'hcc, 8'hc1, 8'he2, 8'hef, 8'hf8, 8'hf5, 8'hbe, 8'hb3, 8'ha4, 8'ha9, 8'h8a, 8'h87, 8'h90, 8'h9d},
    '{8'h06, 8'h0b, 8'h1c, 8'h11, 8'h32, 8'h3f, 8'h28, 8'h25, 8'h6e, 8'h63, 8'h74, 8'h79, 8'h5a, 8'h57, 8'h40, 8'h4d},
    '{8'hda, 8'hd7, 8'hc0, 8'hcd, 8'hee, 8'he3, 8'hf4, 8'hf9, 8'hb2, 8'hbf, 8'ha8, 8'ha5, 8'h86, 8'h8b, 8'h9c, 8'h91},
    '{8'h0a, 8'h07, 8'h10, 8'h1d, 8'h3e, 8'h33, 8'h24, 8'h29, 8'h62, 8'h6f, 8'h78, 8'h75, 8'h56, 8'h5b, 8'h4c, 8'h41},
    '{8'h61, 8'h6c, 8'h7b, 8'h76, 8'h55, 8'h58, 8'h4f, 8'h42, 8'h09, 8'h04, 8'h13, 8'h1e, 8'h3d, 8'h30, 8'h27, 8'h2a},
    '{8'hb1, 8'hbc, 8'hab, 8'ha6, 8'h85, 8'h88, 8'h9f, 8'h92, 8'hd9, 8'hd4, 8'hc3, 8'hce, 8'hed, 8'he0, 8'hf7, 8'hfa},
    '{8'hb7, 8'hba, 8'had, 8'ha0, 8'h83, 8'h8e, 8'h99, 8'h94, 8'hdf, 8'hd2, 8'hc5, 8'hc8, 8'heb, 8'he6, 8'hf1, 8'hfc},
    '{8'h67, 8'h6a, 8'h7d, 8'h70, 8'h53, 8'h5e, 8'h49, 8'h44, 8'h0f, 8'h02, 8'h15, 8'h18, 8'h3b, 8'h36, 8'h21, 8'h2c},
    '{8'h0c, 8'h01, 8'h16, 8'h1b, 8'h38, 8'h35, 8'h22, 8'h2f, 8'h64, 8'h69, 8'h7e, 8'h73, 8'h50, 8'h5d, 8'h4a, 8'h47},
    '{8'hdc, 8'hd1, 8'hc6, 8'hcb, 8'he8, 8'he5, 8'hf2, 8'hff, 8'hb4, 8'hb9, 8'hae, 8'ha3, 8'h80, 8'h8d, 8'h9a, 8'h97}
};

// xtime11 - Multiplicación por 0x0B
logic [7:0] xtime11 [0:15][0:15] = '{
    '{8'h00, 8'h0b, 8'h16, 8'h1d, 8'h2c, 8'h27, 8'h3a, 8'h31, 8'h58, 8'h53, 8'h4e, 8'h45, 8'h74, 8'h7f, 8'h62, 8'h69},
	 '{8'hb0, 8'hbb, 8'ha6, 8'had, 8'h9c, 8'h97, 8'h8a, 8'h81, 8'he8, 8'he3, 8'hfe, 8'hf5, 8'hc4, 8'hcf, 8'hd2, 8'hd9},
	 '{8'h7b, 8'h70, 8'h6d, 8'h66, 8'h57, 8'h5c, 8'h41, 8'h4a, 8'h23, 8'h28, 8'h35, 8'h3e, 8'h0f, 8'h04, 8'h19, 8'h12},
	 '{8'hcb, 8'hc0, 8'hdd, 8'hd6, 8'he7, 8'hec, 8'hf1, 8'hfa, 8'h93, 8'h98, 8'h85, 8'h8e, 8'hbf, 8'hb4, 8'ha9, 8'ha2},
	 '{8'hf6, 8'hfd, 8'he0, 8'heb, 8'hda, 8'hd1, 8'hcc, 8'hc7, 8'hae, 8'ha5, 8'hb8, 8'hb3, 8'h82, 8'h89, 8'h94, 8'h9f},
	 '{8'h46, 8'h4d, 8'h50, 8'h5b, 8'h6a, 8'h61, 8'h7c, 8'h77, 8'h1e, 8'h15, 8'h08, 8'h03, 8'h32, 8'h39, 8'h24, 8'h2f},
	 '{8'h8d, 8'h86, 8'h9b, 8'h90, 8'ha1, 8'haa, 8'hb7, 8'hbc, 8'hd5, 8'hde, 8'hc3, 8'hc8, 8'hf9, 8'hf2, 8'hef, 8'he4},
	 '{8'h3d, 8'h36, 8'h2b, 8'h20, 8'h11, 8'h1a, 8'h07, 8'h0c, 8'h65, 8'h6e, 8'h73, 8'h78, 8'h49, 8'h42, 8'h5f, 8'h54},
	 '{8'hf7, 8'hfc, 8'he1, 8'hea, 8'hdb, 8'hd0, 8'hcd, 8'hc6, 8'haf, 8'ha4, 8'hb9, 8'hb2, 8'h83, 8'h88, 8'h95, 8'h9e},
	 '{8'h47, 8'h4c, 8'h51, 8'h5a, 8'h6b, 8'h60, 8'h7d, 8'h76, 8'h1f, 8'h14, 8'h09, 8'h02, 8'h33, 8'h38, 8'h25, 8'h2e},
	 '{8'h8c, 8'h87, 8'h9a, 8'h91, 8'ha0, 8'hab, 8'hb6, 8'hbd, 8'hd4, 8'hdf, 8'hc2, 8'hc9, 8'hf8, 8'hf3, 8'hee, 8'he5},
	 '{8'h3c, 8'h37, 8'h2a, 8'h21, 8'h10, 8'h1b, 8'h06, 8'h0d, 8'h64, 8'h6f, 8'h72, 8'h79, 8'h48, 8'h43, 8'h5e, 8'h55},
	 '{8'h01, 8'h0a, 8'h17, 8'h1c, 8'h2d, 8'h26, 8'h3b, 8'h30, 8'h59, 8'h52, 8'h4f, 8'h44, 8'h75, 8'h7e, 8'h63, 8'h68},
	 '{8'hb1, 8'hba, 8'ha7, 8'hac, 8'h9d, 8'h96, 8'h8b, 8'h80, 8'he9, 8'he2, 8'hff, 8'hf4, 8'hc5, 8'hce, 8'hd3, 8'hd8},
	 '{8'h7a, 8'h71, 8'h6c, 8'h67, 8'h56, 8'h5d, 8'h40, 8'h4b, 8'h22, 8'h29, 8'h34, 8'h3f, 8'h0e, 8'h05, 8'h18, 8'h13},
	 '{8'hca, 8'hc1, 8'hdc, 8'hd7, 8'he6, 8'hed, 8'hf0, 8'hfb, 8'h92, 8'h99, 8'h84, 8'h8f, 8'hbe, 8'hb5, 8'ha8, 8'ha3}
};

// xtime9 - Multiplicación por 0x09
logic [7:0] xtime9 [0:15][0:15] = '{
	 '{8'h00, 8'h09, 8'h12, 8'h1b, 8'h24, 8'h2d, 8'h36, 8'h3f, 8'h48, 8'h41, 8'h5a, 8'h53, 8'h6c, 8'h65, 8'h7e, 8'h77},
	 '{8'h90, 8'h99, 8'h82, 8'h8b, 8'hb4, 8'hbd, 8'ha6, 8'haf, 8'hd8, 8'hd1, 8'hca, 8'hc3, 8'hfc, 8'hf5, 8'hee, 8'he7},
	 '{8'h3b, 8'h32, 8'h29, 8'h20, 8'h1f, 8'h16, 8'h0d, 8'h04, 8'h73, 8'h7a, 8'h61, 8'h68, 8'h57, 8'h5e, 8'h45, 8'h4c},
	 '{8'hab, 8'ha2, 8'hb9, 8'hb0, 8'h8f, 8'h86, 8'h9d, 8'h94, 8'he3, 8'hea, 8'hf1, 8'hf8, 8'hc7, 8'hce, 8'hd5, 8'hdc},
	 '{8'h76, 8'h7f, 8'h64, 8'h6d, 8'h52, 8'h5b, 8'h40, 8'h49, 8'h3e, 8'h37, 8'h2c, 8'h25, 8'h1a, 8'h13, 8'h08, 8'h01},
	 '{8'he6, 8'hef, 8'hf4, 8'hfd, 8'hc2, 8'hcb, 8'hd0, 8'hd9, 8'hae, 8'ha7, 8'hbc, 8'hb5, 8'h8a, 8'h83, 8'h98, 8'h91},
	 '{8'h4d, 8'h44, 8'h5f, 8'h56, 8'h69, 8'h60, 8'h7b, 8'h72, 8'h05, 8'h0c, 8'h17, 8'h1e, 8'h21, 8'h28, 8'h33, 8'h3a},
	 '{8'hdd, 8'hd4, 8'hcf, 8'hc6, 8'hf9, 8'hf0, 8'heb, 8'he2, 8'h95, 8'h9c, 8'h87, 8'h8e, 8'hb1, 8'hb8, 8'ha3, 8'haa},
	 '{8'hec, 8'he5, 8'hfe, 8'hf7, 8'hc8, 8'hc1, 8'hda, 8'hd3, 8'ha4, 8'had, 8'hb6, 8'hbf, 8'h80, 8'h89, 8'h92, 8'h9b},	
	 '{8'h7c, 8'h75, 8'h6e, 8'h67, 8'h58, 8'h51, 8'h4a, 8'h43, 8'h34, 8'h3d, 8'h26, 8'h2f, 8'h10, 8'h19, 8'h02, 8'h0b},
	 '{8'hd7, 8'hde, 8'hc5, 8'hcc, 8'hf3, 8'hfa, 8'he1, 8'he8, 8'h9f, 8'h96, 8'h8d, 8'h84, 8'hbb, 8'hb2, 8'ha9, 8'ha0},
	 '{8'h47, 8'h4e, 8'h55, 8'h5c, 8'h63, 8'h6a, 8'h71, 8'h78, 8'h0f, 8'h06, 8'h1d, 8'h14, 8'h2b, 8'h22, 8'h39, 8'h30},
	 '{8'h9a, 8'h93, 8'h88, 8'h81, 8'hbe, 8'hb7, 8'hac, 8'ha5, 8'hd2, 8'hdb, 8'hc0, 8'hc9, 8'hf6, 8'hff, 8'he4, 8'hed},
	 '{8'h0a, 8'h03, 8'h18, 8'h11, 8'h2e, 8'h27, 8'h3c, 8'h35, 8'h42, 8'h4b, 8'h50, 8'h59, 8'h66, 8'h6f, 8'h74, 8'h7d},	
	 '{8'ha1, 8'ha8, 8'hb3, 8'hba, 8'h85, 8'h8c, 8'h97, 8'h9e, 8'he9, 8'he0, 8'hfb, 8'hf2, 8'hcd, 8'hc4, 8'hdf, 8'hd6},
	 '{8'h31, 8'h38, 8'h23, 8'h2a, 8'h15, 8'h1c, 8'h07, 8'h0e, 8'h79, 8'h70, 8'h6b, 8'h62, 8'h5d, 8'h54, 8'h4f, 8'h46}
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


always @(*) begin
	 
    case(ALUcontrol)
        5'b00100: ALUresult = SrcA ^ SrcB; // XOR {Cout, ALUresult} = SrcA + SrcB + Cin; // Suma
        5'b01101: begin
				case(index)
				  2'b00: ALUresult = SrcA; // ALU para la primera fila (no shift)
				  2'b01: ALUresult = (SrcA << 8) + (SrcA >> 24); // ALU para la segunda fila (1 shift)
				  2'b10: ALUresult = (SrcA << 16) + (SrcA >> 16); // ALU para la tercera fila (2 shifts)
				  2'b11: ALUresult= (SrcA << 24) + (SrcA >> 8); // ALU para la cuarta fila (3 shifts)
				  default: ALUresult = SrcA; // Por defecto, sin shift
				endcase
			end
        5'b01100: begin
				ALUresult = {sbox[SrcA[31:28]][SrcA[27:24]],sbox[SrcA[23:20]][SrcA[19:16]],sbox[SrcA[15:12]][SrcA[11:8]],sbox[SrcA[7:4]][SrcA[3:0]]};
			end
		  5'b01110: begin //
		      logic [7:0] c0,c1,c2,c3;
				c0 = xtime2[SrcC[31:28]][SrcC[27:24]] ^ xtime3[SrcC[23:20]][SrcC[19:16]] ^ SrcC[15:8] ^ SrcC[7:0];
            c1 = SrcC[31:24] ^ xtime2[SrcC[23:20]][SrcC[19:16]] ^ xtime3[SrcC[15:12]][SrcC[11:8]] ^ SrcC[7:0];
				c2 = SrcC[31:24] ^ SrcC[23:16] ^ xtime2[SrcC[15:12]][SrcC[11:8]] ^ xtime3[SrcC[7:4]][SrcC[3:0]];
				c3 = xtime3[SrcC[31:28]][SrcC[27:24]] ^ SrcC[23:16] ^ SrcC[15:8] ^ xtime2[SrcC[7:4]][SrcC[3:0]];
				ALUresult = {c0,c1,c2,c3};
			end
		  5'b00110: begin //
				ALUresult = (SrcA - SrcA[7:0]) | sbox[lastData[7:4]][lastData[3:0]];
			end
		  5'b00111: ALUresult = {SrcA[31:8],SrcA[31:24] ^ SrcA[7:0]};
		  5'b10010: ALUresult = SrcA << 8;
		  5'b01000: begin
				case(column)
				  2'b00: ALUresult = SrcA;
				  2'b01: ALUresult = {SrcA[31:24],SrcA[31:24]^SrcB[23:16],SrcA[15:0]}; 
				  2'b10: ALUresult = {SrcA[31:16],SrcA[23:16]^SrcB[15:8],SrcA[7:0]}; 
				  2'b11: ALUresult= {SrcA[31:8],SrcA[15:8]^SrcB[7:0]}; 
				  default: ALUresult = SrcA; 
				endcase
			end
		  5'b01001: ALUresult = {8'h00,SrcA[31:24]^SrcA[23:16],SrcA[23:16]^SrcA[15:8],SrcA[15:8]^SrcA[7:0]};
        5'b01010: ALUresult = {SrcB[31:24] ^ SrcA[7:0], SrcA[23:0]};
		  5'b01011: ALUresult = {SrcA[31:8], SrcB[7:0]};
		  5'b10000: begin
				case(index)
				  2'b00: ALUresult = SrcA; // ALU para la primera fila (no shift)
				  2'b01: ALUresult = (SrcA << 24) + (SrcA >> 8); // ALU para la segunda fila (1 shift)
				  2'b10: ALUresult = (SrcA << 16) + (SrcA >> 16); // ALU para la tercera fila (2 shifts)
				  2'b11: ALUresult= (SrcA << 8) + (SrcA >> 24); // ALU para la cuarta fila (3 shifts)
				  default: ALUresult = SrcA; // Por defecto, sin shift
				endcase
			end
		  5'b01111: begin
			  logic [7:0] tempA, tempB, tempC, tempD;
			  int i, j;

			  // Búsqueda inversa para SrcA[31:24]
			  for (i = 0; i < 16; i++) 
					for (j = 0; j < 16; j++) 
						 if (sbox[i][j] == SrcA[31:24]) 
							  tempA = {i[3:0], j[3:0]};

			  // Búsqueda inversa para SrcA[23:16]
			  for (i = 0; i < 16; i++) 
					for (j = 0; j < 16; j++) 
						 if (sbox[i][j] == SrcA[23:16]) 
							  tempB = {i[3:0], j[3:0]};

			  // Búsqueda inversa para SrcA[15:8]
			  for (i = 0; i < 16; i++) 
					for (j = 0; j < 16; j++) 
						 if (sbox[i][j] == SrcA[15:8]) 
							  tempC = {i[3:0], j[3:0]};

			  // Búsqueda inversa para SrcA[7:0]
			  for (i = 0; i < 16; i++) 
					for (j = 0; j < 16; j++) 
						 if (sbox[i][j] == SrcA[7:0]) 
							  tempD = {i[3:0], j[3:0]};

			  // Unir los resultados en un solo valor de 32 bits
			  ALUresult = {tempA, tempB, tempC, tempD};
		  end
		  5'b10001: begin //
		      logic [7:0] c0,c1,c2,c3;
				// Aplicando la operación inversa usando xtime9, xtime11, xtime13, xtime14
				c0 = xtime14[SrcC[31:28]][SrcC[27:24]] ^ xtime11[SrcC[23:20]][SrcC[19:16]] ^ xtime13[SrcC[15:12]][SrcC[11:8]] ^ xtime9[SrcC[7:4]][SrcC[3:0]];
				c1 = xtime9[SrcC[31:28]][SrcC[27:24]] ^ xtime14[SrcC[23:20]][SrcC[19:16]] ^ xtime11[SrcC[15:12]][SrcC[11:8]] ^ xtime13[SrcC[7:4]][SrcC[3:0]];
				c2 = xtime13[SrcC[31:28]][SrcC[27:24]] ^ xtime9[SrcC[23:20]][SrcC[19:16]] ^ xtime14[SrcC[15:12]][SrcC[11:8]] ^ xtime11[SrcC[7:4]][SrcC[3:0]];
				c3 = xtime11[SrcC[31:28]][SrcC[27:24]] ^ xtime13[SrcC[23:20]][SrcC[19:16]] ^ xtime9[SrcC[15:12]][SrcC[11:8]] ^ xtime14[SrcC[7:4]][SrcC[3:0]];
				ALUresult = {c0,c1,c2,c3};
			end
		  5'b00101: begin
				 logic [7:0] rcon;
				 rcon = 1 << (counter - 1);
				 if (index == 0) begin
					  ALUresult = {SrcA[31:8],SrcA[7:0]^rcon};  // Asignar SrcA a ALUresult si counter es 1
				 end
				 else begin
					  ALUresult = SrcA; // O puedes dejar otro valor si lo prefieres
				 end
			end
		  5'b00011: ALUresult = SrcA;  //MATRIX SET	
		  default: ALUresult = 32'b0; // Por defecto
    endcase
end

endmodule