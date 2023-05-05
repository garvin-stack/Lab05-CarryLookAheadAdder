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

module ripple_carry_adder_tb;
    parameter NUMBITS = 4;

    // Inputs
    reg clk;
    reg reset;
    reg [NUMBITS-1:0] A;
    reg [NUMBITS-1:0] B;
    
    // Outputs
    wire [NUMBITS-1:0] result;
    reg [NUMBITS-1:0] expected_result;
    wire carryout;
    

    // -------------------------------------------------------
    // Setup output file for possible debugging uses
    // -------------------------------------------------------
    initial
    begin
        $dumpfile("lab03.vcd");
        $dumpvars(0);
    end

    // -------------------------------------------------------
    // Instantiate the Unit Under Test (UUT)
    // -------------------------------------------------------
    carry_look_ahead_adder #(.NUMBITS(NUMBITS)) uut (
        .A(A), 
        .B(B), 
        .carryin(1'b0),
        .result(result), 
        .carryout(carryout)
    );
  
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

        // Additional test cases
        // ---------------------------------------------
        // Testing unsigned additions 
        // --------------------------------------------- 
        $write("Test Group 1: Addition Behavior Verification ... \n");

        // Code necessary for each test case 
        totalTests = totalTests + 1;
        $write("\tTest Case 1.1:   0+  0 =   0, c_out = 0 ... ");
        A = 4'h0;
        B = 4'h0;
        expected_result = 4'h0;

        #100; // Wait 
        if (expected_result !== result || carryout !== 1'b0) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait 
        
        // Code necessary for each test case 
        totalTests = totalTests + 1;
        $write("\tTest Case 1.2: 127+  1 = 128, c_out = 0 ... ");
        A = 4'h7;
        B = 4'h1;
        expected_result = 4'h8;

        #100; // Wait 
        if (expected_result !== result || carryout !== 1'b0) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait 

        // Code necessary for each test case 
        totalTests = totalTests + 1;
        $write("\tTest Case 1.3: 255+  1 =   0, c_out = 1 ... ");
        A = 4'hF;
        B = 4'h1;
        expected_result = 4'h0;

        #100; // Wait 
        if (expected_result !== result || carryout !== 1'b1) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait 

        // Code necessary for each test case 
        totalTests = totalTests + 1;
        $write("\tTest Case 1.4: 123+ 46 = 169, c_out = 0 ... ");
        A = 4'd12;
        B = 4'd2;
        expected_result = 4'd14;

        #100; // Wait 
        if (expected_result !== result || carryout !== 1'b0) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait 

        // Code necessary for each test case 
        totalTests = totalTests + 1;
        $write("\tTest Case 1.5: 123+146 =  13, c_out = 1 ... ");
        A = 4'd12;
        B = 4'd6;
        expected_result = 4'd2;

        #100; // Wait 
        if (expected_result !== result || carryout !== 1'b1) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait 

        // -------------------------------------------------------
        // End testing
        // -------------------------------------------------------
        $write("\n-------------------------------------------------------");
        $write("\nTesting complete\nPassed %0d / %0d tests", totalTests-failedTests,totalTests);
        $write("\n-------------------------------------------------------\n");
        $finish;
    end
endmodule