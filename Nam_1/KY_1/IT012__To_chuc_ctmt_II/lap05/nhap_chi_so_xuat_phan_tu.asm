.data
mang: .space 100
nhap1: .asciiz "Nhap so luong phan tu mang: "
nhap2: .asciiz "a["
nhap3: .asciiz "] = "
nhap4: .asciiz "Hay nhap chi so cua mang = "
nhap5: .asciiz "Ket qua la: "
nhap6: .asciiz "Mang sau nhap la: "
nhap7: .asciiz "Nhap chi so cua phan tu: "
tap: .asciiz " "
nhap8: .asciiz "\n"
.text
li $v0, 4
la $a0, nhap1
syscall

li $v0, 5
syscall

move $t0, $v0 

la $a1, mang 
addi $t1, $0, 0

Nhap_mang:
sub  $t2, $t1, $t0
bgez $t2, ketthuc_nhap # neu $t2 >= 0 thi nhay den nhan

li $v0, 4
la $a0, nhap2
syscall

li $v0, 1
la $a0, ($t1)
syscall 

li $v0, 4
la $a0, nhap3
syscall 

li $v0, 5
syscall 
sw $v0, ($a1) 
addi $t1, $t1, 1
addi $a1, $a1, 4
j Nhap_mang 

ketthuc_nhap:
la $a1, mang
addi $t1, $0, 0

li $v0, 4
la $a0, nhap6
syscall

Xuat_mang:
sub $t2, $t1, $t0 
bgez $t2, xu_li


lw $a0, ($a1)
li $v0, 1 
syscall

li $v0, 4
la $a0, tap
syscall

addi $t1, $t1, 1
addi $a1, $a1, 4

j Xuat_mang 

 
xu_li:
li $v0, 4
la $a0, nhap8 # xuong dong 
syscall

li $v0, 4
la $a0, nhap4
syscall 

li $v0, 5
syscall
move $s1, $v0 

addi $t1, $0, 0  
la $a1, mang 


check:
beq $t1, $s1 , xuat 

addi $t1, $t1, 1
addi $a1, $a1, 4
j check 
xuat: 
li $v0, 4
la $a0, nhap5
syscall 

lw $s1, ($a1)
addi $a0, $s1, 0 
li $v0, 1
syscall 




 
