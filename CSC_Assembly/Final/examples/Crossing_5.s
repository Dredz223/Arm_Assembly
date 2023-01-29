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

starting: .asciz "Starting!\n"
ending:   .asciz "Ending!\n"
button:   .asciz "Push Button to stop!\n"
pressed:  .asciz "Pressed!\n"
walk:	  .asciz "Walk Now!\n"

.global main
.align 4

main:
	push {lr}
	bl wiringPiSetup
	ldr r0, =starting
	mov r2, #0
	bl printf
	bl loop

	mov r0, #RMN_LED
	mov r1, #OUTPUT
	bl pinMode

	mov r0, #GMN_LED
	mov r1, #OUTPUT
	bl pinMode

	mov r0, #RED_LED
	mov r1, #OUTPUT
	bl pinMode

	mov r0, #GRN_LED
	mov r1, #OUTPUT
	bl pinMode

	mov r0, #YLW_LED
	mov r1, #OUTPUT
	bl pinMode

	mov r0, #BTTN
	mov r1, #INPUT
	bl pinMode

loop:
//Red man LED, stay on forever until button is pressed
	mov r0, #RMN_LED
	mov r1, #HIGH
	bl digitalWrite

//Cycles through Red, Yellow, Green
	mov r0, #RED_LED
	mov r1, #HIGH
	bl digitalWrite

	ldr r0, =#1000
	bl delay

	mov r0, #RED_LED
        mov r1, #LOW
        bl digitalWrite

	mov r0, #GRN_LED
	mov r1, #HIGH
	bl digitalWrite

	ldr r0, =#1000
	bl delay

	mov r0, #GRN_LED
        mov r1, #LOW
        bl digitalWrite

	mov r0, #YLW_LED
	mov r1, #HIGH
	bl digitalWrite

	ldr r0, =#1000
	bl delay

	mov r0, #YLW_LED
	mov r1, #LOW
	bl digitalWrite

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

	ldr r0, =#4000
	bl delay

	mov r0, #GMN_LED
	mov r1, #LOW
	bl digitalWrite
	pop {pc}
//Call flashing functions
/*	bl flashing

flashing:
	mov r0, #RMN_LED
	mov r1, #HIGH
	bl digitalWrite

	ldr r0, =#150
	bl delay

	mov r0, #RMN_LED
	mov r1, #LOW
	bl digitalWrite

	mov r0, #GMN_LED
	mov r1, #HIGH
	bl digitalWrite

	ldr r0, =#150
	bl delay

	mov r0, #GMN_LED
	mov r1, #LOW

	cmp r2, #50
	blgt loop

	add r2, #1
	b flashing
*/
