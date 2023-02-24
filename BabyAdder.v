module BabyAdder
  #(parameter WIDTH)
  (input [WIDTH-1:0] a,
   input [WIDTH-1:0] b,
   input cin,
   output [WIDTH-1:0] sum,
   output cout);

  assign {cout, sum} = {1'b0, a} + {1'b0, b} + {{(WIDTH-1){1'b0}},cin};

endmodule

