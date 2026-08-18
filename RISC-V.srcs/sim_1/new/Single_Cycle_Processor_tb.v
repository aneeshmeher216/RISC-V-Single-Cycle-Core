module Single_Cycle_Processor_tb();

    reg clk,rst;
    
    Single_Cycle_top dut(.clk(clk),.rst(rst));
    
    initial begin
                rst = 1'b0; clk = 0;
        #10      rst = 1'b1;
        #200    $finish;
    end
    
    always #5 clk = ~clk;

endmodule
