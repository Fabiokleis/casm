SRC=fasm.asm
OBJ=fasm.o
BIN=fasm
ASSEMBLER=nasm
LINKER=ld


all:
	$(ASSEMBLER) -felf64 src/$(SRC) -o out/$(OBJ)
	$(LINKER) -o out/$(BIN) out/$(OBJ)
run:
	./out/$(BIN)

clean:
	rm -f out/*
