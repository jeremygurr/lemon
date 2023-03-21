// this table translates 16 bit word indexes into 64 bit pointers to the word definition
.bss
.align 	8
word_table:		.space 256*256*8
next_word_table_index:	.space 2

.set 	word_table_reg	X21

.macro INIT_THREADING
	ldr	word_table_reg, word_table	// probably need to split this
.endm

// used at end of L0 words
.macro NEXT
	ldrh	X0, [current_word], #2 // doubt it supports post indexing
	add	X0, word_table_reg, X0, lsl #3
	br	X0
.endm

