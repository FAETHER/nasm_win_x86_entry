all: 
	nasm -f elf -g main.asm
	ld -o main.exe main.o

clean:
	rm -f *.o *.obj main main.exe