LAN22_DIR = ../22lan
CC = g++
LAN22_FLAGS = #-d4
CFLAGS =


all: utils.22l

utils.22l: utils.22le utils.ext.csv
	$(LAN22_DIR)/22lan_deref.py -s utils.22le

utils.22libe: utils.22le utils.ext.csv
	$(LAN22_DIR)/22lan_deref.py -s utils.22le -l 22lan_extended_library

test.22l: test.22le utils.22libe
	$(LAN22_DIR)/22lan_deref.py -s test.22le -e utils.22libe

test.cpp: test.22l utils.22l
	$(LAN22_DIR)/22lan.py -s test.22l utils.22l -o test.cpp -l cxx $(LAN22_FLAGS)

test: test.cpp
	$(CC) test.cpp -o test $(CFLAGS)

loop_test.22l: loop_test.22le utils.22libe
	$(LAN22_DIR)/22lan_deref.py -s loop_test.22le -e utils.22libe

loop_test.cpp: loop_test.22l utils.22l
	$(LAN22_DIR)/22lan.py -s loop_test.22l utils.22l -o loop_test.cpp -l cxx $(LAN22_FLAGS)

loop_test: loop_test.cpp
	$(CC) loop_test.cpp -o loop_test $(CFLAGS)

clean:
	rm -f utils.22l test.22l test.cpp test utils.22libe loop_test.22l loop_test.cpp loop_test

clean_cpp:
	rm -f test.cpp

clean_cpp_loop:
	rm -f loop_test.cpp
