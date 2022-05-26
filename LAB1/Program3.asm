##
##	Program3.asm is a loop implementation
##	of the Fibonacci function
##        

#################################
#					 	#
#		text segment		#
#						#
#################################

	.text		
.globl __start
 
__start:
	# execution starts here
	li $v0,4
	la $a0,enterNum
	syscall
	
	li $v0,5
	syscall
	
	
	
	move $a0,$v0
	#li $a0,4	# to calculate fib for odd numbers and factorial for even numbers.
	
	li $t2,2
	div $a0,$t2
	mfhi $t3   # get the remainder
	beq $t3,0,factorial # if number is even, go to factorial.
		
	
	jal fib		# call fib if number is odd
	move $a0,$v0	# print result
	li $v0, 1
	syscall

	la $a0,endl	# print newline
	li $v0,4
	syscall

	li $v0,10
	syscall		# bye bye

#------------------------------------------------


fib:	move $v0,$a0	# initialise last element
	blt $a0,2,done	# fib(0)=0, fib(1)=1

	li $t0,0	# second last element
	li $v0,1	# last element

loop:	add $t1,$t0,$v0	# get next value
	move $t0,$v0	# update second last
	move $v0,$t1	# update last element
	sub $a0,$a0,1	# decrement count
	bgt $a0,1,loop	# exit loop when count=0
done:	jr $ra

#------------------------------------------------


		
factorial:	move $t4,$a0 # move the number to t4
		beq $t4,0,specialCase
		subi $t6,$t4,1 # number minus 1 = t6 
		mul $t5,$t4,$t6 # multiplication is stored in t5
		
loop2:		beq $t6,1,done2 # after decrementing t6, loop ends when last number is 1
		subi $t6,$t6,1 # decrementing t6 by 1
		mul $t5,$t5,$t6 #multiplying t6 by previous multiplication
		j loop2
		
		
done2:		move $a0,$t5
		li $v0,1       #printing factorial
		syscall
	
		li $v0,10
		syscall


specialCase:	add $a0,$zero,1
		li $v0,1
		syscall
	
		li $v0,10
		syscall
	
	
	

#################################
#					 	#
#     	 data segment		#
#						#
#################################

	.data
endl:	.asciiz "\n"
enterNum: .asciiz "Enter number : "

##
## end of Program3.asm
