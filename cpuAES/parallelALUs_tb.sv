module parallelALUs_tb;
	
	// Señales de entrada
   logic [127:0] M;
	
	parallelALUs parallelALUs_test(M);
	 

// Estímulos
initial begin
    // Test 1: Suma (ALUcontrol = 00)
    //M = 128'h333b61501c4feaaf38b721a9c94d442d;
	 //M = 128'h6649d86c1bc492bb7bb776206586fa12;
    //M = 128'h2b28ab097eaef7cf15d2154f16a6883c;
	 //M = 128'h2b28ab8a7eaef78415d215eb16a68801;
	 //M = 128'h2b28ab8b7eaef78415d215eb16a68801;
	 M = 128'h2b28ab8b7eaef78415d215eb16a68801;
	 //M = 128'h2b28aba07eaef7fa15d215fe16a68817;
	 //M = 128'ha0000000fa000000fe00000017000000;
	 //M = 128'ha0880000fa540000fe2c000017b10000;
	 //M = 128'ha0882300fa54a300fe2c390017b13900;
	 //M = 128'ha088232afa54a36cfe2c397617b13905;
	 //M = 128'ha0000000fa000000fe00000017000000;
	 //M = 128'h000000010000000000000000000000000;
end

endmodule