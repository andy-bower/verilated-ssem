#include "Vtop.h"
#include "verilated.h"

vluint64_t sim_time;

double sc_time_stamp () {
  return sim_time;
}

int main(int argc, char *argv[]) {
  Verilated::commandArgs(argc, argv);
  Vtop *top = new Vtop;
  uint64_t cycles;

  cycles = 0;
  sim_time = 0;
  top->rst = 1;

  while (!Verilated::gotFinish()) {
    if (sim_time == 1)
      top->rst = 0;
    top->clk = sim_time & 1;
    top->eval();
    if (top->clk)
      cycles++;
    printf("%" PRIu64 ": %" PRIu64 " t%d ci %x pi %x ac %x\n", sim_time, cycles, top->tick_mon, top->ci_mon, top->pi_mon, top->ac_mon);
    sim_time++;
  }

  top->final();
  delete top;

  return 0;
}

