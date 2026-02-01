module mux2x1 #(
    parameter WIDTH = 32
) (
    input sel,
    input [WIDTH -1:0] A,B,
    output [WIDTH -1:0] O
);

    assign O = (sel)? B : A;
    
endmodule