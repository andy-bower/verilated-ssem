module BabyStore
  #(parameter DWIDTH,
    parameter AWIDTH)
  (
   input clk,
   input mrst,
   input [AWIDTH-1:0] a,
   input [DWIDTH-1:0] d,
   input we,
   output reg [DWIDTH-1:0] q
  );

  reg [DWIDTH-1:0] lines [((1 << AWIDTH)-1):0];

  int i;

  always @(posedge clk or posedge mrst) begin
    if (mrst)
      for (i = 0; i < (1 << AWIDTH); i++) begin
        lines[i] <= {(DWIDTH){1'b0}};
      end
    else if (we)
      lines[a] <= d;
    else
      q <= lines[a];
  end

endmodule

