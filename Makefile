# Makefile for locality (Comp 40 Assignment 3)
# 
# Includes build rules for a2test and ppmtrans.
#
# This Makefile is more verbose than necessary.  In each assignment
# we will simplify the Makefile using more powerful syntax and implicit rules.
#
# Last updated: February 16, 2016


############## Variables ###############

CC = gcc # The compiler being used

# Compile flags
# Set debugging information, allow the c99 standard,
# max out warnings, and use the updated include path
# CFLAGS = -g -std=c99 -Wall -Wextra -Werror -Wfatal-errors -pedantic $(IFLAGS)
# 
# For this assignment, we have to change things a little.  We need
# to use the GNU 99 standard to get the right items in time.h for the
# the timing support to compile.
# 
CFLAGS = -g -std=gnu99 -Wall

# Libraries needed for linking
# All programs cii40 (Hanson binaries) and *may* need -lm (math)
# 40locality is a catch-all for this assignment, netpbm is needed for pnm
# rt is for the "real time" timing library, which contains the clock support
LDLIBS = -lm -lrt

# Collect all .h files in your directory.
# This way, you can never forget to add
# a local .h file in your dependencies.
#
# This bugs Mark, who dislikes false dependencies, but
# he agrees with Noah that you'll probably spend hours 
# debugging if you forget to put .h files in your 
# dependency list.
INCLUDES = $(shell echo *.h)

############### Rules ###############

all: hex_to_64 fixed_xor single_char_xor

## Compile step (.c files -> .o files)

# To get *any* .o file, compile its .c file with the following rule.
%.o: %.c $(INCLUDES)
	$(CC) $(CFLAGS) -c $< -o $@

## Linking step (.o -> executable program)

hex_to_64: hex_to_64.o bitpack.o cryptography.o
	$(CC) $^ -o $@ $(LDLIBS)

fixed_xor: fixed_xor.o bitpack.o cryptography.o
	$(CC) $^ -o $@ $(LDLIBS)

single_char_xor: single_char_xor.o bitpack.o cryptography.o
	$(CC) $^ -o $@ $(LDLIBS)

clean:
	rm -f hex_to_64 fixed_xor single_char_xor *.o

