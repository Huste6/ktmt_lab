.data
    prompt: .asciiz "Nhap so phan tu cua 1 mang: "
    promptM: .asciiz "Nhap so nguyen M: "
    promptN: .asciiz "Nhap so nguyen N: "
    messenger: .asciiz "cac phan tu thuoc (M den N): "
    newline: .asciiz "\n"
    A: .word 0:100
.text
main:
    # In ra prompt
    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 5
    syscall
    move $a1, $v0 # so phan tu luu vao a1

    # Nhap cac phan tu trong mang
    li $t1, 0
    la $a0, A
input_loop:
    li $v0, 5
    syscall
    sw $v0, ($a0)
    addi $t1, $t1, 1
    addi $a0, $a0, 4
    blt $t1, $a1, input_loop

continue:
    # In ra M
    li $v0, 4
    la $a0, promptM
    syscall

    li $v0, 5
    syscall
    move $a2, $v0 # M = $a2

    # In ra N
    li $v0, 4
    la $a0, promptN
    syscall

    li $v0, 5
    syscall
    move $a3, $v0 # N = $a3

    la $t2, A # Load dia chi mang A
    
    li $v0, 4
    la $a0, messenger
    syscall

    li $t1, 0 # Reset index
solve:
    sll $t0, $t1, 2      # $t0 = $t1 * 4
    add $t4, $t0, $t2    # $t4 = $t0 + $t2 = address of A[i]
    lw $t3, 0($t4)       # $t3 = value of A[i]
    ble $t3, $a2, not_contain
    bge $t3, $a3, not_contain
    j print_number
not_contain:
    addi $t1, $t1, 1     # Increment index
    blt $t1, $a1, solve
    j end_solve
print_number:
    move $a0, $t3
    li $v0, 1
    syscall
    li $v0, 4
    la $a0, newline
    syscall
    addi $t1, $t1, 1     # Increment index
    blt $t1, $a1, solve
    j end_solve

end_solve:
    li $v0, 10
    syscall
