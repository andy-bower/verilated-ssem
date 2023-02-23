module FullAdder( input io_a,
                  input io_b,
                  input io_cin,
                  output io_sum,
                  output io_cout
                );

  assign io_sum = io_a ^ io_b ^ io_cin;
  assign io_cout = io_a & io_b | io_a & io_cin | io_b & io_cin;
endmodule
