module top;
  reg s000;
  reg c000;
  reg s001;
  reg c001;
  reg s010;
  reg c010;
  reg s011;
  reg c011;
  reg s100;
  reg c100;
  reg s101;
  reg c101;
  reg s110;
  reg c110;
  reg s111;
  reg c111;

  FullAdder a000 (1'b0, 1'b0, 1'b0, s000, c000);
  FullAdder a001 (1'b0, 1'b0, 1'b1, s001, c001);
  FullAdder a010 (1'b0, 1'b1, 1'b0, s010, c010);
  FullAdder a011 (1'b0, 1'b1, 1'b1, s011, c011);
  FullAdder a100 (1'b1, 1'b0, 1'b0, s100, c100);
  FullAdder a101 (1'b1, 1'b0, 1'b1, s101, c101);
  FullAdder a110 (1'b1, 1'b1, 1'b0, s110, c110);
  FullAdder a111 (1'b1, 1'b1, 1'b1, s111, c111);

  initial begin
    $display("0+0+0 = %d", {c000, s000});
    $display("0+0+1 = %d", {c001, s001});
    $display("0+1+0 = %d", {c010, s010});
    $display("0+1+1 = %d", {c011, s011});
    $display("1+0+0 = %d", {c100, s100});
    $display("1+0+1 = %d", {c101, s101});
    $display("1+1+0 = %d", {c110, s110});
    $display("1+1+1 = %d", {c111, s111});
    $finish;
  end
endmodule
