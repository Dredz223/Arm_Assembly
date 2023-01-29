.global main
.align 4
.data
format: .asciz "R1=%d\n"
.align 4

main:
	push {lr}
	mov r1, #1
	mov r1, r1, asl #3
	ldr r0, =format
	bl printf
	mov r0, #0
	pop {pc}
//	mov pc, lr
