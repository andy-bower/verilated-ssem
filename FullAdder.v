module FullAdder( input io_a,
                  input io_b,
                  input io_cin,
                  output io_sum,
                  output io_cout
                );
  wire a_xor_b;
  wire a_and_b;
  wire b_and_cin;

  assign a_xor_b = io_a ^ io_b;
  assign io_sum = a_xor_b ^ io_cin;
  assign a_and_b = io_a & io_b;
  assign b_and_cin = io_b & io_cin;
  assign a_and_cin = a_and_b | b_and_cin;
endmodule
