.data
nhap: .asciiz  " Nhap: \n"
xuat: .asciiz  "Xuat: \n"
string: .space 100
.text
li $v0, 4
la $a0, nhap
syscall
li $v0, 8
la $a0, string
li $a1, 100 
syscall
li $v0, 4
la $a0, xuat 
syscall
la $a0, string
syscall

