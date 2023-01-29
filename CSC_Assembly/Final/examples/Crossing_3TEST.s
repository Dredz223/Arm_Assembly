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
	mov r2, #0
	bl wiringPiSetup
	ldr r0, =starting
	bl printf

	bl loop
	pop {pc}
//	bl traffic_walk
//	bl flash
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

	ldr r0, =#250
	bl delay

	mov r0, #RED_LED
        mov r1, #LOW
        bl digitalWrite

	mov r0, #YLW_LED
	mov r1, #OUTPUT
	bl pinMode

	mov r0, #YLW_LED
	mov r1, #HIGH
	bl digitalWrite

	ldr r0, =#250
	bl delay

	mov r0, #YLW_LED
        mov r1, #LOW
        bl digitalWrite

	mov r0, #GRN_LED
	mov r1, #OUTPUT
	bl pinMode

	mov r0, #GRN_LED
	mov r1, #HIGH
	bl digitalWrite

	ldr r0, =#250
	bl delay

	mov r0, #GRN_LED
	mov r1, #LOW
	bl digitalWrite

//Check if button is being pressed to jump out of loop
//and go to button function
	mov r0, #BTTN
	bl digitalRead
	cmp r0, #HIGH
	bne traffic_walk
//	bne flash
	b loop
traffic_walk:
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

	ldr r0, =#500
	bl delay
	mov r0, #GMN_LED
	mov r1, #LOW
	bl digitalWrite
	bl flash

//Call flashing functions


flash:
	mov r0, #GMN_LED
	mov r1, #HIGH
	bl digitalWrite

	ldr r0, =#250
	bl delay

	mov r0, #GMN_LED
	mov r1, #LOW

	cmp r2, #5
	bgt loop

	add r2, #1
	b flash

/*end_loop:
	ldr r0, =ending
	bl printf

	mov r0, #0
	pop {pc}

*/
