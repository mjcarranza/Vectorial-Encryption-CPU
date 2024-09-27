module parallelALUs(
	 input logic [127:0] M
	 
);
	logic [127:0] Result;
	logic [31:0] SrcC0,SrcC1,SrcC2,SrcC3;
	//128'hd0c9e1b614ee3f63f9250c0ca889c8a6;
	//128'h2b28ab097eaef7cf15d2154f16a6883c
	//128'h000000010000000000000000000000000;
	//128'ha088232afa54a36cfe2c397617b13905;
	//128'h1f22df409ef37a35cf74b61ca97bbc4f;
	Columnmaker Columnmaker_test0(M[127:120],M[95:88],M[63:56],M[31:24],SrcC0);
	Columnmaker Columnmaker_test1(M[119:112],M[87:80],M[55:48],M[23:16],SrcC1);
	Columnmaker Columnmaker_test2(M[111:104],M[79:72],M[47:40],M[15:8],SrcC2);
	Columnmaker Columnmaker_test3(M[103:96],M[71:64],M[39:32],M[7:0],SrcC3);
	ALU ALU_p0(2'b00,4'b1000,4'b1101,M[127:96],32'h0028ab09,SrcC0,2'b11,M[71:64],Result[127:96]);
	ALU ALU_p1(2'b01,4'b1000,4'b1101,M[95:64],32'h00aef7cf,SrcC1,2'b11,M[39:32],Result[95:64]);
	ALU ALU_p2(2'b10,4'b1000,4'b1101,M[63:32],32'h00d2154f,SrcC2,2'b11,M[7:0],Result[63:32]);
	ALU ALU_p3(2'b11,4'b1000,4'b1101,M[31:0],32'h00a6883c,SrcC3,2'b11,M[103:96],Result[31:0]);
	 

endmodule