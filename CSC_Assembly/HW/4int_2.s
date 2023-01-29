.section .data
/* Prompt message */
prompt: .asciz "Enter four integer values: "

/* Response message */
response_1: .asciz "You entered %d, %d, %d, %d.\n"
response_2: .asciz "The smallest value is %d.\n"
response_3: .asciz "The largest value is %d.\n"
response_4: .asciz "The sum of all the values is: %d.\n"
response_5: .asciz "The average of all values is: %d.\n"

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

	ldr r4, =value_read1    /* r1 contains pointer to variable label where our first number is stored */
        ldr r5, =value_read2    /* r2 contains pointer to variable label where our second number is stored */
        ldr r6, =value_read3
        ldr r7, =value_read4

    	ldr r0, =prompt		/* r0 contains pointer to prompt message */
    	bl printf		/* call printf to output our prompt */

    	ldr r0, =pattern 	/* r0 contains pointer to format string for our scan pattern */
    	mov r1, r4  	/* r1 contains pointer to variable label where our first number is stored */
	mov r2, r5	/* r2 contains pointer to variable label where our second number is stored */
	mov r3, r6
	mov r8, r7
	push {r8}
    	bl scanf              	/* call to scanf */
	add sp, #4

	ldr r0, =response_1 	/* r0 contains pointer to response message */
	mov r1, r4	/* r1 contains pointer to value_read1 */
	ldr r1, [r1]		/* r1 contains value dereferenced from r1 in previous instruction */
	mov r2, r5
	ldr r2, [r2]
	mov r3, r6
	ldr r3, [r3]
	mov r8, r7
	ldr r8, [r8]
	push {r8}
	bl printf		/* call printf to output our response */

	ldr r0, =response_2

	bl printf

	ldr r0, =response_3
//	cmp r4, r5
//	movgt r9, r4		// if r4 > r5, r9 = r4
//	ldr r9, [r9]
//	movlt r10, r4		// if r4 < r5, r10 = r4
//	ldr r10, [r10]
	bl printf

	add r11, r4, r5
	add r11, r11, r6
	add r11, r11, r7
	mov r1 , r11
	ldr r0, =response_4
	bl printf

	ldr r0, =response_5
	bl printf
	add sp, #4

	mov r0, #0		/* exit code 0 = program terminated normally */
	pop {pc}		/* exit our main function */

