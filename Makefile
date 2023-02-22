main: top.v FullAdder.v main.cpp
	verilator -Wall --cc top.v --exe --build main.cpp
