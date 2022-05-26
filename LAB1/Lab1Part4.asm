	.text
# # # Number A # # #
la $a0,prompt1
li $v0,4
syscall
li $v0,5
syscall
move $t0,$v0		 #t0 A

# # # Number B # # #
la $a0,prompt2
li $v0,4
syscall
li $v0,5
syscall
move $t1,$v0		#t1 B

# # # Number C # # #
la $a0,prompt3
li $v0,4
syscall
li $v0,5
syscall
move $t2,$v0  		#t2 C

 # # Number D # # #
la $a0,prompt4
li $v0,4
syscall
li $v0,5
syscall
move $t3,$v0		#t3 D

 # # Number E # # #
la $a0,prompt5
li $v0,4
syscall
li $v0,5
syscall
move $t4,$v0		#t4 E

# # # # # # #


sub $t5,$t1,$t0  	# t5 = B-A
div $t5,$t2
mfhi $t5		# t5 = (B-A) MOD C

mul $t6,$t3,$t4		# t6 = D*E

add $t7,$t5,$t6

la $a0,prompt6
li $v0,4
syscall

li $v0,1
move $a0,$t7
syscall


li $v0,10
syscall

	.data
prompt1: .asciiz "Enter A  : "
prompt2: .asciiz "Enter B  : "
prompt3: .asciiz "Enter C  : "
prompt4: .asciiz "Enter D  : "
prompt5: .asciiz "Enter E  : "
prompt6: .asciiz "The result is : "
