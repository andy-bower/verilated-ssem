module top
  (input clk,
   input rst,
   output reg stop,
   output [2:0] tick_mon,
   output [31:0] ac_mon,
   output [31:0] ci_mon,
   output [31:0] pi_mon);

  reg [2:0] tick;

  reg [31:0] ac_d;
  reg [31:0] ci_d;

  wire [31:0] ac_q;
  wire [31:0] ci_q;
  wire [31:0] pi_q;
  wire [31:0] mem_q;

  wire t0 = tick == 3'd0;
  wire t1 = tick == 3'd1;
  wire t2 = tick == 3'd2;
  wire t3 = tick == 3'd3;
  wire t4 = tick == 3'd4;
  wire t5 = tick == 3'd5;

  assign ac_mon = ac_q;
  assign ci_mon = ci_q;
  assign pi_mon = pi_q;
  assign tick_mon = tick;

  /* verilator lint_off PINCONNECTEMPTY */
  /* verilator lint_off UNUSED */

  wire [2:0] opcode = pi_q[15:13];
  wire [12:0] operand = pi_q[12:0];

  wire I_JMP = opcode == 3'd0;
  wire I_JRP = opcode == 3'd1;
  wire I_LDN = opcode == 3'd2;
  wire I_STO = opcode == 3'd3;
  wire I_SUB = opcode == 3'd4 || opcode == 3'd5;
  wire I_SKN = opcode == 3'd6;
  wire I_HLT = opcode == 3'd7;

  BabyReg #(.WIDTH(32)) pi(.clk(clk), .rst(rst), .q(pi_q),
    .d(mem_q),
    .we(t2));

  BabyAdder #(.WIDTH(32)) ac_adder(
    .a(I_LDN ? ac_q : 0),
    .b(~mem_q), /* Turn adder into subtractor by inverting */
    .cin(1'b1), /* input and adding one via carry in */
    .sum(ac_d),
    .cout());

  BabyReg #(.WIDTH(32)) ac(.clk(clk), .rst(rst), .d(ac_d), .q(ac_q),
    .we(t4 && (I_LDN || I_SUB)));

  BabyAdder #(.WIDTH(32)) ci_adder(
    .a(I_JMP && t5 ? 32'd0 : pi_q),
    .b((I_JMP || I_JRP) && t5 ? mem_q : 32'd1),
    .cin(1'b0),
    .sum(ci_d),
    .cout());

  BabyReg #(.WIDTH(32)) ci(.clk(clk), .rst(rst), .d(ci_d), .q(ci_q),
    .we(t0 || t5 && (I_JMP || I_JRP || I_SKN && ac_q[31])));

  BabyStore #(.DWIDTH(32), .AWIDTH(5)) store(.clk(clk), .mrst(rst), .q(mem_q),
    .a(t1 ? ci_q[4:0] : operand[4:0]),
    .we(t3 && I_STO),
    .d(ac_q));

  initial begin
    stop = 1'b0;
  end

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      stop <= 1'b0;
    end
    else begin
      if (t4 && I_HLT)
        stop <= 1'b1;
     tick <= tick == 5 ? 0 : tick + 1;
    end
  end

endmodule
