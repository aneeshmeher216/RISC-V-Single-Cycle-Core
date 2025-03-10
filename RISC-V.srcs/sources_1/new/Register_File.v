// Temporary Register to Read and Write data into it

module Register_File(
    input clk, rst, WE3,
    input [4:0] A1,A2,A3,
    
    input [31:0] WD3,
    output [31:0] RD1,RD2
);

//reg memory
reg [31:0] reg_mem[31:0];

assign RD1 = (!rst) ? 32'd0 : reg_mem[A1];
assign RD2 = (!rst) ? 32'd0 : reg_mem[A2];

always @(posedge clk) begin
    if(WE3) begin
        reg_mem[A3] <= WD3;
    end
end

initial begin
    reg_mem[5] = 32'h00000006;
    reg_mem[6] = 32'h0000000A;  //32'd10
end

endmodule
