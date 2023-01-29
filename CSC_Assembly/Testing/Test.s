//To Print Hello World

.global main
.align 4
.text
main:
	mov r7,#4	//write  ststem
	mov r0,#1	//File (stdout)
	ldr r1,=message
	mov r2,#14	//Message length
	svc #0
	mov r7,#1	//Exit system call
	mov r0,#0	//reutrn code
	svc 0
.data
message:
	.ascii "Hello, World!\n"
