.text
	li $s1,26
	li $s2,20
	slt $t0,$s1,$s2 #t0=(s1<s2) ? 1:0
	beq $t0,$zero,L1 # if(s1>=s2) goto L1 ,else go to next line
	j Exit
L1:
	addi $t1,$zero,1
Exit: