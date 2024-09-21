`timescale 1ns/1ps

module procesador_tb;

    // Inputs
    reg clk;
    reg rst;
    reg rstCont;

    // Outputs
    wire vgaclk;
    wire hsync;
    wire vsync;
    wire sync_b;
    wire blank_b;
    wire [7:0] r, g, b;

    // Instantiate the procesador module
    procesador dut (
        .clk(clk),
        .rst(rst),
        .rstCont(rstCont),
        .vgaclk(vgaclk),
        .hsync(hsync),
        .vsync(vsync),
        .sync_b(sync_b),
        .blank_b(blank_b),
        .r(r),
        .g(g),
        .b(b)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Initial values
    initial begin
        clk = 0;
        rst = 1;
        rstCont = 1;

        // Reset sequence
        #10 rst = 0;

        // Add your test sequence here
        // For example:
        // #100;
        // #1000;
        // ...
    end

    // Monitor
    always @(posedge clk) begin
        $display("Time: %t, VGA_CLK: %b, HSYNC: %b, VSYNC: %b, SYNC_B: %b, BLANK_B: %b, R: %h, G: %h, B: %h", $time, vgaclk, hsync, vsync, sync_b, blank_b, r, g, b);
    end

endmodule
