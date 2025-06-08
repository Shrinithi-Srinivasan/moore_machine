module tb_moore_machine;

    reg clk;                // Clock signal
    reg rst;                // Reset signal
    reg in;                 // Input signal
    wire out;               // Output of the Moore machine

    // Instantiate the Moore machine
    moore_machine uut (
        .clk(clk),
        .rst(rst),
        .in(in),
        .out(out)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;  // Clock period of 10 time units
    end

    // Test sequence
    initial begin
          $dumpfile("dumpfile.vcd");
    $dumpvars(1);

        // Initialize signals
        clk = 0;
        rst = 0;
        in = 0;

        // Reset the Moore machine
        #2 rst = 1;  // Apply reset for 2 time units
        #10 rst = 0; // Release reset

        // Apply test inputs and monitor the outputs
        #10 in = 1; // Time = 10
        #10 in = 0; // Time = 20
        #10 in = 1; // Time = 30
        #10 in = 1; // Time = 40
        #10 in = 0; // Time = 50
        #10 in = 0; // Time = 60

        #10 in = 1; // Time = 70
        #10 in = 1; // Time = 80
        #10 in = 0; // Time = 90
        #10 in = 0; // Time = 100

        #10 $finish;  // End simulation
    end

    // Display the results
    initial begin
        $monitor("Time = %0t | Input = %b | Output = %b", $time, in, out);
    end

endmodule
