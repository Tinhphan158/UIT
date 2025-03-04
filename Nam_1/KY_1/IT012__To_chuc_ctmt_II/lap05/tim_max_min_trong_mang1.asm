.data
mang: .space 100
nhap1: .asciiz "Nhap so luong phan tu mang: "
nhap2: .asciiz "a["
nhap3: .asciiz "] = "
nhap4: .asciiz "Mang vua nhap la: "
nhap5: .asciiz "\nMax = "
nhap6: .asciiz "\nMin = "
tap: .asciiz  " "

.text
# xuat dong nhap
li $v0, 4
la $a0, nhap1
syscall
# nhap so luong phan tu mang 
li $v0, 5
syscall
# sao chep so luong phan tu mang vào $t0 
move $t0, $v0
# tao chi so mang và dia chi o 
addi $t1, $0, 0
la $a1, mang
# nhap mang 
Nhap_mang:

subu $t2, $t1, $t0 
bgez $t2, ketthuc_nhap # neu $t2 >= 0 thì nhay den nhan 

li $v0, 4          # xuat cap ngoac chi so 
la $a0, nhap2
syscall

li $v0, 1 # xuat chi so 
la $a0, ($t1)
syscall 

li $v0, 4
la $a0, nhap3
syscall

li $v0, 5 # nhap phan tu mang 
syscall
sw $v0, ($a1)
# tang chi so mang va dia chi o 
addi $t1, $t1, 1
addi $a1, $a1, 4
 
j Nhap_mang 

ketthuc_nhap:
# khoi tao lai chi so va dia chi o 
addi $t1, $0, 0
la $a1, mang

li $v0, 4 # xuat ra thong bao mang vua nhap 
la $a0, nhap4
syscall

Xuat_mang:

subu $t2, $t1, $t0 
bgez $t2, khoi_tao # neu $t2 >= 0 , nhay den nhan 

li $v0, 1
lw $a0, ($a1) # in ra phan tu o dia chi ô dau tien  
syscall

li $v0, 4 # in khoang trang 
la $a0, tap
syscall
# tang chi so mang va dia chi o 
addi $t1, $t1, 1
addi $a1, $a1, 4

j Xuat_mang

khoi_tao:
la $a1, mang # khoi tao lai mang va chi so 
addi $t1, $0, 0 
lw $t3, ($a1) # load dia chi o sang $t3 
move $t4, $t3 # sao chep $t3 sang $t4 

max:
lw $t3, ($a1)
blt $t3, $t4, tang_chi_so1 # neu $t3 < $t4 thi nhay den nhan 
move $t4, $t3 
tang_chi_so1:
addi $t1, $t1, 1
addi $a1, $a1, 4
blt $t1, $t0, max # chi so nho hon so phan tu thi lap tiep 

li $v0, 4
la $a0, nhap5
syscall 

li $v0, 1
move $t5 , $t4 # sao chep gia tri max sang $t5
la $a0, ($t5)
syscall
# min tuong tu 
la $a1, mang
lw $t7, ($a1)
move $t8 $t3 
addi $t1, $0, 0
 
min:
lw $t3, ($a1)
bgt $t3, $t4 , tang_chi_so2 # $t3 > $t4 thi nhay den nhan 
move $t4, $t3 
tang_chi_so2:
addi $t1, $t1, 1
addi $a1, $a1, 4 
blt $t1, $t0, min 

li $v0, 4
la $a0, nhap6 
syscall

li $v0, 1
move $t6, $t4 
la $a0, ($t6)
syscall 

li $v0, 10
syscall








