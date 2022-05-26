		.text

invalid:	la $a0,prompt1
		li $v0,4
		syscall

		li $v0,5
		syscall

		bgt $v0,20,invalid
		blt $v0,2,invalid

		move $t1,$v0 # t1 is the size of the array
		move $t2,$t1 # t2 is the counter

		la $t0,array # t0 is the address of the array


loopin:		beq $t2,0,donein
		la $a0,prompt2
		li $v0,4
		syscall
		li $v0,5
		syscall
		sw $v0,0($t0)
		addi $t0,$t0,4
		subi $t2,$t2,1
		j loopin
	

donein:		div $t3,$t1,2 #counter for checking
		la $t0,array
		subi $t4,$t1,1 #counter for accessing the address of the last element 
		mul $t4,$t4,4
		add $t5,$t0,$t4 #t5 points to the address of the last element


loopcheck:	beq $t3,0,pal
		lw $t6,0($t0)
		lw $t7,0($t5)
		bne $t6,$t7,notPal
		addi $t0,$t0,4
		subi $t5,$t5,4
		subi $t3,$t3,1
		j loopcheck


pal:		la $a0,prompt3
		li $v0,4
		syscall
		j exit

notPal:		la $a0,prompt4
		li $v0,4
		syscall
		j exit


exit:	 	li $v0,10
 		syscall	
 
		.data
		
array: .space 80
prompt1: .asciiz "Please enter the size of your array (MIN 2 , MAX 20) : "
prompt2: .asciiz "Please enter number : "
prompt3: .asciiz "The array is palindrome."
prompt4: .asciiz "The array is not palindrome."
