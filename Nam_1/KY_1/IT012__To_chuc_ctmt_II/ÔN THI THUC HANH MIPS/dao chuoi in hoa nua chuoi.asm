.data
nhap1: .asciiz "\nNhap chuoi: "
nhap2: .asciiz "\nChuoi sau khi xu li la: "
string: .space 100

.text

li $v0, 4
la $a0, nhap1
syscall

li $v0, 8
la $a0, string 
li $a1, 100
syscall 

addi $s0, $0, 0
la $t0, string 
length:
lb $t9, ($t0)
beq $t9, 10, tiep
addi $s0, $s0, 1
addi $t0, $t0, 1
j length

tiep:
div $s5, $s0, 2
mflo $s6 
la $a1, string 
addi $s7, $0, 0 
in_hoa:
lb $s1, ($a1)
sle $s2, $s1, 122
sge $s3, $s1, 97
add $s4, $s2, $s3 
beq $s4, 2, nhan 
addi $a1, $a1, 1
addi $s7, $s7, 1 
beq $s7, $s6, xong 
j in_hoa 
nhan:
sub $s1, $s1, 32
sb $s1, ($a1)
addi $s7, $s7, 1
addi $a1, $a1, 1 
beq $s7, $s6, xong 
j in_hoa 
xong:

addi $t1, $0, 0
addi $t2, $s0, -1 


add $t7, $a0, $0
add $a1, $t7, $0 

dao:
add $t3, $t7, $t1
lb $t4, ($t3)
add $t5, $t7, $t2
lb $t6, ($t5)
sb $t4, ($t5)
sb $t6, ($t3)

addi $t1, $t1, 1
addi $t2, $t2, -1
sgt $t8, $t1, $t2 
beq $t8, $0, dao 



li $v0, 4 
la $a0, nhap2
syscall

li $v0, 4
la $a0, string 
syscall


 
  
   
    
     
       
