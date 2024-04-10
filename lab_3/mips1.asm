.text
	addi $s2,$zero,3 #j=3
	addi $s1,$zero,5 #i=5
	addi $s3,$zero,3 #m=3
	addi $s4,$zero,4 #n=3
	add $s5,$s1,$s2 #i+j
	add $s6,$s3,$s4 #m+n
	start:
		sle $s0,$s1,$s2 #i+j<= m+n ? 1:0
		beq $t0,$zero,else
		addi $t1,$t1,1
		addi $t3,$zero,1
		j endif
	else:
		addi $t2,$t2,-1
		add $t3,$t3,$t3
	endif: