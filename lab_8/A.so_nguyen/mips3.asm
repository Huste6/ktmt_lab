.data
    promptM: .asciiz "Nhap so nguyen M: "
    promptN: .asciiz "Nhap so nguyen N: "
    newline: .asciiz "\n"
.text
main:
    # In ra promptM
    li $v0, 4
    la $a0, promptM
    syscall

    # Nhập số nguyên M
    li $v0, 5
    syscall
    move $s0, $v0 # Lưu số nguyên M vào $s0

    # In ra promptN
    li $v0, 4
    la $a0, promptN
    syscall

    # Nhập số nguyên N
    li $v0, 5
    syscall
    move $s1, $v0 # Lưu số nguyên N vào $s1

    move $t0, $s0 # i = M
loop_start:
    bgt $t0, $s1, loop_end # Nếu i > N thì thoát khỏi vòng lặp

    move $a0, $t0
    jal is_prime
    beq $v0, 1, print_prime

    addi $t0, $t0, 1
    j loop_start

loop_end:
    li $v0, 10
    syscall

# Hàm kiểm tra số nguyên tố
# $a0: số cần kiểm tra
# $v0: kết quả (1 nếu là số nguyên tố, 0 nếu không)
is_prime:
    li $v0, 0 # Khởi tạo là không phải là số nguyên tố
    beq $a0, $zero, not_prime # Nếu số đang xét là 0 thì không phải là số nguyên tố
    beq $a0, 1, not_prime # Nếu số đang xét là 1 thì không phải là số nguyên tố
    li $t1, 2  # i = 2
check_divisible:
    mul $t2, $t1, $t1
    bgt $t2, $a0, end_check # Nếu i^2 > số cần kiểm tra thì kết thúc kiểm tra
    rem $t2, $a0, $t1
    beq $t2, $zero, not_prime # Nếu số đang kiểm tra chia hết cho i thì không phải là số nguyên tố
    addi $t1, $t1, 1
    j check_divisible
end_check:
    li $v0, 1 # Nếu đã kiểm tra hết các trường hợp không chia hết thì là số nguyên tố
    jr $ra
not_prime:
    jr $ra
print_prime:
    move $a0, $t0
    li $v0, 1
    syscall
    li $v0, 4
    la $a0, newline
    syscall
    addi $t0, $t0, 1
    j loop_start
