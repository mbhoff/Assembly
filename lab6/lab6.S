		.data

coin:		.asciz "%d"
		.align	2


week1:		.asciz	"Enter the number of pennies, nickels, dimes, and quarters for week 1: "
		.align	2

week2:		.asciz	"Enter the number of pennies, nickels, dimes, and quarters for week 2: "
		.align	2

week3: 		.asciz	"Enter the number of pennies, nickels, dimes, and quarters for week 3: "
		.align	2

week4: 		.asciz	"Enter the number of pennies, nickels, dimes, and quarters for week 4: "
		.align	2


cointypes:	.asciz "Over four weeks you have collected %d pennies, %d nickels, %d dimes, and %d quarters\n"


dollarsandcents: .asciz "This comes to $%d.%d\n"
		.align	2

dollarsandcents0digit: .asciz "This comes to $%d.%d%d\n"
		.align	2

weeklyavg:	.asciz "Your weekly average is $%d.%d\n"

yearlyavg:	.asciz "Your yearly savings is $%d.%d\n"
	   	.align 2


temp:		.word	0
pennies:	.word	0
nickels:	.word	0
dimes:		.word	0
quarters:	.word	0
total:		.word	0

variable: 	.word	1374389534



buffer: 	.skip	4096




		.text
		.global main

read4nums:


	stmfd	sp!, {r4-r11, lr}
	
	ldr	r0, =coin	@ scanf("%d\0",&temp)
	ldr	r1, =temp
	bl	scanf
	ldr	r1, =temp	@load temp into r1
	ldr	r1, [r1]
	ldr	r4, =pennies	@load total pennies into r4
	ldr	r0, [r4]
	add	r0, r0, r1	@add temp to total pennies
	str	r0, [r4]	


				
	ldr	r0, =coin	@ scanf("%d\0",&temp)
	ldr	r1, =temp
	bl	scanf
	ldr	r1, =temp	@load temp into r1
	ldr	r1, [r1]
	ldr	r5, =nickels	@load total nickels into r5
	ldr	r0, [r5]
	add	r0, r0, r1 	@add temp to total nickels
	str	r0, [r5]	


				
	ldr	r0, =coin	@ scanf("%d\0",&temp)
	ldr	r1, =temp
	bl	scanf
	ldr	r1, =temp	@load temp into r1
	ldr	r1, [r1]
	ldr	r6, =dimes	@load total dimes into r6
	ldr	r0, [r6]
	add	r0, r0, r1 	@add temp to total dimes
	str	r0, [r6]	



	ldr	r0, =coin	@ scanf("%d\0",&temp)
	ldr	r1, =temp
	bl	scanf
	ldr	r1, =temp	@load temp into r1
	ldr	r1, [r1]
	ldr	r7, =quarters	@load total quarters into r7
	ldr	r0, [r7]
	add	r0, r0, r1	@add temp to total quarters
	str	r0, [r7]	



	ldr	r0, =cointypes


	ldr	r4, =pennies	@load total pennies into r4
	ldr	r4, [r4]

	ldr	r5, =nickels	@load total nickels into r5
	ldr	r5, [r5]

	ldr	r6, =dimes	@load total dimes into r6
	ldr	r6, [r6]

	ldr	r7, =quarters	@load total quarters into r7
	ldr	r7, [r7]

	mov	r1, r4
	mov	r2, r5
	mov	r3, r6
	mov	r4, r7

	sub	sp, sp, #4
	str	r7, [sp]

	bl	printf

	add	sp, sp, #4

	ldmfd	sp!, {r4-r11, lr}
	mov	r0, #0
	mov	pc, lr




main:	stmfd	sp!, {r4-r11, lr} @push registers r4-r11 onto stack
	


	ldr	r0, =coin


	mov	r4, #0		@load pennies into r4, initialize to 0


	mov	r5, #0		@load nickels into r5, initialize to 0


	mov	r6, #0		@load dimes into r6, initialize to 0


	mov	r7, #0		@load quarters into r7, initialize to 0

	ldr	r0, =week1
	bl	printf
	bl	read4nums

	ldr	r0, =week2
	bl	printf
	bl	read4nums

	ldr	r0, =week3
	bl	printf
	bl	read4nums

	ldr	r0, =week4
	bl	printf
	bl	read4nums












	ldr	r4, =pennies	@load total pennies into r4
	ldr	r4, [r4]



	ldr	r5, =nickels	@load total nickels into r5
	ldr	r5, [r5]

	add	r5, r5, r5, lsl #2	@multiply total nickels by 5
	
	ldr	r6, =dimes	@load total dimes into r6
	ldr	r6, [r6]
	
	lsl	r6, r6, #1		@multiply total dimes by 10
	add	r6, r6, r6, lsl #2

	ldr	r7, =quarters	@load total quarters into r7
	ldr	r7, [r7]

	mov	r0, #0
	add	r0, r0, r7
	add	r0, r0, r7, lsl #3	@multiply total quarters by 25
	add	r0, r0, r7, lsl #4
	mov	r7, r0

	mov	r8, #0		@load total into pennies into r8, initialize to 0


	add	r8, r8, r4	@add pennies to total
	add	r8, r8, r5	@add nickels to total
	add	r8, r8,	r6	@add dimes to total
	add	r8, r8, r7	@add quarters to total





	



	
			@multiply by 1/100 to get total amount
	
	mov	r2, r8			@move total into r2

	ldr	r3, =variable
	ldr	r3, [r3]		@load 1/100 into r3
	smull	r0, r1, r3, r2		@smull - r0 contains lower bits, r2 contains upper bits
	mov	r3, r2, asr #31		@get sign of numerator, store in r3
	rsb	r0, r3, r1, asr#5	@shift right and adjust for sign
	mov	r1, #100		@move denominator into r1
	mul	r1, r1, r0		@multiply denominator by quotient
	sub	r1, r2, r1		@subtract that from numerator

	mov	r2, r1
	mov	r1, r0
	ldr	r0, =dollarsandcents
	bl	printf


	
			@multiply by 4 and 1/100 to get weekly average

	mov r9, r8
	asr	r9, #2

	mov	r2, r9			@move total into r2

	ldr	r3, =variable
	ldr	r3, [r3]		@load 1/100 into r3
	smull	r0, r1, r3, r2		@smull - r0 contains lower bits, r2 contains upper bits
	mov	r3, r2, asr #31		@get sign of numerator, store in r3
	rsb	r0, r3, r1, asr#5	@shift right and adjust for sign
	mov	r1, #100		@move denominator into r1
	mul	r1, r1, r0		@multiply denominator by quotient
	sub	r1, r2, r1		@subtract that from numerator

	mov	r2, r1
	mov	r1, r0
	ldr	r0, =weeklyavg
	bl	printf





			@multiply by 1/100 to get total amount
	mov r10, r8
	lsl r10, r10, #3
	mov r11, r8
	lsl r11, r11, #2
	add	r8, r10, r11
	mov r2, r8

	ldr	r3, =variable
	ldr	r3, [r3]		@load 1/100 into r3
	smull	r0, r1, r3, r2		@smull - r0 contains lower bits, r2 contains upper bits
	mov	r3, r2, asr #31		@get sign of numerator, store in r3
	rsb	r0, r3, r1, asr#5	@shift right and adjust for sign
	mov	r1, #100		@move denominator into r1
	mul	r1, r1, r0		@multiply denominator by quotient
	sub	r1, r2, r1		@subtract that from numerator




	mov	r2, r1
	mov	r1, r0
	ldr	r0, =dollarsandcents
	


			@if fractional part has zero as a leading digit
			@load the zero and the remaining digits into separate registers
			@and change format string	


	cmp	r2, #10
	movlt	r3, r2

	cmp	r2, #10
	ldrlt	r0, =dollarsandcents0digit


	cmp	r2, #10
	movlt	r2, #0



	bl	printf




	



	ldmfd	sp!, {r4-r11, lr}
	mov	r0, #0
	mov	pc, lr
	.end



	
	

