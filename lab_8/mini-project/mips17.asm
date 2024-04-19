.data
    	string: .space 1001      
    	mess1: .asciiz "Nhap chuoi: "
    	output: .asciiz "Cac ki tu so in theo chieu nguoc: "
    	space: .asciiz " "
    	newline: .asciiz "\n"
.text
	li $s1,0 	#s1 la bien dem stack
	lb $s7,newline #ket thuc nhap chuoi
	li $s5,48	#ma ascii cho '0'
	li $s6,57	#ma ascii cho '9'
main:
	# In ra mess1
    	li $v0, 4
    	la $a0, mess1
    	syscall

    	# doc chuoi
    	li $v0, 8
    	la $a0, string
    	li $a1, 1001             
    	syscall

    	# In output
    	li $v0, 4
    	la $a0, output
    	syscall

    	#tinh do dai cua chuoi
    	jal length
    	nop

    	la $a0, string
    	li $t0, 0                  # $t0 la chi so bat dau chuoi
check:
	add $t1,$a0,$t0	#luu dia chi hien tai cua chuoi
	lb $t2,0($t1)	#load gia tri ascii cua ki tu hien tai
	
	beq $t2,$s7,end_of_check #kiem tra xem ki tu hien tai co phai la ket thuc chuoi ko
	
	#kiem tra ki tu hien tai co phai la so hay ko
	sle $t8,$s5,$t2	#t8=( s5 < t2 ) kiem tra ki tu co lon hon 0 ko
	sle $t9,$t2,$s6 #t9=(t2 < s6 ) kiem tra ki tu co nho hon 9 ko
	bne $t8,$t9,next_char #neu ko phai la ki tu so -> next_char
	
	#day vao stack
	add $sp,$sp,-4 #cap phat ko gian tren stack
	add $t2,$t2,-48 
	sw $t2,0($sp) #luu so vao stack
	add $s1,$s1,1 #tang bien dem ++
next_char:
	addi $t0,$t0,1 #chuyen sang ki tu tiep theo
	j check
end_of_check:
	beq $s1,$0,end #neu ma stack rong -> end
	
	#lay so trong stack ra de in
	lw $a0,0($sp) #lay o dinh stack
	add $sp,$sp,4 #giai phong khong gian tren stack
	li $v0,1
	syscall
	
	#in ra space
	li $v0,4
	la $a0,space
	syscall
	
	addi $s1,$s1,-1 #giam bien dem stack
	j end_of_check
end:
	li $v0,10
	syscall

#################################################
# ham tinh do dai cua chuoi
# length
# $a0: dia chi cua chuoi
# tra ve do dai cua chuoi luu vao $v0
#################################################
length:
    	#khoi tao bien dem do dai cua chuoi
    	li $t5, 0

loop:
    	#lay ki tu hien tai cua chuoi
    	lb $t6, 0($a0)

    	# neu ki tu hien tai la null (ket thuc chuoi) ->end_loop
    	beq $t6, $zero, end_loop

    	#tang bien dem do dai va tiep tuc vong lap
    	addi $t5, $t5, 1
    	addi $a0, $a0, 1
    	j loop
end_loop:
    	#luu do dai vao v0 va ket thuc
    	move $v0, $t5
    	jr $ra

	
	
	
