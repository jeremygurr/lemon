// parameter stack: SP
// return stack: X19
// current word being executed in a list of words: X20

.global _start

// this table translates 16 bit word indexes into 64 bit pointers to the word definition
.bss
.align 	8
word_table:		.space 256*256*8
next_word_table_index:	.space 2

// word_table_reg=X21
// used at end of L0 words
.macro NEXT
ldrh	X0, [current_word], #2 // doubt it supports post indexing
add	X0, X21, X0, lsl #3
br	X0
.endm

.macro PUSHRSP reg
str	reg, [SP, #-8]
.endm

.macro POPRSP reg
ldr	reg, [SP], #8
.endm

.text
.align	4

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
