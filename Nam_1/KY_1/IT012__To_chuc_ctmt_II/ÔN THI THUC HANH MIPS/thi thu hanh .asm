# Nhap mang co n phan tu , xuat mang cac phan tu tu nho den lon 
.data 
nhap1: .asciiz "\nNhap so luong phan tu n: "
nhap2: .asciiz "a["
nhap3: .asciiz "] = "
ketqua: .asciiz "\nMang tu be den lon la: "
tap: .asciiz " "
mang: .word 100 # a[100] 
.text 
li $v0, 4
la $a0, nhap1
syscall
# Nhap so luong phan tu n 
li $v0, 5
syscall 
addi $t0, $v0, 0

la $a1, mang 
addi $t1, $0, 0 
Nhap_mang:
sub $t2, $t1, $t0 
beqz $t2, ket_thuc_nhap # neu $t2 = 0 thi ket thuc nhap 

li $v0, 4
la $a0, nhap2
syscall 

li $v0, 1
la $a0, ($t1) # chi so 
syscall

li $v0, 4
la $a0, nhap3
syscall

li $v0, 5 # nhap phan tu 
syscall
sw $v0, ($a1) # a1 la dia chi cua so vua nhap 

addi $t1, $t1, 1 # tang chi so va bien chay len 1  
addi $a1, $a1, 4 
j Nhap_mang 

ket_thuc_nhap:
# sap xep lai mang 
la, $a1, mang 
addi $t1, $0, 0 # bien chay i = 0 

xu_li:
sub $t2, $t1, $t0 
beqz $t2, xong # neu $t2 = 0 thi ket thuc 

lw $a0, ($a1) # $a0 = a[i] 

la $a2, mang # a2 la dia chi o tiep theo cua a1 
addi $t3, $t1, 1 # j = i + 1 , bien chay cua a[j]
  
mul $s1, $t3, 4
add $a2, $a2, $s1 # a[j + 1]

sap_xep:
sub $t4, $t3, $t0 
beqz $t4, thoat # neu $t4 = 0 thi nhay den thoat 

lw $a3, ($a2) # $a3 = a[i+1] = a[j] 
slt $t5, $a3, $a0 # so sanh neu a[i+1] < a[i] , dung thi = 1, else thi = 0 
beqz $t5, khong_thoa 
# tien hanh doi vi tri 
addi $t8, $a3, 0 
addi $a3, $a0, 0
addi $a0, $t8, 0 
sw $a0, ($a1) # luu gia tri vua doi vao a[i] 
sw $a3, ($a2) # luu gia tri vua doi vao a[j] 
khong_thoa:
addi $t3, $t3, 1 # j++
addi $a2, $a2, 4 # tang dia chi o cua a[j] len o tiep theo 
j sap_xep  
thoat: 
addi $t1, $t1, 1 # i++
addi $a1, $a1, 4 # tang dia chi o cua a[i] len 1 o 
j xu_li 

xong:  
# xuat ket qua 
li $v0, 4 
la $a0, ketqua 
syscall
# xuat mang 
la $a1, mang
addi $t1, $0, 0 

Xuat_ketqua:
sub $t2, $t1, $t0 
bgez $t2, exit 

lw $a0, ($a1)
li $v0, 1 
syscall 

li $v0, 4
la $a0, tap
syscall

addi $t1, $t1, 1
addi $a1, $a1, 4
j Xuat_ketqua 
exit:
li $v0, 10 
syscall 








 
  