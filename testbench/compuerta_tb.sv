module compuerta_tb;

    // Inputs
    reg zeroE, jumpE, branchE, negative;
    // Output
    wire pcSrcE;

    // Instantiate the module
    compuerta dut (
        .zeroE(zeroE),
        .jumpE(jumpE),
        .branchE(branchE),
        .negative(negative),
        .pcSrcE(pcSrcE)
    );

    // Stimulus
    initial begin
        $dumpfile("compuerta_tb.vcd");
        $dumpvars(0, compuerta_tb);

        // Test case 1: zeroE = 0, jumpE = 0, branchE = 0, negative = 0
        zeroE = 0; jumpE = 0; branchE = 0; negative = 0;
        #10;
        // Expected output: pcSrcE = 0 | (1 & 0 & 0) = 0
        if (pcSrcE !== 0) $error("Test case 1 failed!");

        // Test case 2: zeroE = 1, jumpE = 0, branchE = 1, negative = 0
        zeroE = 1; jumpE = 0; branchE = 1; negative = 0;
        #10;
        // Expected output: pcSrcE = 0 | (0 & 1 & 1) = 0
        if (pcSrcE !== 0) $error("Test case 2 failed!");

        // Test case 3: zeroE = 0, jumpE = 1, branchE = 1, negative = 1
        zeroE = 0; jumpE = 1; branchE = 1; negative = 1;
        #10;
        // Expected output: pcSrcE = 1 | (1 & 0 & 1) = 1
        if (pcSrcE !== 1) $error("Test case 3 failed!");

        // Test case 4: zeroE = 1, jumpE = 1, branchE = 1, negative = 1
        zeroE = 1; jumpE = 1; branchE = 1; negative = 1;
        #10;
        // Expected output: pcSrcE = 1 | (0 & 1 & 1) = 1
        if (pcSrcE !== 1) $error("Test case 4 failed!");

    end

endmodule
