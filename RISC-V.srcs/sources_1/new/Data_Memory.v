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
    data_mem[28] = 32'h00000020;
end
endmodule
