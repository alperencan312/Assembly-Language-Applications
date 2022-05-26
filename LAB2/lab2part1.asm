		.text
		
main:		la $a0,octalNo
		jal convertToDec
		
		#result comes in v0
		
		#prints the result.(optional)
		move $a0,$v0
		li $v0,1
		syscall
		
		#stop execution
		li $v0,10
		syscall
		
convertToDec:	addi $sp,$sp,-36	# allocate memory from stack
		sw $ra,0($sp)		# store ra and s registers before changing them
		sw $s0,4($sp)
		sw $s1,8($sp)
		sw $s2,12($sp)
		sw $s3,16($sp)
		sw $s4,20($sp)
		sw $s5,24($sp)
		sw $s6,28($sp)
		sw $s7,32($sp)

		move $s4,$a0		# s4 is the address of octalNo
		la $s5,intArray		# s5 is the address of intArray
		li $s6,0		# s6 is the number of digits
		
loop1:		lb $s3,0($s4)
		beqz $s3,done1		# if the next character is null, exit loop1.
		
		subi $s3,$s3,48		# substract 48 to become integer
		
		sw $s3,0($s5)		# store the value in intArray
		
		addi $s6,$s6,1		# increment number of digits
		
		addi $s5,$s5,4
		addi $s4,$s4,1
			
		j loop1
			
done1:		la $s5,intArray
		move $s7,$s6		# s7 is the counter for loop2
		li $s2,0 		# s2 is the sum
		
loop2:		beqz $s7,done2

		lw $s3,0($s5)
		
	Pow:		move $t5,$s7
			subi $t5,$t5,1		# t5 is now counter minus 1.
			li $s0,8		# s0 is 8 to calculate powers of 8.
			li $s1,1		# s1 is going to used in multiplication.
		
	loopPow: 	beqz $t5,loopPowDone
			mul $s1,$s1,$s0		#loop for calculating power of 8.
			subi $t5,$t5,1
			j loopPow

		
	loopPowDone:	mul $s1,$s1,$s3		# multiply power of 8 by coefficient.
			add $s2,$s2,$s1		# add it to sum.
			
			addi $s5,$s5,4
			subi $s7,$s7,1
			j loop2

done2:		move $v0,$s2		# v0 is the result.

		lw $ra,0($sp)		# load $ra and s registers' previous values for main.
		lw $s0,4($sp)
		lw $s1,8($sp)
		lw $s2,12($sp)
		lw $s3,16($sp)
		lw $s4,20($sp)
		lw $s5,24($sp)
		lw $s6,28($sp)
		lw $s7,32($sp)
		addi $sp,$sp,36
		
		jr $ra			# back to main
			
		.data
		
octalNo:	.asciiz "20"
.align 2
intArray:	.space 200
