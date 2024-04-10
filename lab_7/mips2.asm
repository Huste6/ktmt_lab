.text
main:
	li $a0,2
	li $a1,6
	li $a2,9
	jal max
	nop
	add $s0,$v0,$zero
	li $v0,10
	syscall
endmain:
max:
	add $v0,$a0,$zero #copy a0 in v0
	sub $t1,$a1,$v0 #compute a1-v0
	bltz $t0,oke #if a1 - v0 <0 then no change
	nop
	add $v0,$a1,$zero
oke:	sub $t0,$a2,$v0 #compute a2 - v0
	bltz $t0,done #if a2-v0 <0 then no change
	nop
	add $v0,$a2,$zero
done: jr $ra
	 