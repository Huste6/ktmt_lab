.text
li $s0, 10 #a
li $s1, 16 #power of 2 that will be used to multiple with a
li $s2, 1 #an index used in loop
loop:
#for(int s2 = 1 ; s2 <=s1 ;s2 *=2)
#st0++
#this loop is used to find the pow of 2 of s1
sll $s2,$s2,1
addi $t0,$t0,1
beq $s2,$s1,L1
j loop
L1:
sllv $s3,$s0,$t0