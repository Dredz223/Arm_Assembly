// bare bones source file 
.global main

.align 4
.section .rodata
// all constant data goes here
format_string: .asciz "%d + %d = %d\n"
.align 4
.section .bss
// all uninitialized data goes here
.align 4
.data
// all non-constant, initialized data goes here

.align 4
.text
main:
	push {lr}
	mov  r4, #-3	// r0 = -3
	mov  r5, #2	// r1 = 2
	adds r6,r4,r5	// r6=r4+r5, set status flag if warranted

	ldr r0,=format_string	//r0 = &format_string
	mov r1,r4	//r1=r4
	mov r2,r5	//r2=r5
	mov r3,r6	//r3=r6

	bl printf

	mov r0, #0 // return code for your program (must be 8 bits)
	pop {pc}

