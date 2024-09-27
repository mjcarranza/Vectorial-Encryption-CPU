module Columnmaker(
    input logic [7:0] DataA,
	 input logic [7:0] DataB,
	 input logic [7:0] DataC,
	 input logic [7:0] DataD,
    output logic [31:0] Column
);
	assign Column = {DataA, DataB, DataC, DataD};

endmodule