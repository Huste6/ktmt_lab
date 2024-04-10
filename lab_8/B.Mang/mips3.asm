.data
    prompt: .asciiz "Nhap so luong phan tu: "
    space: .asciiz " "
    ans: .asciiz "Cap phan tu co tich lon nhat co chi so la: "
    ans1: .asciiz "Cap phan tu co tich lon nhat la: "
    newline: .asciiz "\n"
    A: .word 0:100
.text
main:
    # Print prompt
    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 5
    syscall
    move $t1, $v0 # $t1 la so luong phan tu 

    # nhap cac phan tu
    li $t0, 0      # $t0 = i =0 
    la $a0, A      # Load address of array A

input_loop:
    li $v0, 5
    syscall
    sw $v0, ($a0)  
    addi $t0, $t0, 1
    addi $a0, $a0, 4  
    blt $t0, $t1, input_loop

    # khoi tao
    la $a0, A     # Load address of array A
    li $t0, 0     # t3=i=0
    li $t3, 0     # Max tich
    li $t4, 0     # chi so dau tien cua cap tich lon nhat

find_max_product_pair:
    bge $t0, $t1, end_find_max  #neu ma $t0>=t1 thi thoat ra 

    sll $s0, $t0, 2   #4i
    add $t2, $s0, $a0 # Address of current element
    lw $t5, 0($t2)    # Load value of i
    addi $t6, $t0, 1 #chi so tiep theo

inner_loop:
    bge $t6, $t1, end_inner_loop  #neu t6>=t1 thi thoat khoi vong lap

    sll $s1, $t6, 2   # 4(i+1)
    add $t7, $s1, $a0 # Address of second element
    lw $t8, 0($t7)    # Load value i+1

    mul $t9, $t5, $t8 # nhan 2 so t5 t8
    bgt $t9, $t3, update_max_product 
    nop
    move $t0, $t6
    j find_max_product_pair

update_max_product:
    move $t3, $t9     # Update max
    move $t4, $t0     # Update chi so cua phan tu dau tien cua cap tich max
    move $t7, $t6     # Update chi so cua phan tu thu hai cua cap tich max
    move $k0,$t5
    move $k1,$t8
    move $t0, $t6
    j find_max_product_pair    

end_inner_loop:
    addi $t0, $t0, 1  # Increment outer loop counter
    j find_max_product_pair  # Continue outer loop

end_find_max:
    la $a0, ans
    li $v0, 4
    syscall

    li $v0, 1
    move $a0, $t4
    syscall

    li $v0, 4
    la $a0, space
    syscall

    li $v0, 1
    move $a0, $t7
    syscall

    li $v0, 4
    la $a0, newline
    syscall
    
    la $a0, ans1
    li $v0, 4
    syscall

    li $v0, 1
    move $a0, $k0
    syscall

    li $v0, 4
    la $a0, space
    syscall

    li $v0, 1
    move $a0, $k1
    syscall
    
    # Exit
    li $v0, 10
    syscall
