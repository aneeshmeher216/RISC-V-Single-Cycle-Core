`timescale 1ns / 1ps
 
module Instr_Mem(
    input [31:0] A,     //A is an address to obtain instruction from memory
    input rst,          //active low reset.
    
    output [31:0] RD
 );
 //Meomory Creation
 reg [31:0] mem[1023:0];
 
 assign RD = (rst == 1'b0) ? 32'h00000000 : mem[A[31:2]];
 
 initial begin
//    mem[0] = 32'hFFC4A303;
//    mem[1] = 32'h00832383;
    mem[0] = 32'h0064A423;
    mem[0] =32'h0062E233;
 end
 
endmodule
