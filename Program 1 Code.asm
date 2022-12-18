#Kong Pheng Thao
#Assignment 8 Program 1
#This program asks the user to input a byte of data and then create the 12-bit Hamming code. The program then outputs this in hex.

.data
userInputPrompt:	.asciiz "Please enter a number between 0-255: "
result: 		.asciiz "\nThe result of your number in hex is: "
space: 			.asciiz " "
newLine: 		.asciiz "\n"
test: 			.asciiz "T "

.text
main:
	li $v0, 4			#call to print string
	la $a0, userInputPrompt		#address to string
	syscall		
	
	li $v0,	5			#call to integer read
	syscall				
	move $s0, $v0			#put value into $s0
	
	li $t0, 2730			#masks for 1010 1010 1010
	li $t1, 1638			#masks for 0110 0110 0110
	li $t2, 481			#masks for 0001 1110 0001
	li $t3, 31			#masks for 0000 0001 1111
	
	srl $s1, $s0, 7			#shift right		0000 0000 0001
	sll $s1, $s1, 9			#shift left		0010 0000 0000
	
	srl $s2, $s0, 4			#shift right		0000 0000 1001
	sll $s2, $s2, 29		#shift left		
	srl $s2, $s2, 24		#shift right		0000 0010 0000
	
	sll $s3, $s0, 28		#shift left		1010 0000 0000
	srl $s3, $s3, 28		#shift right		0000 0000 1010
								#__1_ 001_ 1010
	
	add $s4, $s1, $s2		#s4 = s1 + s2
	add $s4, $s4, $s3		#s4 = (s1+s2) + s3	0010 0010 1010
	
	and $t4, $s4, $t0		#compares input and parity bits		0010 0010 1010
	and $s1, $s4, $t1		#compares input and parity2 bits	
	and $s2, $s4, $t2		#compares input and parity3 bits	
	and $s3, $s4, $t3		#compares input and parity4 bits	
parityBitOneLoop:
	bgt $t7, 12, parityBitOneMod	#checks if we have even-parity	
	andi $t5, $t4, 1		#masks for rightmost bit
	beq $t5, 1, bitOneAdd		#if rightmost bit = 1, add 1 to total parity
	addi $t7, $t7, 1		#loop counter +=1
	srl $t4, $t4, 1			#shift right 1
	j parityBitOneLoop 		#loop
bitOneAdd:
	addi $t6, $t6, 1		# parity total += 1
	addi $t7, $t7, 1		#loop counter += 1
	srl $t4, $t4, 1			#shift right 1
	j parityBitOneLoop
parityBitOneMod:
	beq $t6, 1, bitOneChange	#if total parity is odd, change to even parity
	beq $t6, 0, bitOneEnd		#otherwise, go to next loop
	subi $t6, $t6, 2		#parity_total -= 2
	j parityBitOneMod		#loop
bitOneChange:
	xori $s4, $s4, 2048		#Change 2nd parity bit to 1
bitOneEnd:
	li $t6, 0			#reset parity total
	li $t7, 0			#reset loop counter
parityBitTwoLoop:
	bgt $t7, 12, parityBitTwoMod	#checks if we have even-parity	
	andi $t5, $s1, 1		#masks for rightmost bit
	beq $t5, 1, bitTwoAdd		#if rightmost bit = 1, add 1 to total parity
	addi $t7, $t7, 1		#loop counter +=1
	srl $s1, $s1, 1			#shift right 1
	j parityBitTwoLoop 		#loop
bitTwoAdd:
	addi $t6, $t6, 1		# parity total += 1
	addi $t7, $t7, 1		#loop counter += 1
	srl $s1, $s1, 1			#shift right 1
	j parityBitTwoLoop
parityBitTwoMod:
	beq $t6, 1, bitTwoChange	#if total parity is odd, change to even parity
	beq $t6, 0, parityBitThreeLoop	#otherwise, go to next loop
	subi $t6, $t6, 2		#parity_total -= 2
	j parityBitTwoMod		#loop
	
bitTwoChange:
	xori $s4, $s4, 1024		#Change 2nd parity bit to 1
bitTwoEnd:
	li $t6, 0			#reset parity total
	li $t7, 0			#reset loop counter
parityBitThreeLoop:
	bgt $t7, 12, parityBitThreeMod	#checks if we have even-parity	when loop > 12
	andi $t5, $s2, 1		#masks for rightmost bit
	beq $t5, 1, bitThreeAdd		#if rightmost bit = 1, add 1 to total parity
	addi $t7, $t7, 1		#loop counter +=1
	srl $s2, $s2, 1			#shift right 1
	j parityBitThreeLoop 		#loop
bitThreeAdd:
	addi $t6, $t6, 1		# parity total += 1
	addi $t7, $t7, 1		#loop counter += 1
	srl $s2, $s2, 1			#shift right 1
	j parityBitThreeLoop
parityBitThreeMod:
	beq $t6, 1, bitThreeChange	#if total parity is odd, change to even parity
	beq $t6, 0, parityBitThreeLoop	#otherwise, go to next loop
	subi $t6, $t6, 2		#parity_total -= 2
	j parityBitThreeMod		#loop
	
bitThreeChange:
	xori $s4, $s4, 256		#Change 2nd parity bit to 1
bitThreeEnd:
	li $t6, 0			#reset parity total
	li $t7, 0			#reset loop counter
parityBitFourLoop:
	bgt $t7, 12, parityBitFourMod	#checks if we have even-parity	
	andi $t5, $s3, 1		#masks for rightmost bit
	beq $t5, 1, bitFourAdd		#if rightmost bit = 1, add 1 to total parity
	addi $t7, $t7, 1		#loop counter +=1
	srl $s3, $s3, 1			#shift right 1
	j parityBitFourLoop 		#loop
bitFourAdd:
	addi $t6, $t6, 1		# parity total += 1
	addi $t7, $t7, 1		#loop counter += 1
	srl $s3, $s3, 1			#shift right 1
	j parityBitFourLoop
parityBitFourMod:
	beq $t6, 1, bitFourChange	#if total parity is odd, change to even parity
	beq $t6, 0, end			#otherwise, end
	subi $t6, $t6, 2		#parity_total -= 2
	j parityBitFourMod		#loop
	
bitFourChange:
	xori $s4, $s4, 16		#Change 2nd parity bit to 1
end:
	li $v0, 4			#code to print string
	la $a0, result			#address to string
	syscall
	
	li $v0, 34			#code to print hex
	la $a0, ($s4)			#integer to print
	syscall
	
	li $v0, 10			#exit call
	syscall
