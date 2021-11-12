.include "lab2_A.asm"

.data
basek_num: .ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"   
value: .word 0
k: .word 0
value_prompt: .asciiz "Enter Value: "
base_prompt: .asciiz "Enter Base: "
value_string: .asciiz "Value "
base_string: .asciiz " in Base-"
is_string: .asciiz " is "


.text
.globl main
main:

    # print string
    li $v0, 4
    la $a0, value_prompt
    syscall

    # user input integer
    li $v0, 5
    syscall

    # Store user value in memory at label value
    la $t0, value
    sw $v0, 0($t0) 

    # print string
    li $v0, 4
    la $a0, base_prompt
    syscall

    # user input integer
    li $v0, 5
    syscall

    # Store user value in memory at label k
    la $t0, k
    sw $v0, 0($t0) 

    ##########################
    # Start your code here
    ##########################
    
    lw $a0, value
    lw $a1, k
    
    la $s0, basek_num
    addi $s0, $s0, 19 
    
    while: 
    
    # call the function
    jal BasekDigit
      
    sb $v1,($s0)
    addi  $s0, $s0, -1

    move $t6, $zero
    move $v1, $zero
    move $a0, $zero
 
    move $a0, $v0
    beqz $v0, finish
    move $v0, $zero
    
    j while
    finish:
    
    # print string
    li $v0, 4
    la $a0, value_string
    syscall
    
    lw $t7, value
    
    # print quotient
    li $v0, 1     
    move $a0, $t7
    syscall   
    
    # print string
    li $v0, 4
    la $a0, base_string
    syscall
    
    lw $t8, k
    
    # print quotient
    li $v0, 1     
    move $a0, $t8
    syscall  
    
    # print string
    li $v0, 4
    la $a0, is_string
    syscall        
                   
    # print remainder list
    li $v0, 4    
    li  $s1, 1
    add $s2, $s0, $s1
    move $a0, $s2
    syscall  
         
    # Exit the program
    li $v0, 10
    syscall