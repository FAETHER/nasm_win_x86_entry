all: 
	nasm -f elf -g main.asm
	#ld --strip-all --verbose > ll.ld -o main.exe main.o
	ld --script=link.ld -o main.exe main.o

clean:
	rm -f *.o *.obj main main.exe