.text
	li $s0,10
	li $s1,-20
.push:
	addi $sp,$sp,-8 #adjust the stack pointer
	sw $s0,4($sp) #push $s0 to stack
	sw $s1,0($sp) #push $s1 to stack
.work:
	nop
	nop
	nop
.pop:
	lw $s0,0($sp)
	lw $s1,4($sp)
	addi $sp,$sp,8