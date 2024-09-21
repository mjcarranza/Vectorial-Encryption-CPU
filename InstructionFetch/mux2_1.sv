module mux2_1(input logic [11:0] data0,
					  input logic [11:0] data1,
					  input logic select,
					  output logic [11:0] result);

  always_comb begin
    if (select)
      result = data1;
    else
      result = data0;
  end

endmodule