.global main
.global get_int
.global min
.global max

.section .data
prompt: .asciz "Enter 3 intergers between %d and %d: \n"
pattern: .asciz "%d %d %d"
result: .asciz "Numbers entered are :%d, %d, and %d\n"
min: .asciz "Min: %d"
max: .asciz "Max: %d"
val_1: .word 0
val_2: .word 0
val_3: .word 0
.align 4
.text

main:
	push {lr}
	ldr r4,=val_1
	ldr r5,=val_2
	ldr r6,=val_3
	mov r1,#1
	mov r2,#50
	ldr r0,=prompt
	bl printf

	ldr r0,=pattern
	mov r1, r4
	mov r2, r5
	mov r3, r6
	bl scanf

	ldr r0, =result
	mov r1, r4
	ldr r1, [r1]
	mov r2, r5
	ldr r2, [r2]
	mov r3, r6
	ldr r3, [r3]
	bl printf

	mov r0,#0
	pop {pc}

