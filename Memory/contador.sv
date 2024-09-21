module contador(
    input clk,    // Entrada de reloj
    input reset,  // Entrada de reset
    output reg [15:0] address // Contador de 8 bits
);

    always @(posedge clk or posedge reset)
    begin
        if (reset)
            address <= 16'h00; // Resetea el contador a 0
        else if(address >= 16'd35000) begin
				address <= 16'h00;
		  end
		  else begin
            address <= address + 1;    // Incrementa el contador en 1
		  end
    end

endmodule 