module Single_Cycle_top(
    input clk,rst
);

wire [31:0] PC_top, PC_plus4, RD_instr, RD1,RD2, 
            Imm_Extend, ALU_result, ReadData, SrcB, Result;
            
wire [1:0] ALUControl_top, ImmSrc;
wire reg_write, MemWrite, ALUSrc, ResultSrc;

PC PC_module(.clk(clk),
            .rst(rst),
            .PC_Next(PC_plus4),
            .PC(PC_top));
            
Instr_Mem inst_mem_module(  .A(PC_top),
                            .rst(rst),
                            .RD(RD_instr));
                            
Register_File reg_file( .clk(clk),
                        .rst(rst),
                        .WE3(reg_write),
                        .A1(RD_instr[19:15]),
                        .A2(RD_instr[24:20]),
                        .A3(RD_instr[11:7]),
                        .WD3(Result),
                        .RD1(RD1),
                        .RD2(RD2));

mux_2X1 mux_regFile_to_ALU(.a(RD2),.b(Imm_Extend),.s(ALUSrc),.c(SrcB));

Sign_Extend imm_extend_module(.Instr(RD_instr),
                              .ImmSrc(ImmSrc[0]),
                              .Imm_Ext(Imm_Extend));
                                

ALU ALU_module( .A(RD1),
                .B(SrcB),
                .AluControl(ALUControl_top),
                .result(ALU_result),
                .C(),
                .Z(),
                .N(),
                .V());
                
Control_Unit Control_Unit_Top(  .opcode(RD_instr[6:0]),
                                .funct7(),
                                .funct3(RD_instr[14:12]),
                                .zero(),
                                .PCsrc(),
                                .RegWrite(reg_write),
                                .ALUSrc(ALUSrc),
                                .MemWrite(MemWrite),
                                .ResultSrc(ResultSrc),
                                .ImmSrc(ImmSrc),
                                .ALUControl(ALUControl_top));

mux_2X1 mux_dataMem_to_regFile(.a(ALU_result),.b(ReadData),.s(ResultSrc),.c(Result));

data_mem Data_Memory(.clk(clk),
                     .rst(rst),
                     .A(ALU_result),
                     .WE(MemWrite),       
                     .WD(RD2),
                     .RD(ReadData));  
                     
PC_adder pc_incrementer(.a(PC_top),.b(32'd4),.c(PC_plus4)); 
      
endmodule
