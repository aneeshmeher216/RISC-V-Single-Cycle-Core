
module ALU(
    input [31:0] A,B,
    input [2:0] AluControl,
    
    output reg [31:0] result,
    output C,Z,N,V              // C = Carry flag, Z = checks if result is zero, N = Negative flag, V = Overflow flag
);
    
wire [31:0] sum, bitwise_and, bitwise_or;
wire [31:0] mux1;
wire cout;
wire slt;

assign bitwise_and = A & B;
assign bitwise_or = A | B;

assign mux1 = AluControl[0] ? ~B : B ;

assign {cout,sum} = A + mux1 +  AluControl[0];   // AluControl[0] = 0 --> addition , AluControl[1] = 1 --> subtraction
                                          // For subtraction we are using 2's Complement A + (~B) gives 1's comlement and if we add 1 to the result it becomes 2's complememnt 
//in slt opeartion, if A < B result is set to 1 else 0(including the sign);
assign slt = ($signed(A) < $signed(B));

always @(*) begin
    case(AluControl)
        3'b000 : result = sum;
        3'b001 : result = sum;
        3'b010 : result = bitwise_and;
        3'b011 : result = bitwise_or;
        3'b100 : result = {31'd0, slt};
        default : result = 32'd0;
    endcase    
end

//Flags Assignment
assign Z = &(~result) ;
assign N = result[31];
assign C = (AluControl == 3'b000) ? cout : 0; // to ensure Carry flag is obtained only when sum is done. In case of Subtraction if A>B then cout will be 1 and we dont want cout to be 1 in case of subtraction
assign V = (~AluControl[1]) & (A[31] ^ sum[31]) & (~ (A[31] ^ B[31] ^ AluControl[0]));

endmodule
