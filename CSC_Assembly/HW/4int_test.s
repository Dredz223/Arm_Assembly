.section .data
/* Prompt message */
prompt: .asciz "Please type in 4 integer values (seperated by a space): "

/* Response message */
response: .asciz "I read the numbers %d, %d, %d, and %d from the keyboard\n"

/* Format pattern for scanf */
pattern: .asciz "%d %d %d %d"

/* Where scanf will store the number read */
value_read1: .word 0
value_read2: .word 0
value_read3: .word 0
value_read4: .word 0

.section .text
.global main
main:
	push {lr}		/* save our return address */

	// use r5, r6, r7, r8 as registers holding pointers to value_read1, and value_read2
	ldr r5, =value_read1
	ldr r6, =value_read2
	ldr r7, =value_read3
	ldr r8, =value_read4

    	ldr r0, =prompt		/* r0 contains pointer to prompt message */
    	bl printf		/* call printf to output our prompt */

    	ldr r0, =pattern 	/* r0 contains pointer to format string for our scan pattern */
    	mov r1, r5	  	/* r1 contains pointer to variable label where our first number is stored */
	mov r2, r6		/* r2 contains pointer to variable label where our second number is stored */
	mov r3, r7		/**/
	mov r4, r8
    	bl scanf              	/* call to scanf */
next:
	// do whatever it is we need

	// output any response at the end of program
	ldr r0, =response	/* r0 contains pointer to response message */
	mov r1, r5		/* r5 contains pointer to value_read1 */
	ldr r1, [r1]		/* r1 contains value dereferenced from r1 in previous instruction */
	mov r2, r6
	ldr r2, [r2]
	mov r3, r7
	ldr r3, [r3]
	mov r4, r8
	ldr r4, [r4]
	push {r4}
	bl printf		/* call printf to output our response */
	add sp,#4

	mov r0, #0		/* exit code 0 = program terminated normally */
	pop {pc}		/* exit our main function */
