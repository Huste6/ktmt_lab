.data
arr: .word 1,2,3,4,5,6,7
i: .word 0
n: .word 7
step: .word 1
sum: .word 0

.text 
	addi $s1,$zero ,-1 #s1 = i
	la $s2,arr #load arr
	addi $s3,$zero,6 #n
	addi $s4,$zero, 8 #step
	addi $s5,$zero,0 #sum
	
loop:   add $s1,$s1,$s4 #i=i+step
	add $t1,$s1,$s1 #t1=2*s1
	add $t1,$t1,$t1 #t1=4*s1
	add $t1,$t1,$s2 #t1 store the address of A[i]
	lw $t0,0($t1) #load value of A[i] in $t0
	add $s5,$s5,$t0 #sum=sum+A[i]
	bne $s1,$s3,loop #if i != n, goto loop
