#################################################
# Dau vao la cac so tu 0 - 999 999 999. In ra cach doc 
#################################################

#################################################
# B1 : kiem tra dau vao
# B2 : chia so dau vao cho 1,000,000. Tach phan du va phan thuong. Neu phan thuong != 0 , tiep tuc chia 100 va chia 10 de lay phan tu
#      cua hang triu. Neu phan thuong == 0 chuyen sang buoc 3.
# B3 : lay phan du cua buoc 2 chia 1000. Tach phan du va phan thuong. Neu phan thuong != 0 , tiep tuc chia 100 va chia 10 de lay phan tu
#      cua hang nghin. Neu phan thuong == 0 chuyen sang buoc 4
# B4 : Lay phan du cua buoc 3 chia cho 100 va 10  
# Note : Sau khi doc duoc 1 chu so ta them vi tri tuong ung cua so do voi " trieu, nghin, tram, muoi" vao sau

###################################################
.data 
	nhapvao: .asciiz "nhap vao mot so nguyen [0;999 999 999]: " 
	new: .asciiz "\n" 
	linh: .asciiz "linh "                 
	khong0: .asciiz "khong "              # gan "khong" cho nhan khong0
	mot1: .asciiz "mot "                  # gan "mot" cho nhan mot1
	hai2: .asciiz "hai "                  # gan "hai" cho nhan hai2
	ba3: .asciiz "ba "                    #gan "ba" cho nhan ba3
	bon4: .asciiz "bon "                  #gan "bon" cho nhan bon4
	nam5: .asciiz "nam "                  #gan "nam " cho nhan nam5
	sau6: .asciiz "sau "                  #gan "sau " cho nhan sau6
	bay7: .asciiz "bay "                  #gan "bay " cho nhan bay7
	tam8: .asciiz "tam "                  #gan "tam " cho nhan tam8
	chin9: .asciiz "chin "                #gan "chin " cho nhan chin9
	muoi10: .asciiz "muoi "               #gan "muoi " cho nhan muoi10
	tram100: .asciiz "tram "              #gan "tram" cho nhan tram
	nghin: .asciiz "nghin "               #gan "nghin" cho nhan nghin
	trieu: .asciiz "trieu "               #gan "trieu" cho nhan trieu
	str_number: .asciiz "dang so: "
	output: .asciiz "\ndang chu: "
	warning_input: .asciiz "du lieu nhap khong hop le!\n"
.text
main:
 	input:
        la $a0, nhapvao                #load address into $a0
        li $v0, 4                      #call to print string
        syscall
        # input integer
        li $v0, 51                      #read integer
        syscall                        
        
        beq $a1, -3, warning
        beq $a1, -1, warning
        move $s0, $a0                  #copy value $a0 -> $s0

        #check input
        blt $s0, $zero, warning 	 #if s0 < 0 then warning
        ble $s0, 999999999, end_warning      # if s0 <= 999999999 then end_warning
	warning:
        la $a0, warning_input
        li $a1, 2
        li $v0, 55
        syscall
        j input
    end_warning:
        la $a0, str_number
        li $v0, 4
        syscall

        add $a0, $s0, $0
        li $v0, 1
        syscall
        
        la $a0, output
        li $v0, 4
        syscall
        
        bne $s0, $0, xuly              # if $s0 != 0 then xuly
        jal convert0to9               # if $s0 = 0 then convert0to1
        j exit                         # thoat
    xuly:
        jal chiamottrieu              # thuc hien ham chiamottrieu   
        jal chiamotnghin              # thuc hien ham chiamotnghin
        jal chiamottram               # thuc hien ham chiamottram
    exit:
        li $v0, 10                   
        syscall                     
end_main:


##################################################
#ham convert0to9
#doc so tu 0 den 9 sang tieng viet
##################################################    
convert0to9 :               
    addi $sp , $sp, -4            # create stack 
    sw  $ra, 0($sp)	       # cat du lieu vao stack
switch:
    khong:
        bne $s0,0,mot                  # if $s0 != 0 then lable mot
        li $v0, 4                     # goi toi print string
        la $a0, khong0                # gan addr label khong0 -> $a0
        syscall                      # thuc hien lenh tren
        j end_switch                 # ket thuc switch
    mot:
        bne $s0,1,hai
        li $v0, 4  
        la $a0, mot1
        syscall
        j end_switch
    hai:
        bne $s0,2,ba
        li $v0, 4  
        la $a0, hai2
        syscall
        j end_switch 
    ba:
        bne $s0,3,bon
        li $v0, 4  
        la $a0, ba3
        syscall
        j end_switch
    bon:
        bne $s0,4,nam
        li $v0, 4  
        la $a0, bon4
        syscall
        j end_switch
    nam: 
        bne $s0,5,sau
        li $v0, 4  
        la $a0, nam5
        syscall 
        j end_switch
    sau:
        bne $s0,6,bay
        li $v0, 4  
        la $a0, sau6
        syscall
        j end_switch
    bay: 
        bne $s0,7,tam
        li $v0, 4  
        la $a0, bay7
        syscall
        j end_switch
    tam:
        bne $s0,8,chin
        li $v0, 4  
        la $a0, tam8
        syscall
        j end_switch
    chin:
        bne $s0,9,muoi
        li $v0, 4  
        la $a0, chin9
        syscall
        j end_switch
    muoi:
        bne $s0,10,end_switch
        li $v0, 4  
        la $a0, muoi10
        syscall
end_switch:                      # ket thuc switch
end_convert0to9:                # ket thuc ham convert0to9
    lw $ra, 0($sp)                  
    addi $sp, $sp, 4                # nhay $sp len 4 byte
    jr $ra                          # back thu tuc goi ham hien tai

###########################################
#ham chiamottrieu
#doc he so truoc hang 1 trieu
##########################################
chiamottrieu:
    addi $sp , $sp, -4                     # create stack
    sw  $ra, 0($sp)                        # doc du lieu vao stack
            
    li $t1,1000000	                 # gan t1 = 1 000 000     
    div $s0,$t1                            #s0 chia 1.000.000
    mflo $s0                               # s0 = s0 /1.000.000
    mfhi $s1                               # s1 = S1 %1.000.000
    beq $s0, $0, end_chiamottrieu          # if $s0 == 0 -> khong co so hang trieu - > end_chiamottrieu 
    
    jal chiamottram                        # tro den ham chiamottram
    
    li $v0, 4                              # call to print string
    la $a0, trieu                          # print " trieu"
    syscall                                # thuc hien
end_chiamottrieu:                        # ket thuc chiamottrieu
    add $s0,$s1,$zero                          
    lw $ra, 0($sp)                         # lay du lieu tu stack vao $ra
    addi $sp, $sp, 4                              
    jr $ra

################################ 
# ham chiamotnghin
# doc he so hang nghin
###############################
chiamotnghin:
    addi $sp , $sp, -4
    sw  $ra, 0($sp)                         # cat du lieu thanh ghi $ra vao stack pointer
  
    beq $s0,$zero,end_chiamotnghin          # if $s0==0 -> khong co so hang nghin -> end_chiamotnghin
    li $t1,1000                             # gan $t1 = 1000
    div $s0,$t1                             #s0 chia 1000
    mflo $s0                                # s0 = s0 /1000
    mfhi $s1                                # s1 = s1 %1000
    beq $s0,$zero,end_chiamotnghin          # if $s0 = 0 -> end_chiamotnghin
    jal chiamottram                         # nhay den ham chiamottram

    li $v0, 4                               # call to print string
    la $a0, nghin                           # print " nghin"
    syscall                                 # thuc hien
end_chiamotnghin:                        # ket thuc ham chiamotnghin
    add $s0,$s1,$zero                       # gan phan du cho $s0

    lw $ra, 0($sp)                           #luu $sp vao $ra
    addi $sp, $sp, 4
    jr $ra

############################# 
## ham chiamottram
# doc so o hang tram 
#############################
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
chiamottram:
    addi $sp , $sp, -4                          #create stack
    sw  $ra, 0($sp)
  
    beq $s0,$zero,end_chiamottram               # if $s0 = 0 -> end_chiamottram     

    li $t1,100                                  # gan $t1 = 100    
    div $s0,$t1                                 #s0 chia 100
    mflo $s0                                    # s0 = s0 /100 ( phan thuong )
    mfhi $s7                                    # $s7 = phan du
    beq $s0, $0, xulyhangchuc                   # if $s0 = 0 -> xulyhangchuc
    jal convert0to9                            # doc so
 
    li $v0, 4                                  # call to print string
    la $a0, tram100                            # print "string"
    syscall                                    # thuc hien
  
  
    add $s0, $s7, $0                           # gan phan du cho $s0
    beq $s0, $0, end_chiamottram               # if $s0 = 0 -> end_chiamottram
  
    slti $t1,$s0,10                            # if s0 < 10 then in_linh
    beq  $t1,1,in_linh                        # if $t1=1 -> xuat linh vd 202 : hai tram linh hai
xulyhangchuc:
    mfhi $s0                                   # s0 = S0 %100 truong hop 000
    beq $s0,$zero,end_chiamottram              # phan du bang 0 -> end_chiamottram 
    jal chiamuoi                               # nhay den ham chiamuoi
    j end_chiamottram                          # ket thuc ham chiamottram
in_linh:
    li $v0, 4                              #call to print string
    la $a0, linh                           #print "linh"
    syscall 
end_chiamottram:
   lw $ra, 0($sp)                         # lay du lieu tu stack pointer vao $ra
   addi $sp, $sp, 4
   jr $ra                                 


#########################
#  ham chiamuoi
#  doc ra hang chuc
#########################

chiamuoi:
    addi $sp, $sp, -4                        # create stack
    sw $ra, 0($sp)
    blt $s0, 20, doivoisonhohon20            #if $s0 < 20 -> ham doivoisonhohon20
    bge $s0, 20, doivoisolonhon20            #if $s0 >= 20 ->  ham doivoisolonhon20

# thuc hien neu $s0 >= 20
doivoisolonhon20:
    li $t1,10                                # gan $t1 = 10
    div $s0,$t1                              # $s0 chia 10
    mflo $s0                                 # gan $s0 = thuong
    beq $s0, $0, continue_chiamuoi           # if $s0 = 0 -> continue_chiamuoi chi chua hang don vi
    jal convert0to9                          # doc
    li $v0, 4                                # call to print string
    la $a0, muoi10                           # print "muoi"
    syscall
    j continue_chiamuoi

#thuc hien neu $s0 < 20
doivoisonhohon20:
    li $t1,10                               # gan $t1 = 10
    div $s0,$t1                             # $s0 chia 10
    mflo $s0                                # thuong
    beq $s0,$0,continue_chiamuoi
    li $v0, 4                                # call to print string
    la $a0, muoi10                           # print "muoi"
    syscall 
    j continue_chiamuoi

continue_chiamuoi:
    mfhi $s0                                 # gan phan du cho $s0
    beq $s0,$zero,end_chiamuoi               # if $s0 = 0 ->end_chimuoi
    jal convert0to9                          # doc
    j end_chiamuoi

end_chiamuoi:                              # ket thuc ham chiamuoi
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra