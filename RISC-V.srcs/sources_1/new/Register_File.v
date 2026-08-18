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
//only writing happens at clock edge. Read happens as soon as address is received.
always @(posedge clk) begin
    if(WE3) begin
        reg_mem[A3] <= WD3;
    end
end

initial begin
    reg_mem[5] = 32'h00000006;
    reg_mem[6] = 32'h0000000A;  
    reg_mem[8] = 32'h00000015;
    reg_mem[7] = 32'hFEDCBA98;
    reg_mem[9] = 32'h0000000F;  
    reg_mem[22] = 32'hF1E2D3C4;
    reg_mem[24] = 32'd7;
    reg_mem[25] = 32'd14;
    reg_mem[26] = -32'sd5;
    reg_mem[27] = 32'h1A2A3A4A;
    reg_mem[28] = 32'h01234567;
    reg_mem[29] = 32'd5;

#150  $display("x18 = %h", reg_mem[18]);
    $display("x19 = %h", reg_mem[19]);
    $display("x20 = %h", reg_mem[20]);
    $display("x21 = %h", reg_mem[21]);
    $display("x23 = %h", reg_mem[23]);
end


endmodule
