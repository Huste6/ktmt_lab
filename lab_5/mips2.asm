.data 
    message1: .asciiz "Nhap so nguyen thu 1: "
    message2: .asciiz "Nhap so nguyen thu 2: "
    str1: .asciiz "The sum of "
    str2: .asciiz " and "
    str3: .asciiz " is "
    MSg0: .asciiz "("
    MSg1: .asciiz ")"
.text 
    li $s0, 5       # number1 = 5
    li $s1, 9       # number2 = 9
    # print first message
    li $v0, 4
    la $a0, message1
    syscall

    # read first number
    li $v0, 5
    syscall
    move $s0, $v0

    # print second message
    li $v0, 4
    la $a0, message2
    syscall
    
    # read second number
    li $v0, 5
    syscall
    move $s1, $v0
   
    add $t0, $s0, $s1   # $t0 = number1 + number2
  
    # print string str1
    li $v0, 4
    la $a0, str1
    syscall

    # print ( 
    li $v0, 4
    la $a0, MSg0
    syscall

    # print s0
    li $v0, 1
    move $a0, $s0
    syscall

    # print )
    li $v0, 4
    la $a0, MSg1
    syscall

    # print string str2
    li $v0, 4
    la $a0, str2
    syscall

    # print ( 
    li $v0, 4
    la $a0, MSg0
    syscall

    # print s1
    li $v0, 1
    move $a0, $s1
    syscall

    # print )
    li $v0, 4
    la $a0, MSg1
    syscall

    # print string str3
    li $v0, 4
    la $a0, str3
    syscall

    # print ( 
    li $v0, 4
    la $a0, MSg0
    syscall

    # print $t0
    li $v0, 1
    move $a0, $t0
    syscall

    # print )
    li $v0, 4
    la $a0, MSg1
    syscall
