.data
    A: .word 9, 4, 2, -3, -2, 10, 1, 5
    Aend: .word
    space: .asciiz " "
    length: .word 8
.text
    la $a0, A
    la $a1, Aend
    li $s0, 0 # count = 0 (đếm số lượng phần tử)
    li $s1, -1 # i = -1 (i trong vòng lặp 1)

DemPhanTu:
    beq $a1, $a0, Size # So sánh địa chỉ hiện tại trong a1 với địa chỉ cơ sở của mảng A
    addi $a1, $a1, -4 # Địa chỉ a1 giảm để đến từng địa chỉ của từng phần tử trong mảng
    addi $s0, $s0, 1 # Số lượng phần tử tăng thêm 1
    j DemPhanTu

Size:
    addi $t0, $s0, -1 # t0 = Số lượng phần tử của mảng A - 1

loop1:
    addi $s1, $s1, 1 # i++
    li $s2, 0 # j = 0 (j trong vòng lặp 2)
    beq $s1, $t0, after_sort # Nếu i = size - 1 thì thoát

loop2:
    sub $t2, $t0, $s1 # t2 = (size - 1) - i
    beq $s2, $t2, loop1 # Nếu j = (size - 1) - i thì nhảy đến loop1

if_swap:
    sll $t3, $s2, 2 # Tính offset của địa chỉ A[j]
    add $s3, $a0, $t3 # Tính địa chỉ A[j]
    lw $v0, 0($s3) # Load giá trị A[j]
    addi $s3, $s3, 4 # Tính địa chỉ của A[j+1]
    lw $v1, 0($s3) # Load giá trị A[j+1]
    sge $t4, $v0, $v1 # Nếu A[j] >= A[j+1] thì t4 = 1; Nếu A[j] < A[j+1] thì t4 = 0
    beq $t4, $zero, swap # t4 = 0 thì nhảy đến swap
    addi $s2, $s2, 1 # j++
    j loop2

swap:
    sw $v0, 0($s3) # Ghi A[j] vào A[j+1]
    addi $s3, $s3, -4 # Tính địa chỉ của A[j] = địa chỉ của A[j+1] - 4
    sw $v1, 0($s3) # Ghi A[j+1] vào A[j]
    addi $s2, $s2, 1 # j++
    j loop2

after_sort:
    la $a3, A  # Load địa chỉ của mảng vào $a3
    lw $a1, length  # Load độ dài của mảng vào $a1
    # Lặp để in ra từng phần tử của mảng
print_loop:
    lw $t0, 0($a3)  # Load phần tử hiện tại vào $t0
    # In ra phần tử hiện tại
    li $v0, 1 
    move $a0, $t0 
    syscall 
    # In ra một dấu cách
    li $v0, 4 
    la $a0, space 
    syscall 
    addiu $a3, $a3, 4  # Chuyển đến phần tử tiếp theo 
    addiu $a1, $a1, -1  # Giảm độ dài đi 1 
    bgtz $a1, print_loop  # Nếu độ dài > 0, lặp lại vòng lặp 
    li $v0, 10
    syscall

Exit:
    li $v0, 10
    syscall
