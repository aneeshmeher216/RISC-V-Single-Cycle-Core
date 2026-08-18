module Sign_Extend(
    input [31:0] Instr,
    input [1:0] ImmSrc,
    output [31:0] Imm_Ext
);

//ImmSrc == 01 --> Store Word inst.(S type) , ImmSrc == 00 --> Load Word Inst.(I type)
// ImmSrc == 10 -> Branch(B-type)
assign Imm_Ext = (ImmSrc == 2'b01 ) ? {{20{Instr[31]}},Instr[31:25],Instr[11:7]} :  
                 (ImmSrc == 2'b00 ) ? {{20{Instr[31]}},Instr[31:20]} :
                 (ImmSrc == 2'b10 ) ? {{20{Instr[31]}}, Instr[7], Instr[30:25], Instr[11:8], 1'b0} : 32'd0 ;


endmodule
