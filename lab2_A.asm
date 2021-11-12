.data
newline: .asciiz "\n"
Error: .asciiz "Value must be > 0. Base must be in the range [1,16]\n"
Quotient_string: .asciiz "Quotient is "
Remainder_string: .asciiz ", Remainder is "

.text
BasekDigit:

	# error checking
	
	bgez $a0, go
	# print error
    	li $v0, 4
   	la $a0, Error
    	syscall
    	
    	# Exit the program
   	li $v0, 10
    	syscall
	
	go:
	
	addi $t3, $0, 1
	addi $t4, $0, 16
	
	bge $a1, $t3, pass
	# print error
    	li $v0, 4
   	la $a0, Error
    	syscall
    	
    	# Exit the program
   	li $v0, 10
    	syscall
	
	pass:
	
	ble  $a1, $t4, pass2
	# print error
    	li $v0, 4
   	la $a0, Error
    	syscall
    	
    	# Exit the program
   	li $v0, 10
    	syscall
	
	pass2:
	
	# dividing value and base
	
	div $a0, $a1
	mflo $a2
	mfhi $a3
	
    	# print prompt
    	li $v0, 4
   	la $a0, Quotient_string
    	syscall

    	# print quotient
       	li $v0, 1
    	move $a0, $a2
    	syscall

    	# print prompt
    	li $v0, 4
    	la $a0, Remainder_string
    	syscall

    	# print remainder
       	li $v0, 1
    	move $a0, $a3
    	syscall

    	# print endline
    	li $v0, 4
    	la $a0, newline
    	syscall
    	
    	j case15
   
	# switch case
	
	case15:
	addi $t2, $0, 15
	beq $t2, $a3, right1
	j case14
	
	right1:
	li $t5, 'F'
	j done
	
	case14:
	addi $t2, $0, 14
	beq $t2, $a3, right2
	j case13
	
	right2:
	li $t5, 'E'
	j done
	
	case13:
	addi $t2, $0, 13
	beq $t2, $a3, right3
	j case12
	
	right3:
	li $t5, 'D'
	j done
	
	case12:
	addi $t2, $0, 12
	beq $t2, $a3, right4
	j case11
	
	right4:
	li $t5, 'C'
	j done
	
	case11:
	addi $t2, $0, 11
	beq $t2, $a3, right5
	j case10
	
	right5:
	li $t5, 'B'
	j done
	
	case10:
	addi $t2, $0, 10
	beq $t2, $a3, right6
	j default
	
	right6:
	li $t5, 'A'
	j done
	
	default:
	addi $t5, $a3, '0'
	j done
	
	done:
	
	move $v0, $a2 #Quotient
	move $v1, $t5 #Letter
	move $t6, $a3 #Remainder
	
	jr $ra
