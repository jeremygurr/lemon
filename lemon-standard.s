// parameter stack: 
.set	psp			SP

// return stack: 
.set	rsp			X19

// current word being executed in a list of words: 
.set	current_word_reg	X20

.global _start

.include "features/indirect-threading-mag-2-words.s"

.macro PUSHRSP reg
	str	reg, [psp, #-8]
.endm

.macro POPRSP reg
	ldr	reg, [psp], #8
.endm

.text
.align	4

_start: mov	X0, #1
	INIT_THREADING
	ldr	X1, =helloworld
	mov	X2, #13
	mov	X8, #64			// kernel write function
	svc	0
	mov	X0, #0
	mov	X8, #93			// kernel exit function
	svc	0

.data
helloworld:	.ascii "Hello World!\n"
