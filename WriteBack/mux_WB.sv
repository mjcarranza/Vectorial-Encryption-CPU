module mux_WB( input logic [31:0] data0,
					input logic [31:0] data1,
					input logic select,
					output logic [31:0] result);

  always_comb begin
	  case (select)
			
				 1'b0: begin // acciones para ADD
						result = data0;			// fuente del segundo dato para la alu (contenido de registro)
				 end
				 1'b1: begin // acciones para ADD
						result = data1;			// fuente del segundo dato para la alu (contenido de registro)
				 end
				 default: begin // acciones para NOT (stall)
						result = data0;			// fuente del segundo dato para la alu (contenido de registro)
				 end
		endcase
  end

endmodule