`timescale 1us/1ns

module pipelined_processor_tb;

reg clk, reset;

pipelined_processor uut ( clk, reset );

always #10 clk = ~clk;

initial begin 
    $dumpvars();
    clk = 0;
    reset = 1'b1;
 
    #20
    reset = 1'b0;

   #500 $finish;  
 end
 
endmodule