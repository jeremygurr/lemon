// parameter stack: 
.set	p_stack		X19

// return stack: 
.set	r_stack		X20

// current word being executed in a list of words: 
.set	current_word	X21

.global _start

.macro NEXT
	ldr	X0, [current_word], #8
	br	X0
.endm

_start: mov	X0, #1
	ldr	X1, =helloworld
	mov	X2, #13
	mov	X8, #64			// kernel write function
	svc	0
	mov	X0, #0
	mov	X8, #93			// kernel exit function
	svc	0

.data
helloworld:	.ascii "Hello World!\n"
