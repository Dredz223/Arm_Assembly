.global main
.align 4
.text
main:
	mov r0, #1
	mov r1, #15
	add r2, r0, r1
	mov r0, #0
	pop {pc}
