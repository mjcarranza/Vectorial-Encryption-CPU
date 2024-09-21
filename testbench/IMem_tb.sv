`timescale 1 ps / 1 ps

module IMem_tb;
    reg [11:0] address;
    reg clock;
    wire [15:0] q;

    // Instancia del módulo IMem
    IMem uut (
        .address(address),
        .clock(clock),
        .q(q)
    );

    // Generación de clock
    always #5 clock = ~clock;

    // Inicialización
    initial begin
        clock = 1;
        address = 12'h0;
         
        // Ejemplo de lectura de memoria en direcciones específicas
        #10;
        address = 12'h1; // Cambiar a la dirección que desees leer
        #10;
        $display("Time: %0t, Address: %d, Data: %h", $time, address, q);
        #10; 
        address = 12'h2; // Cambiar a la dirección que desees leer
        #10;
        $display("Time: %0t, Address: %d, Data: %h", $time, address, q);
        #10;
        address = 12'h3; // Cambiar a la dirección que desees leer
        #10;
        $display("Time: %0t, Address: %d, Data: %h", $time, address, q);
    end

endmodule
