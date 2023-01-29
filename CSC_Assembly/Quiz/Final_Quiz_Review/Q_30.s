.global main
.align 4
.data
format: .asciz "R0=%d\n"
.align 4

main:
//	push {lr}
	mov r0, #5
	mov r1, #2
	add r0, r1
	mov r0, r0, asl#2
	mov r1, r0
	ldr r0, =format
	bl printf

	mov r0, #0
//	pop {pc}
	mov pc, lr
