.equ LOW, 0
.equ HIGH, 1
.equ INPUT, 0
.equ OUTPUT, 1
//LEDS :D
.equ RED_LED, 0
.equ YLW_LED, 1
.equ GRN_LED, 2
.equ RMN_LED, 3
.equ GMN_LED, 4
.equ BTTN, 8
.equ END, 9
starting: .asciz "Starting!\n"
ending:   .asciz "Ending!\n"
button:   .asciz "Push Button to stop!\n"
pressed:  .asciz "Pressed!\n"
walk:	  .asciz "Walk Now!\n"
test:	  .asciz "In Blinking Loop\n"
num:	  .asciz "Iteration %d\n"
isnum:	  .asciz "The current num is: %d\n"
.global main
.align 4

main:
	push {lr}
	bl wiringPiSetup
	ldr r0, =starting
	bl printf
	mov r4, #0
loop:
	mov r0, #RMN_LED
	mov r1, #OUTPUT
	bl pinMode

	mov r0, #GMN_LED
	mov r1, #OUTPUT
	bl pinMode

//Red man LED, stay on forever until button is pressed
	mov r0, #RMN_LED
	mov r1, #HIGH
	bl digitalWrite

//Cycles through Red, Yellow, Green
	mov r0, #RED_LED
	mov r1, #OUTPUT
	bl pinMode

	mov r0, #RED_LED
	mov r1, #HIGH
	bl digitalWrite

	ldr r0, =#3500
	bl delay

	mov r0, #RED_LED
        mov r1, #LOW
        bl digitalWrite

//Check to end program entirely
	mov r0, #END
	bl digitalRead
	cmp r0, #LOW
	beq end_prg
/******************************/
	mov r0, #GRN_LED
	mov r1, #OUTPUT
	bl pinMode

	mov r0, #GRN_LED
	mov r1, #HIGH
	bl digitalWrite

	ldr r0, =#3000
	bl delay

	mov r0, #GRN_LED
        mov r1, #LOW
        bl digitalWrite

//Check to end program entirely
	mov r0, #END
	bl digitalRead
	cmp r0, #LOW
	beq end_prg
/******************************/
	mov r0, #YLW_LED
	mov r1, #OUTPUT
	bl pinMode

	mov r0, #YLW_LED
	mov r1, #HIGH
	bl digitalWrite

	ldr r0, =#1500
	bl delay

	mov r0, #YLW_LED
	mov r1, #LOW
	bl digitalWrite

//Check to end program entirely
	mov r0, #END
	bl digitalRead
	cmp r0, #LOW
	beq end_prg
/******************************/

//Check if button is being pressed to jump out of loop
//and go to button function
	mov r0, #BTTN
	bl digitalRead
	cmp r0, #HIGH
	bne end_loop
	b loop

end_loop:

//Turn on Red Traffic Led
	mov r0, #RED_LED
	mov r1, #HIGH
	bl digitalWrite

//Turn off Red walk Led
	mov r0, #RMN_LED
	mov r1, #LOW
	bl digitalWrite

//Turn on Green Walk Led
	mov r0, #GMN_LED
	mov r1, #HIGH
	bl digitalWrite

	ldr r0, =#2000
	bl delay

	mov r0, #GMN_LED
	mov r1, #LOW
	bl digitalWrite
	bl flashing
	b loop
flashing:
	push {lr}
	mov r1, r4
	ldr r0, =num
	bl printf
	bl Rmn_on
	bl Rmn_off
	bl Gmn_on
	bl Gmn_off
	cmp r4, #5
	movge r4, #0
	beq loop
	add r4, #1
	blt flashing
	pop {pc}
Rmn_on:
	push {lr}
	mov r0, #RMN_LED
	mov r1, #HIGH
	bl digitalWrite
	pop {pc}
Rmn_off:
	push {lr}
	ldr r0, =#250
	bl delay

	mov r0, #RMN_LED
	mov r1, #LOW
	bl digitalWrite
	pop {pc}
Gmn_on:
	push {lr}
	mov r0, #GMN_LED
	mov r1, #HIGH
	bl digitalWrite
	pop {pc}
Gmn_off:
	push {lr}
	ldr r0, =#250
	bl delay

	mov r0, #GMN_LED
	mov r1, #LOW
	bl digitalWrite
	pop {pc}
end_prg:
	mov r0, #RED_LED
	mov r1, #LOW
	bl digitalWrite

	mov r0, #GRN_LED
	mov r1, #LOW
	bl digitalWrite

	mov r0, #YLW_LED
	mov r1, #LOW
	bl digitalWrite

	mov r0, #RMN_LED
	mov r1, #LOW
	bl digitalWrite

	mov r0, #GMN_LED
	mov r1, #LOW
	bl digitalWrite

	ldr r0, =ending
	bl printf

	mov r0, #0
	pop {pc}
