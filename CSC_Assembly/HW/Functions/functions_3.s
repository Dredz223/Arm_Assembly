.global main
.global get_int
.global min
.global max

.section .data
prompt: .asciz "Enter 3 intergers between %d and %d: \n"
pattern: .asciz "%d %d %d"
result: .asciz "Numbers entered are: %d, %d, and %d\n"
mintxt: .asciz "Min: %d\n"
maxtxt: .asciz "Max: %d\n"
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
	mov r7,#1
	mov r8,#50
	mov r1, r7
	mov r2, r8
	bl get_int
	pop {pc}

get_int:
	push {lr}
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
	bl min
	bl max
	pop {pc}
min:
 	push {lr}
	ldr r0,=mintxt
	cmp r2, r1
	movlt r7, r2
	movge r7, r1
	cmp r3, r7
	movlt r7, r3
	mov r1, r7
	bl printf
	pop {pc}

max:
	push {lr}
	ldr r0,=maxtxt
	cmp r2, r1
	movgt r8, r2
	movle r8, r1
	cmp r3, r8
	movgt r8, r3
	mov r1, r8
	bl printf
	pop {pc}
