			.text

main:			jal interactWithUser 
			move $t0,$v1
		
			li $v0,10
			syscall

#___________________________________Subprogram Interact with User__________________________________________#

interactWithUser: 	li $v0,4
			la $a0,enterOctal
			syscall

			li $v0,8		# The octal number is given by user in a form of string
			la $a0,inputText
			li $a1,200
			syscall

			la $a1,inputText
			la $s5,intArray

			addi $sp,$sp,-36	# Allocate memory from stack
			sw $ra,0($sp)		# store $ra and s registers in stack 
			sw $s0,4($sp)
			sw $s1,8($sp)
			sw $s2,12($sp)
			sw $s3,16($sp)
			sw $s4,20($sp)
			sw $s5,24($sp)
			sw $s6,28($sp)
			sw $s7,32($sp)		

			jal convertToDec
			
			move $a0,$v1		# Prints the result
			li $v0,1
			syscall

			lw $ra,0($sp)		# load $ra and s regisyers from stack
			lw $s0,4($sp)
			lw $s1,8($sp)
			lw $s2,12($sp)
			lw $s3,16($sp)
			lw $s4,20($sp)
			lw $s5,24($sp)
			lw $s6,28($sp)
			lw $s7,32($sp)
			addi $sp,$sp,36

			jr $ra

#___________________________________Subprogram Convert to Decimal__________________________________________#

convertToDec:		move $s4,$a1       	#a1, the address of string array which contains octal number
			li $s2,0
			li $t1,7
			
		loop:	lb $s1,0($s4)	   	# loads the first character from array inputText
			beqz $s1,done 		# exit if all characters are read
			sub $s1,$s1,48		# subtracts 48 from to become integer
			
			
			bgt $s1,$t1,invalidOctal #ensures the number is octal
			
			sw $s1,0($s5)   	# stores the integer value in intArray

			addi $s2,$s2,1 		# s2 is the number of digits
			addi $s4,$s4,1 		# increments address of inputText
			addi $s5,$s5,4 		# increments address of intArray

			j loop

		done:	subi $s0,$s2,2 		# s0 the variable which enables to convert octal to decimal. For example, if size of the int array is 3, first digit should be multiplied 2 times.(8^2) second digit 8^1 last digit 8^0
			li $s4,0 		# s4 is sum.
			li $s1,1 		# s1 is the counter 
			la $s5,intArray
				
		while:	beq $s1,$s2,exitloop
			lw $s3,0($s5)
			li $s6,0
			li $s7,1 		# s7 is going to used in multiplication
			
		while2:	beq $s0,$s6,done2	# while2 is the loop inside while

			sw $s5,4($sp)		# s5 needs to be saved
			
			li $s5,8
			mul $s7,$s7,$s5		#multiply by 8. For example, if number is 532, it multiplies 8x8 two times. (Then 64 is going to be multiplied by the coefficient 5 below in the label done2
				 	
			addi $s6,$s6,1

			lw $s5,4($sp)

			j while2 
	
		done2:	mul $s7,$s7,$s3
			add $s4,$s4,$s7 	# multiply with the coefficient and add
			
			subi $s0,$s0,1
			addi $s5,$s5,4
			addi $s1,$s1,1

			j while			# back to first loop

			exitloop:
			move $v1,$s4	 	# return to interactWithUser with the decimal number in v1
			
			jr $ra

#___________________________________Invalid Octal__________________________________________#

invalidOctal:		la $a0,promptInvalid
			li $v0,4
			syscall
			
			j main
			
			.data

promptInvalid:		.asciiz "Not a proper octal number.\n"
enterOctal: 		.asciiz "Enter an octal number : "
inputText: 		.space 200
.align 2
intArray: 		.space 200

