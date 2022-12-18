#Kong Pheng Thao
#Assignment 8 Program 2
#This program asks the user to put in a 12-bit Hamming Code and determine if it is correct or not. If it's correct, it'll display a message
#to show that it is correct. If not, it'll display that it is not correct and then what the correct data (12-bit Hamming Code), in hex, should 
#have been. 

.data
prompt: 	.asciiz "Please enter a value between 0-4095. This will be turned into your 12-bit Hamming Code: "
correct: 	.asciiz "\nYou entered the correct Hamming Code. Program now ending..."
incorrect: 	.asciiz "\nYou entered an incorrect Hamming code. Here is the correct Hamming Code: "
space: 		.asciiz " "

.text
main:
	li 	$v0, 4				#code to print string
	la 	$a0, prompt			#address to string
	syscall
	
	li 	$v0, 5				#code for integer input
	syscall
	move 	$s0, $v0			#put user input into $t2
	
	li 	$t0, 0				#loop counter
	li 	$t1, 1				#bit mask
	li	$t6, 12				#backwards loop
	move 	$t2, $s0			#copy hammingCode into t2
	
parityBitOneLoop:
	bgt	$t0, 12, bitOneEnd		#checks if we have even-parity	
	andi 	$t1, $t2, 1			#masks for rightmost bit
	beq 	$t6, 1, bitOneAdd		#paritybit check
	beq 	$t6, 3, bitOneAdd		#paritybit check
	beq 	$t6, 5, bitOneAdd		#paritybit check
	beq 	$t6, 7, bitOneAdd		#paritybit check
	beq 	$t6, 9, bitOneAdd		#paritybit check
	beq 	$t6, 11, bitOneAdd		#paritybit check
	addi 	$t0, $t0, 1			#loop counter +=1
	subi	$t6, $t6, 1			#backwards loop increment
	srl 	$t2, $t2, 1			#shift right 1
	j 	parityBitOneLoop 		#loop
bitOneAdd:
	beq 	$t1, 1, oneAdd			#if rightmost bit = 1, add 1 to total parity
	addi	$t0, $t0, 1			#loop counter +=1
	subi	$t6, $t6, 1			#backwards loop increment
	srl	$t2, $t2, 1			#shift right 1
	j 	parityBitOneLoop		#loop
oneAdd:
	addi	$t3, $t3, 1			# parity total += 1
	addi 	$t0, $t0, 1			#loop counter += 1
	subi	$t6, $t6, 1			#backwards loop increment
	srl 	$t2, $t2, 1			#shift right 1
	j 	parityBitOneLoop
bitOneEnd:
	move 	$s1, $t3			#copy parity total into $s1
	li 	$t3, 0				#reset parity total
	li 	$t0, 0				#reset loop counter
	li	$t6, 12				#backwards loop reset
	move 	$t2, $s0			#copy hammingCode into t2
parityBitTwoLoop:
	bgt 	$t0, 12, bitTwoEnd		#checks if we have even-parity	
	andi 	$t1, $t2, 1			#masks for rightmost bit
	beq 	$t6, 2, bitTwoAdd		#paritybit check
	beq 	$t6, 3, bitTwoAdd		#paritybit check
	beq 	$t6, 6, bitTwoAdd		#paritybit check
	beq 	$t6, 7, bitTwoAdd		#paritybit check
	beq 	$t6, 10, bitTwoAdd		#paritybit check
	beq 	$t6, 11, bitTwoAdd		#paritybit check
	addi	$t0, $t0, 1			#loop counter +=1
	subi	$t6, $t6, 1			#backwards loop increment
	srl 	$t2, $t2, 1			#shift right 1
	j 	parityBitTwoLoop 		#loop
bitTwoAdd:
	beq 	$t1, 1, twoAdd			#if rightmost bit = 1, add 1 to total parity
	addi	$t0, $t0, 1			#loop counter +=1
	subi	$t6, $t6, 1			#backwards loop increment
	srl	$t2, $t2, 1			#shift right 1
	j 	parityBitTwoLoop		#loop
twoAdd:
	addi	$t3, $t3, 1			# parity total += 1
	addi 	$t0, $t0, 1			#loop counter += 1
	subi	$t6, $t6, 1			#backwards loop increment
	srl 	$t2, $t2, 1			#shift right 1
	j 	parityBitTwoLoop
bitTwoEnd:
	move 	$s2, $t3			#copy parity total into $s2
	li 	$t3, 0				#reset parity total
	li 	$t0, 0				#reset loop counter
	li	$t6, 12				#backwards loop reset
	move 	$t2, $s0			#copy hammingCode into t2
parityBitThreeLoop:
	bgt 	$t0, 12, bitThreeEnd		#checks if we have even-parity	
	andi 	$t1, $t2, 1			#masks for rightmost bit
	beq 	$t6, 4, bitThreeAdd		#paritybit check
	beq 	$t6, 5, bitThreeAdd		#paritybit check
	beq 	$t6, 6, bitThreeAdd		#paritybit check
	beq 	$t6, 7, bitThreeAdd		#paritybit check
	beq 	$t6, 12, bitThreeAdd		#paritybit check
	addi	$t0, $t0, 1			#loop counter +=1
	subi	$t6, $t6, 1			#backwards loop increment
	srl	$t2, $t2, 1			#shift right 1
	j 	parityBitThreeLoop 		#loop
bitThreeAdd:
	beq 	$t1, 1, threeAdd		#if rightmost bit = 1, add 1 to total parity
	addi	$t0, $t0, 1			#loop counter +=1
	subi	$t6, $t6, 1			#backwards loop increment
	srl	$t2, $t2, 1			#shift right 1
	j 	parityBitThreeLoop			#loop
threeAdd:
	addi	$t3, $t3, 1			# parity total += 1
	addi 	$t0, $t0, 1			#loop counter += 1
	subi	$t6, $t6, 1			#backwards loop increment
	srl 	$t2, $t2, 1			#shift right 1
	j 	parityBitThreeLoop
bitThreeEnd:
	move 	$s3, $t3			#copy parity total into $s3
	li 	$t3, 0				#reset parity total
	li 	$t0, 0				#reset loop counter
	li	$t6, 12				#backwards loop reset
	move 	$t2, $s0			#copy hammingCode into t2
parityBitFourLoop:
	bgt 	$t0, 12, bitFourEnd		#checks if we have even-parity	
	andi 	$t1, $t2, 1			#masks for rightmost bit
	beq 	$t6, 8, bitFourAdd		#paritybit check
	beq 	$t6, 9, bitFourAdd		#paritybit check
	beq 	$t6, 10, bitFourAdd		#paritybit check
	beq 	$t6, 11, bitFourAdd		#paritybit check
	beq 	$t6, 12, bitFourAdd		#paritybit check
	addi 	$t0, $t0, 1			#loop counter +=1
	subi	$t6, $t6, 1			#backwards loop increment
	srl 	$t2, $t2, 1			#shift right 1
	j 	parityBitFourLoop 		#loop
bitFourAdd:
	beq 	$t1, 1, fourAdd			#if rightmost bit = 1, add 1 to total parity
	addi	$t0, $t0, 1			#loop counter +=1
	subi	$t6, $t6, 1			#backwards loop decrement
	srl	$t2, $t2, 1			#shift right 1
	j 	parityBitFourLoop		#loop
fourAdd:
	addi 	$t3, $t3, 1			# parity total += 1
	addi 	$t0, $t0, 1			#loop counter += 1
	subi	$t6, $t6, 1			#backwards loop decrement
	srl 	$t2, $t2, 1			#shift right 1
	j 	parityBitFourLoop
bitFourEnd:
	move 	$s4, $t3			#copy parity total into $s4
	li 	$t0, 0				#reset loop counter
	move 	$t2, $s0			#copy hammingCode into t2
hammingCodeCheck:
	bgt 	$t0, 12, success		#checks if loop > 12. If loop > 12, success, no error
	beq 	$s1, 1, error			#there is odd parity. There is an error
	beq 	$s2, 1, error			#there is odd parity. There is an error
	beq 	$s3, 1, error			#there is odd parity. There is an error
	beq 	$s4, 1, error			#there is odd parity. There is an error
	
	subi 	$s1, $s1, 2			#s1 -=2
	subi 	$s2, $s2, 2			#s2 -=2
	subi 	$s3, $s3, 2			#s3 -=2
	subi 	$s4, $s4, 2			#s4 -=2
	
	addi 	$t0, $t0, 1			#loop increment
	j 	hammingCodeCheck

error:
	li 	$t0, 0 				#reset loop counter
	li 	$t4, 12				#Hamming Code Counter
	
	li 	$v0, 4				#code to print string
	la 	$a0, incorrect			#address to string
	syscall
	
errorLoop:
	bgt 	$t0, 12, errorBitChange		#if loop > 12, end
	andi 	$t1, $t2, 1			#true/false if right bit = 1
	beq 	$t1, 1, findErrorBit		#if right bit = 1, find position and XOR
	addi 	$t0, $t0, 1			#increment loop
	subi 	$t4, $t4, 1			#decrement Hamming Counter
	srl 	$t2, $t2, 1			#shift array to the right by 1
	j 	errorLoop
findErrorBit:
	xor 	$s5, $s5, $t4			# s5 XOR position of HammingCode
	addi 	$t0, $t0, 1			#increment loop
	subi 	$t4, $t4, 1			#decrement Hamming Counter
	srl	$t2, $t2, 1			#shift array to the right by 1
	j 	errorLoop
	
errorBitChange:
	bge 	$s5, 1, changeBitOne		#if bit is 1, change bit at position 1
	bge 	$s5, 2, changeBitTwo		#if bit is 2, change bit at position 2
	bge 	$s5, 3, changeBitThree		#if bit is 3, change bit at position 3
	bge 	$s5, 4, changeBitFour		#if bit is 4, change bit at position 4
	bge 	$s5, 5, changeBitFive		#if bit is 5, change bit at position 5
	bge 	$s5, 6, changeBitSix		#if bit is 6, change bit at position 6
	bge 	$s5, 7, changeBitSeven		#if bit is 7, change bit at position 7
	bge 	$s5, 8, changeBitEight		#if bit is 8, change bit at position 8
	bge 	$s5, 9, changeBitNine		#if bit is 9, change bit at position 9
	bge	$s5, 10, changeBitTen		#if bit is 10, change bit at position 10
	bge 	$s5, 11, changeBitEleven	#if bit is 11, change bit at position 11
	bge 	$s5, 12, changeBitTwelve	#if bit is 12, change bit at position 12
changeBitOne:
	xori 	$s0, $s0, 2048		#xor at bit value
	j 	end			#jump to end
changeBitTwo:
	xori 	$s0, $s0, 1024		#xor at bit value
	j 	end			#jump to end
changeBitThree:
	xori 	$s0, $s0, 512		#xor at bit value
	j 	end			#jump to end
changeBitFour:
	xori 	$s0, $s0, 256		#xor at bit value
	j 	end			#jump to end
changeBitFive:
	xori 	$s0, $s0, 128		#xor at bit value
	j 	end			#jump to end
changeBitSix:
	xori 	$s0, $s0, 64		#xor at bit value
	j 	end			#jump to end
changeBitSeven:
	xori 	$s0, $s0, 32		#xor at bit value
	j 	end			#jump to end
changeBitEight:
	xori 	$s0, $s0, 16		#xor at bit value
	j 	end			#jump to end
changeBitNine:
	xori 	$s0, $s0, 8		#xor at bit value
	j 	end			#jump to end
changeBitTen:
	xori 	$s0, $s0, 4		#xor at bit value
	j 	end			#jump to end
changeBitEleven:
	xori 	$s0, $s0, 2		#xor at bit value
	j 	end			#jump to end
changeBitTwelve:
	xori 	$s0, $s0, 1		#xor at bit value
	j 	end			#jump to end
end:
	li 	$v0, 34			#code to print hex
	la 	$a0, ($s0)		#integer to print to hex
	syscall
	
	li 	$v0, 10			#exit call
	syscall
success:
	li 	$v0, 4			#code to print string
	la 	$a0, correct		#address to string
	syscall
	
	li 	$v0, 10			#exit call
	syscall
