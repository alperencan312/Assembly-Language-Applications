		.text

invalid:	la $a0,prompt1
		li $v0,4
		syscall

		li $v0,5
		syscall

		bgt $v0,20,invalid
		blt $v0,1,invalid

		move $t1,$v0 # t1 is the size of the array
		move $t2,$t1 # t2 will be the counter

		la $t0,array # t0 is the address of the array


loopin:		beq $t2,0,display
		la $a0,prompt2
		li $v0,4
		syscall
		li $v0,5
		syscall
		sw $v0,0($t0)
		addi $t0,$t0,4
		subi $t2,$t2,1
		j loopin
	

display:	la $t0,array
		move $t2,$t1 # t2 will be the counter
		la $a0,prompt3
		li $v0,4
		syscall

loopout:	beq $t2,0,displayRev
		lw $a0,0($t0)
		li $v0,1
		syscall
		la $a0,space
		li $v0,4
		syscall
		addi $t0,$t0,4
		subi $t2,$t2,1
		j loopout
	
	

displayRev:	la $t0,array
		move $t2,$t1 # t2 will be the counter
		subi $t3,$t1,1 # t3 will be the counter for accesing the address of the last element
		mul $t3,$t3,4
		add $t0,$t0,$t3
	
		la $a0,prompt4
		li $v0,4
		syscall

loopRev:	beq $t2,0,done
		lw $a0,0($t0)
		li $v0,1
		syscall
		la $a0,space
		li $v0,4
		syscall
		subi $t0,$t0,4
		subi $t2,$t2,1
		j loopRev
	

done:		li $v0,10
		syscall

		.data
		
array: .space 80
prompt1: .asciiz "Please enter the size of your array (MAX 20) : "
prompt2: .asciiz "Please enter number : "
prompt3: .asciiz "Your array in order         : "
prompt4: .asciiz "\nYour array in reverse order : "
space:   .asciiz " "
	
	
	
