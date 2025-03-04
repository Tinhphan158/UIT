.data
nhap1: .asciiz  "Nhap so a: "
nhap2: .asciiz  "Nhap so b: "
tong: .asciiz  "Tong = "
.text
li $v0, 4
la $a0, nhap1
syscall
li $v0, 5
syscall
add $t0, $0, $v0
li $v0, 4
la $a0, nhap2
syscall
li $v0, 5
syscall
add $t1, $0, $v0
Tong:
add $t2, $t0, $t1
li $v0, 4
la $a0, tong
syscall
li $v0, 1
la $a0, ($t2)
syscall
