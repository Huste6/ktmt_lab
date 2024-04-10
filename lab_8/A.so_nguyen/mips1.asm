.data
    prompt: .asciiz "Nhap so nguyen duong N: "
    prompt2: .asciiz "cac so chia het cho 3 hoac cho 5 nho hon N: "
    newline: .asciiz "\n"
.text
main:
    # In ra thông báo nhập số nguyên dương N
    li $v0, 4           
    la $a0, prompt      
    syscall

    # Nhập số nguyên dương từ bàn phím
    li $v0, 5           
    syscall
    move $s0, $v0       # Lưu số nguyên vào thanh ghi $s0

    # In ra thông báo các số chia hết cho 3 hoặc cho 5 nhỏ hơn N
    li $v0, 4           
    la $a0, prompt2     
    syscall

    # Duyệt từ 1 đến N và in ra các số chia hết cho 3 hoặc cho 5
    li $t0, 1           

loop_start:
    bge $t0, $s0, loop_end   # Nếu t0 >= N thì thoát khỏi vòng lặp
    # Kiểm tra xem số hiện tại có chia hết cho 3 hoặc cho 5 không
    move $a0, $t0       # Truyền số hiện tại vào $a0
    jal check_divisible
    # Nếu kết quả trả về là 1 (chia hết cho 3 hoặc cho 5) thì in ra số đó
    beq $v0, 1, print_number
    # Tiếp tục với số tiếp theo
    addi $t0, $t0, 1
    j loop_start
print_number:
    # In ra số chia hết cho 3 hoặc cho 5
    move $a0, $t0       
    li $v0, 1           
    syscall
    li $v0, 4           
    la $a0, newline     
    syscall
    # Tiếp tục với số tiếp theo
    addi $t0, $t0, 1
    j loop_start
loop_end:
    # Kết thúc chương trình
    li $v0, 10          
    syscall
# Hàm kiểm tra số chia hết cho 3 hoặc cho 5
# $a0: số cần kiểm tra
# $v0: kết quả (1 nếu chia hết cho 3 hoặc cho 5, 0 nếu không)

check_divisible:
    li $v0, 0           # Khởi tạo kết quả là 0
    # Kiểm tra chia hết cho 3
    rem $t1, $a0, 3 
    beq $t1, $zero, divisible
    # Kiểm tra chia hết cho 5
    rem $t1, $a0, 5   
    beq $t1, $zero, divisible
    # Nếu không chia hết cho 3 hoặc cho 5 thì kết quả là 0          
    jr $ra
divisible:
    li $v0, 1
    jr $ra
