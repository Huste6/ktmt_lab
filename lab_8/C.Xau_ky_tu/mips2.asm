.data
    	prompt: .asciiz "Nhap vao xau ky tu: "
    	ans: .asciiz "cac ky tu khac nhau: "
    	space: .asciiz " "
    	string: .space 1001
.text
main:
    	# in ra prompt
    	li $v0, 4
    	la $a0, prompt
    	syscall
    	
    	# đọc xâu
    	li $v0, 8
    	la $a0, string
    	li $a1, 1001 
    	syscall
    
    	move $t0, $a0 # t0 là con trỏ đầu tiên
    
    	# tính độ dài xâu
    	jal length
    	nop
    	move $t1, $v0
    	addi $t1, $t1, -1 # lưu độ dài của xâu

    	add $t2, $t0, $zero # con trỏ đầu tiên
    	add $t3, $t0, $t1 # con trỏ cuối cùng
    	addi $t3, $t3, -1 # lưu con trỏ cuối cùng
    	
    	#in ra ans
    	li $v0,4
    	la $a0,ans
    	syscall
    	
    	# vòng lặp để kiểm tra từng ký tự
solve:
    	bge $t2, $t3, end_solve # nếu con trỏ đầu tiên vượt qua con trỏ cuối cùng thì kết thúc
    	
    	jal check_thuoc
    	nop
    	beq $t8, $zero, print # nếu ký tự không trùng thì in ra
    	addi $t4, $t4, 1 # tăng index
    	add $t2, $t2, $t4 # chuyển sang ký tự tiếp theo
    	j solve
print:
    	lb $a0, 0($t2) # lấy ký tự cần in ra
    	li $v0, 11
    	syscall
    	
    	#in ra space 
    	li $v0,4
    	la $a0,space
    	syscall
    	
    	addi $t4, $t4,1 # tăng index
    	add $t2, $t2, $t4 # chuyển sang ký tự tiếp theo
    	j solve
    	
end_solve:
    	li $v0, 10
    	syscall

# hàm tính độ dài của xâu
length:
    	la $t4, string # lưu địa chỉ của xâu
    	li $t5, 0 # start index
loop:
    	add $t7, $t4, $t5
    	lb $t6, 0($t7)
    	beq $t6, $zero, end_loop # nếu duyệt hết thì chuyển đến end_loop
    	addi $t5, $t5, 1 # index ++
    	j loop
end_loop:
    	move $v0, $t5 # lưu độ dài của xâu
    	jr $ra

# hàm kiểm tra xem ký tự có nằm trong chuỗi hay không
# $t8 trả về 0 nếu không có ký tự nào trùng, 1 nếu có ký tự trùng
check_thuoc:
    	la $t4, string
    	li $t5, 0
    	li $t8, 0
loop1:
    	add $t7, $t4, $t5
    	lb $t6, 0($t7)
    	beq $t6, $t2, end_loop1
    	addi $t5, $t5, 1 # tăng index
    	j loop1
end_loop1:
	
    	jr $ra
