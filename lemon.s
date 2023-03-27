// parameter stack: SP
// return stack: X19
// current word being executed in a list of words: X20

// linux system calls
.set	linux_write,64
.set	linux_exit,93
.set	linux_brk,214

.global _start

// this table translates 16 bit word indexes into 64 bit pointers to the word definition
.bss
.align 	8
word_table:		.space 256*256*8
next_word_table_index:	.space 2

// word_table_reg=X21

// used at end of L0 words
.macro NEXT
	ldrh	X0, [next_word_reg], #2 // doubt it supports post indexing
	add	X0, X21, X0, lsl #3
	br	X0
.endm

.macro DOCOL3
	PUSHRSP	X20
	// X0 is pointing to codeword
	add	X20, X0, #8
	// next_word_reg is pointing to first word after codeword
	NEXT
.endm

.macro PUSHRSP reg
	str	reg, [X19, #-8]
.endm

.macro POPRSP reg
	ldr	reg, [X19], #8
.endm

.text
.align	4

_start: mov	X0, #1
	
	ldr	X1, =lemon_version
	mov	X2, #lemon_version_end-lemon_version
	mov	X8, #64			// kernel write function
	svc	0
//	str	SP, [var_S0]
//	ldr	X19, #return_stack_top
	mov	X0, #0
	mov	X8, #93			// kernel exit function
	svc	0

.data
lemon_version:	.ascii "Lemon v0.0.0\n"
lemon_version_end:
