.text
main:
	li $a0,-45 
	jal abs
	nop
	add $s0,$zero,$v0
	li $v0,10
	syscall
abs:
	sub $v0,$zero,$a0
	bltz $a0,done #if a0<0 then done
	nop
	add $v0,$a1,$zero
done:
	jr $ra