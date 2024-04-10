.text
li $s0, 0x80000000
li $s1, 0xfffffffe

xor $t0,$s0,$s1 # check if s0 and s1 have same sign, t0 >=0 if yes , t0<0 if no
bltz $t0,exit # if s0 and s1 doesnt have same sign, exit

addu $s3,$s1,$s2

xor $t1,$s3,$s1
bltz $t1,exit
addi $t2,$t2,1
exit: