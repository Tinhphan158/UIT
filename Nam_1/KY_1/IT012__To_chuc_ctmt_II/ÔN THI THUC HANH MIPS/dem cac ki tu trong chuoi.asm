.data 
string: .space 100
nhap1: .asciiz "\nNhap chuoi di nao: "
nhap2: .asciiz "\nSo luong chu thuong la: "
nhap3: .asciiz "\nSo luong chu hoa la: "
nhap4: .asciiz "\nSo luong chu so la: "
nhap5: .asciiz "\nSo luong ki tu dac biet la: "

.text

li $v0, 4
la $a0, nhap1
syscall

li $v0, 8 
la $a0, string 
li $a1, 100 
syscall
la $t0, string  # luu chuoi vua nhap vao t0

addi $s0, $0, 0 # tao bien dem do dai chuoi 
dem:
lb $t9, ($t0)
beq $t9, 10, tiep 
addi $s0, $s0, 1 # tang bien dem len 1 
addi $t0, $t0, 1 # tang dia chi o len 1 o 
j dem 
# luc nay length string = $s0 
tiep:
# chu thuong a -> z  <=> 97 -> 122 , bien dem la $s1
# chu hoa A -> Z  <=> 65 -> 90 , bien dem $s2 
# so 0 -> 9  <=> 48 -> 57 , bien dem $s3 
# cac ki tu con lai  , bien dem $s4 


# dem chu thuong 
la $a1, string # luu dia chi o dau tien vao $a1 
addi $t1, $0, 0 # bien chay i 
addi $s1, $0, 0 # dem chu thuong
dem_chu_thuong:
lb $t2, ($a1)
sge $t3, $t2, 97 # $t2 >= 97 thi $t3 = 1, else $t3 = 0 
sle $t4, $t2, 122 # $t2 <= 122 thi $t4 = 1, else $t4 = 0 
add $t5, $t3, $t4 
beq $t5, 2, thoa1   
addi $a1, $a1, 1 # tang dia chi o len 1 
addi $t1, $t1, 1 # tang bien chay len 1 
beq $t1, $s0, xong1 # kt bien chay , so lan lap 
j dem_chu_thuong 
thoa1: 
addi $s1, $s1, 1 # tang bien dem len 1 
addi $a1, $a1, 1 # tang dia chi o len 1 
addi $t1, $t1, 1 # tang bien chay len 1 
beq $t1, $s0, xong1 # kt bien chay , so lan lap 
j dem_chu_thuong 

xong1:
la $a1, string # luu dia chi o dau tien vao $a1 
addi $t1, $0, 0 # bien chay i 
addi $s2, $0, 0 # dem chu thuong
dem_chu_hoa:
lb $t2, ($a1)
sge $t3, $t2, 65 # $t2 >= 65 thi $t3 = 1, else $t3 = 0 
sle $t4, $t2, 90 # $t2 <= 90 thi $t4 = 1, else $t4 = 0 
add $t5, $t3, $t4  
beq $t5, 2, thoa2 
addi $a1, $a1, 1 # tang dia chi o len 1 
addi $t1, $t1, 1 # tang bien chay len 1 
beq $t1, $s0, xong2 # kt bien chay , so lan lap 
j dem_chu_hoa
thoa2: 
addi $s2, $s2, 1 # tang bien dem len 1 
addi $a1, $a1, 1 # tang dia chi o len 1 
addi $t1, $t1, 1 # tang bien chay len 1 
beq $t1, $s0, xong2 # kt bien chay , so lan lap 
j dem_chu_hoa 

xong2:
la $a1, string # luu dia chi o dau tien vao $a1 
addi $t1, $0, 0 # bien chay i 
addi $s3, $0, 0 # dem chu thuong
dem_chu_so:
lb $t2, ($a1)
sge $t3, $t2, 48 # $t2 >= 48 thi $t3 = 1, else $t3 = 0 
sle $t4, $t2, 57 # $t2 <= 57 thi $t4 = 1, else $t4 = 0 
add $t5, $t3, $t4 
beq $t5, 2, thoa3 
addi $a1, $a1, 1 # tang dia chi o len 1 
addi $t1, $t1, 1 # tang bien chay len 1 
beq $t1, $s0, xong3 # kt bien chay , so lan lap 
j dem_chu_so
thoa3: 
addi $s3, $s3, 1 # tang bien dem len 1 
addi $a1, $a1, 1 # tang dia chi o len 1 
addi $t1, $t1, 1 # tang bien chay len 1 
beq $t1, $s0, xong3 # kt bien chay , so lan lap 
j dem_chu_so 

xong3:
dem_ki_tu_dac_biet:
add $t6, $s1, $s2 
add $t7, $t6, $s3 

# xuat

li $v0, 4
la $a0, nhap2
syscall 

li $v0, 1
la $a0, ($s1)
syscall 

li $v0, 4
la $a0, nhap3 
syscall 

li $v0, 1
la $a0, ($s2)
syscall 

li $v0, 4 
la $a0, nhap4
syscall

li $v0, 1
la $a0, ($s3)
syscall 

li $v0, 4
la $a0, nhap5 
syscall

li $v0, 1
la $a0, ($t7)
syscall 









 