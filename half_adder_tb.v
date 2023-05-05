//=========================================================================
// Name & Email must be EXACTLY as in Gradescope roster!
// Name: 
// Email: 
// 
// Assignment name: 
// Lab section: 
// TA: 
// 
// I hereby certify that I have not received assistance on this assignment,
// or used code, from ANY outside source other than the instruction team
// (apart from what was provided in the starter file).
//
//=========================================================================

`timescale 1ns / 1ps

module half_adder_tb;

    // Inputs
    reg clk;
    reg reset;
    reg A;
    reg B;
    
    // Outputs
    wire result;
    reg  expected_result;
    wire carryout;
    

    // -------------------------------------------------------
    // Setup output file for possible debugging uses
    // -------------------------------------------------------
    initial
    begin
        $dumpfile("half_adder_tb.vcd");
        $dumpvars(0);
    end

    // -------------------------------------------------------
    // Instantiate the Unit Under Test (UUT)
    // -------------------------------------------------------
    half_adder uut(.a(A), .b(B), .s(result), .c_out(carryout));

    initial begin 
    
        clk = 0; reset = 1; #50; 
        clk = 1; reset = 1; #50; 
        clk = 0; reset = 0; #50; 
        clk = 1; reset = 0; #50; 
         
        forever begin 
            clk = ~clk; #50; 
        end 
    end 
    
    integer totalTests = 0;
    integer failedTests = 0;
    
    initial begin // Test suite
        // Reset
        @(negedge reset); // Wait for reset to be released (from another initial block)
        @(posedge clk);   // Wait for first clock out of reset 
        #10; // Wait 10 cycles 

        // ---------------------------------------------
        // Test Group for Addition Behavior Verification 
        // --------------------------------------------- 
        $write("Test Group 1: Addition Behavior Verification ... \n");

        // Code necessary for each test case 
        totalTests = totalTests + 1;
        $write("\tTest Case 1.1:   0+0 = 0, c_out = 0 ... ");
        A = 1'b0;
        B = 1'b0;
        expected_result = 1'b0;

        #100; // Wait 
        if (expected_result !== result || carryout !== 1'b0) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait 
        
        totalTests = totalTests + 1;
        $write("\tTest Case 1.2:   0+1 = 1, c_out = 0 ... ");
        A = 1'b0;
        B = 1'b1;
        expected_result = 1'b1;

        #100; // Wait 
        if (expected_result !== result || carryout !== 1'b0) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait 

        totalTests = totalTests + 1;
        $write("\tTest Case 1.3:   1+0 = 1, c_out = 0 ... ");
        A = 1'b1;
        B = 1'b0;
        expected_result = 1'b1;

        #100; // Wait 
        if (expected_result !== result || carryout !== 1'b0) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait 

        totalTests = totalTests + 1;
        $write("\tTest Case 1.4:   1+1 = 0, c_out = 1 ... ");
        A = 1'b1;
        B = 1'b1;
        expected_result = 1'b0;

        #100; // Wait 
        if (expected_result !== result || carryout !== 1'b1) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait 

        // ----------------------------------------
        // Add more test cases here 
        // ----------------------------------------

        $write("\n-------------------------------------------------------");
        $write("\nTesting complete\nPassed %0d / %0d tests", totalTests-failedTests,totalTests);
        $write("\n-------------------------------------------------------\n");
        $finish;
    end
endmodule