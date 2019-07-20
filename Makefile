all: 
	nasm -f elf main.asm
	ld --strip-all --script=link.ld -o main.exe main.o

clean:
	rm -f *.o *.obj main main.exe