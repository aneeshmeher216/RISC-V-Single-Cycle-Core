module Single_Cycle_Processor_tb();

    reg clk,rst;
    
    Single_Cycle_top dut(.clk(clk),.rst(rst));
    
    initial begin
                rst = 1'b0; clk = 0;
        #100    rst = 1'b1;
        #300    $finish;
    end
    
    always begin
        #50 clk = ~clk;
    end



endmodule
