
module muxSrc(input logic [15:0] data0,
					  input logic [15:0] data1,
					  input logic select,
					  output logic [15:0] result);

  always_comb begin
    if (select)
      result = data1;
    else
      result = data0;
  end

endmodule