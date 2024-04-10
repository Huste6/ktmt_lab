.data
	prompt: .asciiz "Nhap so nguyen N: "
	newline: .asciiz "\n"
.text
main:
	#in ra prompt
	li $v0,4
	la $a0,prompt
	syscall
	
	#nhap so nguyen N:
	li $v0,5
	syscall
	move $s0,$v0 #N=s0
	
	li $t0,1 #i=1
loop_start:
	bge $t0,$s0,loop_end
	move $a0,$t0
	jal is_square
	beq $v0,1,print_number
	addi $t0,$t0,1
	j loop_start
print_number:
	#in ra so chinh phuong
	move $a0,$t0
	li $v0,1
	syscall
	
	li $v0,4
	la $a0,newline
	syscall
	
	addi $t0,$t0,1
	j loop_start
loop_end:
	li $v0,10
	syscall
#ham kiem tra so chinh phuong
#a0 la so can kiem tra
#v0 : ket qua cua chuong trinh (0 la ko , 1 la so chinh phuong)
is_square:
	li $v0,0
	beq $a0,$zero,not_square
	li $t1,1 #i=1
check_square:
	mul $t2,$t1,$t1
	bgt $t2,$a0,not_square
	beq $t2,$a0,end_check
	addi $t1,$t1,1
	j check_square
end_check:
	li $v0,1
	jr $ra
not_square:
	li $v0,0
	jr $ra
