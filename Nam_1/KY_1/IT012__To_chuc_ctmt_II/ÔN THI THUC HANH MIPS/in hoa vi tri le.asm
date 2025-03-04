.data
nhap1: .asciiz "\nNhap chuoi ma ban thich: "
nhap2: .asciiz "\nChuoi sau khi bien doi la : "
nhap3: .asciiz "So luong chu in hoa o vi tri le trong chuoi la: "
string: .space 1000 # buffer , so luong ki tu toi da 
.text

li $v0, 4
la $a0, nhap1
syscall

li $v0, 8
la $a0, string 
li $a1, 100 
syscall 

la $s2, string # luu dia chi o dau tien vao s2 
addi $s1, $0, 0 
dem1:
lb $t8, ($s2)
beq $t8 , 10, xuat
sge $s3, $t8, 97 # n?u $t1 >= 97 thì $t2 = 1
sle $s5, $t8, 122 # n?u $t1 <= 122 thì $t3 = 1
add $s6, $s3, $s5 
beq $s6, 2, nhan
addi $s2, $s2, 2

j dem1

nhan:
sub  $t8, $t8, 32 
sb $t8, ($s2)
addi $s2, $s2, 2
addi $s1, $s1, 1 
j dem1 

xuat: 
li $v0, 4
la $a0, nhap2
syscall

li $v0, 4
la $a0,string 
syscall


li $v0, 4
la $a0, nhap3 
syscall 

li $v0, 1
la $a0, ($s1)
syscall 

li $v0, 10
syscall 
 






  