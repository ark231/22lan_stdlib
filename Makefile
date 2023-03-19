LAN22_DIR = ../22lan
CC = g++
LAN22_FLAGS = #-d4
CFLAGS =


all: utils.22l

utils.22l: utils.22le utils.ext.csv
	$(LAN22_DIR)/22lan_deref.py -s utils.22le

utils.22libe: utils.22le utils.ext.csv
	$(LAN22_DIR)/22lan_deref.py -s utils.22le -l 22lan_extended_library

test: test.22le test.ext.csv utils.22l utils.22libe
	$(LAN22_DIR)/22lan_deref.py -s test.22le -e utils.22libe
	$(LAN22_DIR)/22lan.py -s test.22l utils.22l -o test.cpp -l cxx $(LAN22_FLAGS)
	$(CC) test.cpp -o test $(CFLAGS)

clean:
	rm -f utils.22l test.22l test.cpp test utils.22libe
