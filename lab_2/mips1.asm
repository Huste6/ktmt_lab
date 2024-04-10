.data
X: .word 123456  
Y: .word 123456
Z: .space 8  

.text
main:
    # Load X and Y into registers $a0 and $a1
    lw $a0, X
    lw $a1, Y

    # Multiply X and Y
    mul $t0, $a0, $a1
    mflo $t1  
    mfhi $t2 

    # Store the result in Z
    la $t3, Z
    sw $t1, 0($t3)  # Store low 32 bits
    sw $t2, 4($t3)  # Store high 32 bits after low 32 bits

    # Print the result
    li $v0, 4   
    la $a0, prompt1  
    syscall
    
    #print X
    li $v0, 1   
    lw $a0, X 
    syscall
    
    li $v0, 4   
    la $a0, prompt2  
    syscall
    
    #print Y
    li $v0, 1   
    lw $a0, Y  
    syscall
    
    li $v0, 4   
    la $a0, prompt3  
    syscall
    
    li $v0, 1   
    lw $a0, Z  
    syscall

    # End the program
    li $v0, 10  # syscall for exit
    syscall
    
.data
prompt1: .asciiz "The multiplication of "
prompt2:.asciiz " and "
prompt3: .asciiz " is "

