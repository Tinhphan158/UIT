.data 
no: .asciiz "invalid type"
.text

li $v0,12
syscall
move $t1,$v0

sge  $t2, $t1, 48 # n?u $t1 >= 48 thì $t2 = 1 , else = 0
sle  $t3, $t1, 57 # n?u $t1 <= 57 thì $t3 = 1 , else = 0
add $t4, $t2, $t3 
seq $t5, $t4, 2 # n?u $t4 = 2 thi $t5 = 1 , else = 0

sge $t2, $t1, 65 # n?u $t1 >= 65 thì $t2 = 1
sle $t3, $t1, 90 # n?u $t1 <= 90 thì $t3 = 1
add $t4, $t2, $t3 
seq $t6, $t4, 2 # n?u $t4 = 2 thi $t6 = 1 , else = 0

sge $t2, $t1, 97 # n?u $t1 >= 97 thì $t2 = 1
sle $t3, $t1, 122 # n?u $t1 <= 122 thì $t3 = 1
add $t4, $t2, $t3 
seq $t7, $t4, 2 # n?u $t4 = 2 thi $t7 = 1 , else = 0

add $t8, $t5, $t6 
add $t9, $t7, $t8 

beqz $t9, xuat_invalid # n?u $t9 = 0 thì nhãy ??n nhãn 
# $t9 khác 0 thì: 
subi $s1, $t1, 1
li $v0, 11
add $a0, $0, $s1
syscall 

li $v0, 11 # int xuong dong 
la $a0, 10
syscall

addi $s1, $t1, 1
li $v0, 11
add $a0, $0, $s1
syscall 

li $v0, 10 # thoat 
syscall

xuat_invalid:
li $v0 4
la $a0, no
syscall 

