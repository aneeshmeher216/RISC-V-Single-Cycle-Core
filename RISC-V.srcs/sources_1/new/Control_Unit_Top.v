module Control_Unit(
    input [6:0]opcode, funct7,
    input [2:0] funct3,
    input zero,
      
    output PCsrc, RegWrite, ALUSrc, MemWrite, ResultSrc,
    output [1:0] ImmSrc,
    output [2:0] ALUControl
);

wire [1:0] ALU_Op;

Main_Decoder Main_Decoder_1(.opcode(opcode),
                            .zero(zero),
                            .PCsrc(PCsrc),
                            .RegWrite(RegWrite),
                            .ALUSrc(ALUSrc),
                            .MemWrite(MemWrite),
                            .ResultSrc(ResultSrc),
                            .ImmSrc(ImmSrc),
                            .ALUOp(ALU_Op));

ALU_Decoder ALU_Decoder_1(.opcode_5(opcode[5]),
                            .funct7_5(funct7[5]),                                      
                            .funct3(funct3),
                            .ALUOp(ALU_Op),
                            .ALUControl(ALUControl));


endmodule
