module BabyReg
  #(parameter WIDTH)
  (
   input clk,
   input rst,
   input [WIDTH-1:0] d,
   input we,
   output reg [WIDTH-1:0] q
  );

  always @(posedge clk or posedge rst) begin
    if (rst)
      q <= {{(WIDTH){1'b1}}};
    else if (we)
      q <= d;
  end

endmodule

