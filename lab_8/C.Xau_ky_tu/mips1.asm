.data
    prompt: .asciiz "Nhap vao 1 xau ky tu: "
    ans: .asciiz "xau la doi xung.\n"
    ans_1: .asciiz "xau khong phai la doi xung.\n"
    lg: .asciiz "do dai xau la: "
    string: .space 10001 
.text
main:
    # in ra prompt
    li $v0, 4
    la $a0, prompt
    syscall
    
    # đọc xâu
    li $v0, 8
    la $a0, string
    li $a1, 10001 
    syscall
    
    move $t0, $a0 #t0 là con trỏ bắt đầu của xâu
    jal length #tính độ dài xâu
    nop 
    move $t1, $v0 #$t1 lưu độ dài của xâu
    addi $t1,$t1,-1
    # init con trỏ đầu, cuối của xâu
    add $t2, $t0, $zero #con trỏ đầu
    add $t3, $t0, $t1 #con trỏ cuối xâu
    addi $t3, $t3, -1 
check_doi_xung:
    bge $t2, $t3, chuoi_doi_xung #nếu con trỏ đầu vượt qua con trỏ cuối thì nó là xâu đối xứng
    lb $t4, 0($t2) #lấy ký tự đầu
    lb $t5, 0($t3) #lấy ký tự cuối
    beq $t4, $t5, tiep_tuc_check
    j khong_la_chuoi_doi_xung
khong_la_chuoi_doi_xung:
    # in ra ans_1
    li $v0, 4 
    la $a0, ans_1
    syscall
    j end
    
chuoi_doi_xung:
    # in ra ans
    li $v0, 4
    la $a0, ans
    syscall
    j end
    
tiep_tuc_check:
    addi $t2, $t2, 1 
    addi $t3, $t3, -1
    j check_doi_xung
    
end:
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
