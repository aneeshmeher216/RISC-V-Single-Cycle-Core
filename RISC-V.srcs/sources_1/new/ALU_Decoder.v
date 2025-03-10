//Refer Notion -> Projects -> single cycle core Risc V -> Control Unit

module ALU_Decoder(
    input  opcode_5,funct7_5,   // The 5th bit of the funct7 field (used to differentiate between similar instructions like add and sub).
                                //The 5th bit of the opcode (used for RISC-V instruction decoding).
    input [2:0] funct3,         // funct3 is a 3-bit field that specifies the operation type (e.g., add, sub, and, or, etc.). 
    input [1:0] ALUOp,
    
    output reg [2:0] ALUControl
);

wire [1:0] concat = {opcode_5,funct7_5};
 
always @(*) begin
    case(ALUOp)
        2'b00 : ALUControl <= 3'b000;   //add 
        2'b01 : ALUControl <= 3'b001;   //subtract
        2'b10 : begin
                    if(funct3 == 3'b000 ) begin
                        if(concat != 2'b11)   ALUControl <= 3'b000  ; //add
                        else ALUControl <= 3'b001 ; //subtract
                    end
                    else if(funct3 == 3'b010)   ALUControl <= 3'b101 ; //set less than
                    else if(funct3 == 3'b110)   ALUControl <= 3'b011 ;// OR
                    else if(funct3 == 3'b111)   ALUControl <= 3'b111 ;// AND
                    else ALUControl <= 3'b000;
                end
        default: ALUControl <= 3'b000;
    endcase
end

endmodule
