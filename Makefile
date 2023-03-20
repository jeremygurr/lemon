lemon: lemon.o
	ld -o lemon lemon.o

lemon.o: lemon.s
	as -o lemon.o lemon.s
