module mux_2X1(
    input [31:0] a,b,
    input s,
    
    output [31:0] c
);

assign c = (!s) ? a : b ;
 
endmodule
