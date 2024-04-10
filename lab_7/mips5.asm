.data
    largest: .asciiz "Largest: "
    smallest: .asciiz "\nSmallest: "
    comma: .asciiz ", "
.text
main:
    # Initialize the list of 8 elements
    li $s0, -10
    li $s1, 98
    li $s2, 6
    li $s3, 1
    li $s4, -14
    li $s5, -2
    li $s6, -21
    li $s7, 57
    
    # Call the procedure to find largest, smallest, and their positions
    jal saveNumbers
    nop
    
    # Print the message "Largest: "
    li $v0, 4
    la $a0, largest
    syscall
    
    # Print the value of the largest number
    add $a0, $t0, $zero
    li $v0, 1
    syscall
    
    # Print the message ", "
    li $v0, 4
    la $a0, comma
    syscall
    
    # Print the index of the largest number
    add $a0, $t5, $zero
    li $v0, 1
    syscall
    
    # Print the message "Smallest: "
    li $v0, 4
    la $a0, smallest
    syscall
    
    # Print the value of the smallest number
    add $a0, $t1, $zero
    li $v0, 1
    syscall
    
    # Print the message ", "
    li $v0, 4
    la $a0, comma
    syscall
    
    # Print the index of the smallest number
    add $a0, $t6, $zero
    li $v0, 1
    syscall

    # Exit program
    li $v0, 10
    syscall

# Procedure to find the largest, smallest, and their positions
saveNumbers:
    add $t9, $sp, $zero   # Save address of the original $sp
    addi $sp, $sp, -32    # Allocate space on the stack
    sw $s1, 0($sp)        # Save $s1 to $s7 and $ra on the stack
    sw $s2, 4($sp)
    sw $s3, 8($sp)
    sw $s4, 12($sp)
    sw $s5, 16($sp)
    sw $s6, 20($sp)
    sw $s7, 24($sp)
    sw $ra, 28($sp)
    add $t0, $s0, $zero   # Max = $s0
    add $t1, $s0, $zero   # Min = $s0
    li $t5, 0             # Index of Max to 0
    li $t6, 0             # Index of Min to 0
    li $t2, 0             # i = 0

findMaxMin:
    addi $sp, $sp, 4      # Move to the next variable
    lw $t3, -4($sp)       # Load the current variable
    sub $t4, $sp, $t9     # Calculate the stack pointer offset
    beq $t4, $zero, done # If $sp = $fp branch to the 'done'
    nop
    addi $t2, $t2, 1      # i++
    sub $t4, $t0, $t3
    bltzal $t4, swapMax   # If $t3 > Max branch to the swapMax
    nop
    sub $t4, $t3, $t1
    bltzal $t4, swapMin   # If $t3 < Min branch to the swapMin
    nop
    j findMaxMin          # Repeat

done:
    lw $ra, -4($sp)
    jr $ra                # Return to calling program

# Procedure to swap for the maximum value
swapMax:
    move $t0, $t3         # Max = current value
    move $t5, $t2         # Index of Max = current index
    jr $ra                # Return

# Procedure to swap for the minimum value
swapMin:
    move $t1, $t3         # Min = current value
    move $t6, $t2         # Index of Min = current index
    jr $ra                # Return
