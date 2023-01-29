.global main
.align 4
.data
format: .asciz "R0=%d R1=%d\n"
.align 4

main:
	push {lr}
	mov r1, #165
	mov r2, #17
	add r2, r1, lsr #3
	mov r1, r1, lsl #2
	ldr r0, =format
	bl printf
	mov r0, #0
	pop {pc}
//	mov pc, lr
