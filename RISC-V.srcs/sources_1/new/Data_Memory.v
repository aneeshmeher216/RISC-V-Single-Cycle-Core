//register file is temporary so it's data might get overwritten so Data memory is used as permanent 

module data_mem(
    input clk, rst,
    input [31:0] A, WD,
    input WE,       // 1--> Write into it, 0--> Read from it

    output [31:0] RD
);

reg [31:0] data_mem[1023:0];

assign RD = (!rst) ? 32'd0 : data_mem[A] ;

always @(posedge clk) begin
    if(WE)
        data_mem[A] <= WD;
end

initial begin
    data_mem[29] = 32'h00000020;
    data_mem[11] = 32'hDEADBEEF;
    data_mem[61] = 32'hFAFAFAFA;
    
    #150 $display("mem[25]= %h",data_mem[25]);
end
endmodule
