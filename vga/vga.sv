module vga(
	input clk, rst,
	input logic [7:0] pixeles,
	output logic vgaclk,
	output logic hsync, vsync,
	output logic sync_b, blank_b,
	output reg [15:0] readAddress,
	output logic [7:0] r, g, b
);
	logic [9:0] x, y;


	
	pll vgapll(
		.inclk0(clk),
		.c0(vgaclk)
	);
	
	vgaController vgaCont(
		.vgaclk(vgaclk),
		.readAddress(readAddress),
		.hsync(hsync),
		.vsync(vsync),
		.sync_b(sync_b),
		.blank_b(blank_b),
		.x(x),
		.y(y)
	);	
	
	
	videoGen vgaVideoGen(
		.clk(vgaclk),
		.rst(rst),
		.pixeles(pixeles),
		.x(x),
		.y(y),
		.r(r),
		.g(g),
		.b(b)
	);

endmodule