module mux2_1 #(parameter width = 4)(input logic [width - 1:0] data0,
					  input logic [width - 1:0] data1,
					  input logic select,
					  output logic [width - 1:0] result);

  always_comb begin
    if (select)
      result = data1;
    else
      result = data0;
  end

endmodule