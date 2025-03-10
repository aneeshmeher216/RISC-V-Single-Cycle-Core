//Refer Notion -> Projects -> single cycle core Risc V -> Control Unit

module Main_Decoder(
    input [6:0]opcode,
    input zero,
    
    output PCsrc, RegWrite, ALUSrc, MemWrite, ResultSrc,
    output [1:0] ImmSrc, ALUOp
);

wire branch;

assign RegWrite = (opcode == 7'b0000011 | opcode == 7'b0110011) ? 1'b1 : 1'b0 ;

assign ImmSrc = (opcode == 7'b0100011) ? 2'b01 : (opcode == 1100011) ? 2'b10 : 2'b00 ; 

assign ALUSrc = (opcode == 7'b0000011 | opcode == 7'b0100011) ? 1'b1 : 1'b0 ;

assign MemWrite = (opcode == 7'b0100011) ? 1'b1 : 1'b0 ;

assign ResultSrc = (opcode == 7'b0000011) ? 1'b1 : 1'b0 ;

assign branch = (opcode == 7'b1100011) ? 1'b1 : 1'b0 ;

assign ALUOp = (opcode == 7'b0110011) ? 2'b10 : (opcode == 7'b1100011) ? 2'b01 : 2'b00 ;  

assign PCsrc = branch & zero ; 

endmodule
