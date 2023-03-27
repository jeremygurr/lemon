lemon: lemon.o
	ld -o lemon lemon.o

lemon.o: lemon.s
	as -o lemon.o lemon.s

lemon.s: lemon-standard.s.bt
	bash -c "source shell-start.sh; cat lemon-standard.s.bt | hydrate >lemon.s"

clean:
	rm lemon.o lemon.s

