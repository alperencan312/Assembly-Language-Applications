			.text
main:			jal readArray
			
			move $a0,$v0
			move $a1,$v1
			
			jal monitor
			
			la $a0,prompt12
			li $v0,4
			syscall
			
			li $v0,10
			syscall
			
#______________________________Subprogram monitor_____________________________#	
		
monitor:		move $t2,$a0		#t2 is the address of array
			move $t0,$a1		#t0 is the size of array
			
			addi $sp,$sp,-16  	
			sw $s0,4($sp)
			sw $s1,8($sp)
			sw $s2,12($sp)
			
continue:		la $a0,prompt5
			li $v0,4
			syscall
			
			la $a0,prompt6
			li $v0,4
			syscall
			
			la $a0,prompt7
			li $v0,4
			syscall
			
			la $a0,prompt8
			li $v0,4
			syscall
			
			la $a0,prompt9
			li $v0,4
			syscall
			
			la $a0,prompt10
			li $v0,4
			syscall
			
			la $a0,prompt20
			li $v0,4
			syscall
				
			li $v0,5
			syscall
			
			beq $v0,1,option1
			beq $v0,2,option2
			beq $v0,3,option3
			beq $v0,4,option4
			beq $v0,5,option5
			beq $v0,6,option6
			
option1:		move $a0,$t2
			move $a1,$t0
			jal bubbleSort
			j continue
			
			
option2:		move $a0,$t2
			move $a1,$t0
			jal thirdMinThirdMax
			
			move $a1,$v0
			
			la $a0,prompt16
			li $v0,4
			syscall
			
			
			move $a0,$a1
			li $v0,1
			syscall
			
			la $a0,comma
			li $v0,4
			syscall
			
			la $a0,prompt17
			li $v0,4
			syscall
			
			move $a0,$v1
			li $v0,1
			syscall
			
			j continue
			
			
option3:		move $a0,$t2
			move $a1,$t0
			jal mode
			j continue
			
				
option4:		move $a0,$t2
			move $a1,$t0
			jal print
			j continue

option5:		la $a0,prompt18
			li $v0,4
			syscall
			li $v0,10
			syscall
			
			
			lw $ra,0($sp)
			lw $s0,4($sp)
			lw $s1,8($sp)
			lw $s2,12($sp)
			addi $sp,$sp,16
			jr $ra	
			
option6:		jal readArray
			j continue
		
#______________________________Subprogram readArray_____________________________#

readArray:		la $a0,prompt1
			li $v0,4
			syscall
			
			li $v0,5
			syscall
			
			move $t0,$v0		#t0 is the size of array. (constant)
			
			li $t1,4
			mul $t1,$t1,$v0
			
			move $a0,$t1
			li $v0,9
			syscall
			
			move $t1,$t0		#t1 will be the counter for loops.
			move $t2,$v0		#t2 is the address of the array. (constant)
			move $t3,$v0		#t3 is going to used for accesing array elements.
								
loopRead:		beqz $t1,loopReadDone

			la $a0,prompt2
			li $v0,4
			syscall
			
			li $v0,5
			syscall
			
			sw $v0,0($t3)
			
			addi $t3,$t3,4
			subi $t1,$t1,1
			
			j loopRead

loopReadDone:		move $v0,$t2
			move $v1,$t0
			
			jr $ra
			
#_________________________________Subprogram bubbleSort________________________________#

bubbleSort:		bnez $t0,goon1 #
			la $a0,prompt19
			li $v0,4
			syscall
			jr $ra
			
goon1:			subi $t1,$a1,1		#t1 will be the counter for loops
			li $t5,0
			li $t6,0
			move $t3,$a0		#t3 is going to used for accesing array elements
						
loopSort1:		beq $t5,$t1,loopSortDone1
			sub $t7,$t1,$t5
			move $t3,$t2
			li $t6,0

		loopSort2:	beq $t6,$t7,loopSortDone2
				
				lw $t8,0($t3)
				addi $t3,$t3,4
				lw $t9,0($t3)
				
				abs $s0,$t8
				abs $s1,$t9
				
				bgt $s0,$s1,noSwap 
				move $t4,$t8
				move $t8,$t9
				move $t9,$t4
				
				subi $t3,$t3,4
				
				sw $t8,0($t3)
				
				addi $t3,$t3,4
				
				sw $t9,0($t3)
		
		noSwap:		addi $t6,$t6,1
				j loopSort2
				
		loopSortDone2:	addi $t5,$t5,1
				j loopSort1

loopSortDone1:		la $a0,prompt13
			li $v0,4
			syscall
			
			jr $ra
				


#___________________________________Subprogram thirdMinThirdMax___________________________________#

thirdMinThirdMax:	move $t1,$a1		#t1 will be the counter for loop	
			move $t3,$a0		#t3 is going to used for accesing array elements.
			
			li $t4,4
			mul $t4,$t4,$t0
			
			move $a0,$t4
			li $v0,9
			syscall
			
			move $t5,$v0		#accessor
			move $t7,$v0		#t7 is new arrays address
			
loopThird:		beqz $t1,loopThirdDone
			
			lw $t6,0($t3)
			sw $t6,0($t5)
			
			addi $t3,$t3,4
			addi $t5,$t5,4
			
			subi $t1,$t1,1
			
			j loopThird

loopThirdDone:		sub $t1,$t0,1
			move $t3,$t7
			li $t5,0
			li $t6,0
			
loopSortAgain1:		beq $t5,$t1,loopSortAgainDone1
			sub $t8,$t1,$t5
			move $t3,$t7 #t7den t3 e alýnacak. diðerinde 2 den almýþýz
			li $t6,0
			
			
		loopSortAgain2: beq $t6,$t8,loopSortAgainDone2 #t7 yerine t8 olacak
				lw $s0,0($t3) #t8 yerine s0
				addi $t3,$t3,4
				lw $s1,0($t3)	#t9 yerine s1
				
				bgt $s0,$s1,dontSwap
				
				move $s2,$s0
				move $s0,$s1
				move $s1,$s2
				
				subi $t3,$t3,4
				sw $s0,0($t3)
				
				addi $t3,$t3,4
				
				sw $s1,0($t3)
				
		dontSwap:	addi $t6,$t6,1
				j loopSortAgain2
		
		loopSortAgainDone2:	addi $t5,$t5,1
				   	j loopSortAgain1 

loopSortAgainDone1:	subi $t1,$t0,1
			move $t3,$t7
			li $t5,1

loopAccess:		beqz $t1,loopAccessDone
			addi $t3,$t3,4
			subi $t1,$t1,1
			j loopAccess

loopAccessDone:		subi $t3,$t3,8
			lw $t4,0($t3)		#t4 is 3rd minimum value
					
			move $t3,$t7
			addi $t3,$t3,8
			
			lw $t5,0($t3)		#t5 is 3rd maximum value
			
			move $v0,$t4
			move $v1,$t5
			
			jr $ra
					
			
			
						
			
			
			

#_________________________________________Subprogram mode_________________________________________#

mode:			bnez $t0,goon2
			la $a0,prompt19
			li $v0,4
			syscall
			jr $ra
			
goon2:			move $t1,$a1		#t1 will be the counter for the first loop.
			move $t3,$a0		#t3 is going to used for accessing array elements.
			li $t4,0		#t4 is the mode
			li $t5,0		#t5 is the max count.
			li $t6,0		#t6 is to count appearances.
			move $t7,$a1		#t7 will be the counter for the second loop.
			move $t8,$a0		#t8 is going to used for accesing array elements in second loop.
			
			
			
loopMode1:		beqz $t1,loopModeDone1
			li $t6,0		#t6 is to count appearances.
			lw $t9,0($t3)
			move $t7,$t0
			move $t8,$t2
			
		loopMode2:	beqz $t7,loopModeDone2
		
				lw $s0,0($t8)
				bne $s0,$t9,notEqual
				
				addi $t6,$t6,1
				
		notEqual:	addi $t8,$t8,4
				subi $t7,$t7,1
				j loopMode2
				
		
		loopModeDone2:	blt $t6,$t5,less
				beq $t6,$t5,equal
				move $t5,$t6
				move $t4,$t9
		
		less:		addi $t3,$t3,4
				subi $t1,$t1,1
				j loopMode1
				
		equal:		bgt $t9,$t4,greater
				move $t4,$t9
		greater: 	addi $t3,$t3,4
				subi $t1,$t1,1
				j loopMode1		
				
		
			
			
			
loopModeDone1:		bne $t5,1,modeExist
			la $a0,prompt14
			li $v0,4
			syscall
			
			jr $ra

modeExist:		la $a0,prompt15
			li $v0,4
			syscall
			
			move $a0,$t4
			li $v0,1
			syscall
			
			jr $ra

#___________________________________Subprogram print___________________________________#

print:			bnez $t0,goon3
			la $a0,prompt19
			li $v0,4
			syscall
			jr $ra
			
goon3:			move $t1,$a1		#t1 will be the counter for loops
			move $t3,$a0		#t3 is going to used for accesing array elements
			
			la $a0,prompt11
			li $v0,4
			syscall
			
loopPrint:		beqz $t1,loopPrintDone

			lw $t4,0($t3)
			
			move $a0,$t4
			li $v0,1
			syscall
			
			la $a0,comma
			li $v0,4
			syscall
			
			addi $t3,$t3,4
			subi $t1,$t1,1
			
			j loopPrint
			
loopPrintDone:		jr $ra


			.data
			
prompt1: 		.asciiz "Enter the size of array: " 
prompt2:		.asciiz "Enter number: "
prompt4:		.asciiz "Array contents are: "
prompt5:		.asciiz "\nWhat do you want to do? \n"
prompt6:		.asciiz "(1) Sort array in descending order by using absolute values\n"
prompt7:		.asciiz "(2) Find third min. and max. values\n"
prompt8:		.asciiz "(3) Find mode\n"
prompt9:		.asciiz "(4) Print array\n"
prompt10:		.asciiz "(5) Exit monitor\n"
prompt11:		.asciiz "\nArray elements are: "
prompt12:		.asciiz "Back to main"
prompt13:		.asciiz "\n*** Sorting is completed ***\n"
prompt14:		.asciiz "\nThere is no mode.\n"
prompt15:		.asciiz "The mode is : "
prompt16:		.asciiz "Third minimum value is : "
prompt17:		.asciiz "   Third maximum value is : "
prompt18:		.asciiz "*** Good Bye ***"
prompt19:		.asciiz "*** There are not any numbers in the array ***"
prompt20:		.asciiz "(6) Read array\n"
comma:			.asciiz " "	
