.data
	message1:.asciiz "Nhap so N" 
	message2:.asciiz "Ket qua gia thua: "
.text
main:
	li $v0,51
	la $a0,message1
	syscall
	
	bltz $a0,main #neu a0<0 yeu cau nhap lai
	nop
	
	jal fact
	nop
	add $a1,$v0,$zero #a1 luu ket qua
	li $v0,56
	la $a0,message2
	syscall
fact:
	addi $sp,$sp,-8
	sw $ra,($sp)
	sw $s0,4($sp)
	
	li $v0,1
	beq $a0,$zero,endfact
	nop
	add $s0,$a0,$zero #$s0=N
	addi $a0,$a0,-1 #$N=N-1
	jal fact
	nop
	mul $v0,$v0,$s0 
	mflo $v0 
endfact:
	lw $ra,($sp)
	lw $s0,4($sp)
	addi $sp,$sp,8
	jr $ra