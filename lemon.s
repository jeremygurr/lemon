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
word_table:		
	.space 256*256*8
next_word_table_index:	
	.space 2

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
	mov	X8, #linux_write
	svc	0
//	str	SP, [var_S0]
//	ldr	X19, #return_stack_top
	bl	set_up_data_segment
	mov	X0, #0
	mov	X8, #linux_exit
	svc	0

	.data
lemon_version:	
	.ascii "Lemon v0.0.0\n"
lemon_version_end:

        .text
        .set INITIAL_DATA_SEGMENT_SIZE,65536
set_up_data_segment:
        mov	X0, XZR
        mov	X8, #linux_brk
	svc	0
	// Initialise HERE to point at beginning of data segment.
        str	X0, [var_HERE]
	// Reserve nn bytes of memory for initial data segment.
        add	X0, X0, #INITIAL_DATA_SEGMENT_SIZE
	// Call brk(HERE+INITIAL_DATA_SEGMENT_SIZE)
        mov	X8, #linux_brk
	svc	0
        ret

/*
        We allocate static buffers for the return static and input buffer (used when
        reading in files and text that the user types in).
*/
        .set RETURN_STACK_SIZE,8192
        .set BUFFER_SIZE,4096

        .bss
        .align 4096
return_stack:
        .space RETURN_STACK_SIZE
return_stack_top:               // Initial top of return stack.

/* This is used as a temporary input buffer when reading from files or the terminal. */
        .align 4096
buffer:
        .space BUFFER_SIZE
