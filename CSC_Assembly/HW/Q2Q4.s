.global main
.data
output_msg: .asciz "R4=%d, R5=%d, R6=%d\n"
.text
.align 2

main:
	push {lr}

	ldr r0, =output_msg
	mov r4, #101
	mov r5, #1
	and r1, r4, r5
	orr r2, r4, r5
	eor r3, r4, r5
	bl printf

	mov r0, #0
	pop {pc}

