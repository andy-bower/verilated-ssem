# apt-get install verilator

main: top.v FullAdder.v main.cpp
	verilator -Wall --cc top.v --exe --build main.cpp

.PHONY: run
run:
	obj_dir/Vtop
