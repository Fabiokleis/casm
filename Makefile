SRC=casm.asm
OBJ=casm.o
BIN=casm
ASSEMBLER=nasm
ASSEMBLER_FLAGS=-g -dwarf2
LINKER=gcc
LINKER_FLAGS=-g -no-pie


all:
	$(ASSEMBLER) $(ASSEMBLER_FLAGS) -felf64 src/$(SRC) -o out/$(OBJ)
	$(LINKER) $(LINKER_FLAGS) -o out/$(BIN) out/$(OBJ)

clean:
	rm -f out/*
