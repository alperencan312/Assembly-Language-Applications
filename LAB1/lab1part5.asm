		.text
main:		li $v0,4
		la $a0,prompt1
		syscall
		
		li $v0,5
		syscall
		
		blt $v0,1,main
		bgt $v0,100,main
		
		move $t0,$v0		#t0 is the size of the array
		jal getArray
		
menu:		la $t1,array		#t1 points the address of the array
		move $t2,$t0		#t2 is the counter for loops in subprograms
		li $t3,0		#t3 is the sum for subprograms
		
		li $v0,4
		la $a0,prompt3
		syscall
		
		li $v0,4
		la $a0,option1
		syscall
		
		li $v0,4
		la $a0,option2
		syscall
		
		li $v0,4
		la $a0,option3
		syscall
		
		li $v0,4
		la $a0,option4
		syscall
		
		li $v0,5
		syscall
		
		beq $v0,1,optionA
		beq $v0,2,optionB
		beq $v0,3,optionC
		beq $v0,4,optionD

optionA:	jal subProgA
		j menu
		
optionB:	jal subProgB
		j menu

optionC:	jal subProgC
		j menu
		
optionD:	li $v0,10
		syscall
		
		
#--------------------------------------------------------------------------------------------------------------#
getArray:	la $t1,array		#t1 points the address of the array
		move $t2,$t0		#t2 is the counter for loop

loopin:		beqz $t2,donein
		
		li $v0,4
		la $a0,prompt2
		syscall
		
		li $v0,5
		syscall
		
		sw $v0,0($t1)
		addi $t1,$t1,4
		subi $t2,$t2,1
		j loopin

donein:		jr $ra
#--------------------------------------------------------------------------------------------------------------#
subProgA:	#la $t1,array		#t1 is the address of the array
		#move $t2,$t0		#t2 is the counter for loop
		#li $t3,0		#t3 is the sum
		
	
		li $v0,4
		la $a0,prompt2
		syscall
		
		li $v0,5
		syscall
		
		move $t4,$v0		#t4 is the input number to be compared

loopA:		beqz $t2,doneA
		lw $t5,0($t1)
		bge $t5,$t4,greater
		add $t3,$t3,$t5
		
greater:	addi $t1,$t1,4
		subi $t2,$t2,1
		j loopA
		
doneA:		li $v0,4
		la $a0,prompt4
		syscall
		
		li $v0,1
		move $a0,$t3
		syscall
		
		jr $ra
#---------------------------------------------------------------------------------------------------------------#
subProgB:	li $v0,4
		la $a0,prompt5
		syscall
		
		li $v0,5
		syscall
		move $t4,$v0 		#t4 is the first number 
		
		li $v0,4
		la $a0,prompt6
		syscall
		
		li $v0,5
		syscall
		move $t5,$v0		#t5 is the second number
		
		blt $t4,$t5,loopB 	#t4 should be the smaller number.
		move $t6,$t4
		move $t4,$t5
		move $t5,$t6
		li $t6,0
		
loopB:		beqz $t2,doneB		
		lw $t6,0($t1)
		blt $t6,$t4,continue
		ble $t6,$t5,finish
continue:	add $t3,$t3,$t6
finish:		addi $t1,$t1,4
		subi $t2,$t2,1
		j loopB
doneB:		li $v0,4
		la $a0,prompt4
		syscall
		
		li $v0,1
		move $a0,$t3
		syscall
		
		jr $ra
#----------------------------------------------------------------------------------------------------------------#
subProgC:	li $v0,4
		la $a0,prompt7
		syscall
		
		li $v0,5
		syscall
		beqz $v0,subProgC
		move $t4,$v0		#t4 is the denominator 
		
loopC:		beqz $t2,doneC
		lw $t5,0($t1)
		div $t5,$t4
		mfhi $t6
		bnez $t6,notDiv
		addi $t3,$t3,1
notDiv:		addi $t1,$t1,4
		subi $t2,$t2,1
		j loopC

doneC:		li $v0,4
		la $a0,prompt8
		syscall
		
		li $v0,1
		move $a0,$t3
		syscall
		
		jr $ra
		
		
		.data
array: .space 400		
prompt1: .asciiz "Enter the size of your array (Min 1, Max 100) : "
prompt2: .asciiz "Enter number : "
prompt3: .asciiz "\nWhich option do you want to perform?\n"
prompt4: .asciiz "The sum is : "
prompt5: .asciiz "Enter first number  : "
prompt6: .asciiz "Enter second number : "
prompt7: .asciiz "Enter denominator (Except 0) : "
prompt8: .asciiz "Number of occurences is : "
option1: .asciiz "(1) Find summation of the integers which are less than a number\n"
option2: .asciiz "(2) Find summation of the integers which are out of range\n"
option3: .asciiz "(3) Display number of occurences which are divisible by an input\n"
option4: .asciiz "(4) Quit\n"

