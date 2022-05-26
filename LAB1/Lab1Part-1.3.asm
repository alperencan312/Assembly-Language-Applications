		.text
		
		li $v0,4
		la $a0,prompt1
		syscall

		li $v0,5
		syscall

		move $t0,$v0



check:		li $v0,4
		la $a0,prompt2
		syscall

		li $v0,5
		syscall

		beqz $v0,check

		move $t1,$v0

		#t2 will be the division
		#t3 will be the remainder




loop:		blt $t0,$t1,done
		sub $t0,$t0,$t1
		addi $t2,$t2,1
		j loop

done:		move $t3,$t0

		li $v0,4
		la $a0,prompt3
		syscall

		li $v0,1
		move $a0,$t2
		syscall

		li $v0,4
		la $a0,newLine
		syscall

		li $v0,4
		la $a0,prompt4
		syscall

		li $v0,1
		move $a0,$t3
		syscall

		li $v0,10
		syscall

		.data
		
prompt1: .asciiz "Please enter numerator              : "
prompt2: .asciiz "Please enter denominator (except 0) : "
prompt3: .asciiz "Division is  :"
prompt4: .asciiz "Remainder is :"
newLine: .asciiz "\n"

