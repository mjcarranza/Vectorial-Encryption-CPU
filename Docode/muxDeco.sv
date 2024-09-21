
module muxDeco(input logic [3:0] data0,
					  input logic [3:0] data1,
					  input logic select,
					  output logic [3:0] result);

  always_comb begin
    if (select)
      result = data1;
    else
      result = data0;
  end

endmodule