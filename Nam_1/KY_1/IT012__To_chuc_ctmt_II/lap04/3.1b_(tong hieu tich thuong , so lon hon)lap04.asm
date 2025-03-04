.data
nhap1: .asciiz  "Nhap so a: "
nhap2: .asciiz  "Nhap so b: "
tong: .asciiz  "Tong = "
hieu: .asciiz  "Hieu = "
tich: .asciiz  "Tich = "
thuong: .asciiz  "Thuong = "
max: "So lon hon la: " 
.text
# nhap 2 so 
li $v0, 4
la $a0, nhap1
syscall
li $v0, 5
syscall
move $t0,$v0
li $v0, 4
la $a0, nhap2
syscall
li $v0, 5
syscall
move $t1, $v0
#tìm so lon trong 2 so
bgt $t0, $t1, in_so1
li $v0, 4
la $a0, max
syscall

li $v0, 1 
add $a0, $t1, $0 
syscall
li $v0, 11
li $a0, 10
syscall
j Tong 
in_so1:
li $v0, 4
la $a0, max
syscall

li $v0, 1 
add $a0, $t0, $0 
syscall
li $v0, 11
li $a0, 10
syscall

#xuat tong
Tong:
add $t2, $t0, $t1
li $v0, 4
la $a0, tong
syscall
li $v0, 1
la $a0, ($t2)
syscall
li $v0, 11
li $a0, 10
syscall
#xuat hieu
Hieu:
sub $t3, $t0, $t1
li $v0, 4
la $a0, hieu
syscall
li $v0, 1
la $a0, ($t3)
syscall
li $v0, 11
li $a0, 10
syscall
#xuat tích 
Tich:
mult $t0, $t1
mflo $t4
li $v0, 4
la $a0, tich
syscall
li $v0, 1
la $a0, ($t4)
syscall
li $v0, 11
li $a0, 10
syscall
#xuat thuong
Thuong:
li $v0, 4
la $a0, thuong
syscall
div $t0, $t1
mflo $t5
li $v0, 1
la $a0, ($t5)
syscall




