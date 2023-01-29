//Define the LEDs
.equ RED_PIN, 0		//The Red Led (Traffic)
.equ YLW_PIN, 1		//The Yellow Led (Traffic)
.equ GRN_PIN, 2		//The Green Led (Traffic)
.equ RMN_PIN, 3		//The Red Led (Cross)
.equ GMN_PIN, 4		//The Green Led

//Define Button
.equ BTN_PIN, 8		//The Button (cross)

//Define Low, High, In, Out
.equ LOW, 0
.equ HIGH, 1
.equ INPUT, 0
.equ OUTPUT, 1
// bare bones source file 
.global main

.align 4
.section .rodata
// all constant data goes here
traffic_on: .asciz "Traffic is Going! Press the Button to Cross!\n"
traffic_off:.asciz "Traffic is Stopped! Please Cross the Road!\n"
.align 4
.section .bss
// all uninitialized data goes here

.align 4
.data
// all non-constant, initialized data goes here

.align 4
.text
main:
	push {lr} // save link register, this is one of many ways this can be done
	bl wiringPiSetup // wiringPiSetup();
	
