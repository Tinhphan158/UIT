.data
string1: .space 6
string2:.space 6
nhap1: .asciiz"\nNhap chuoi thu nhat: "
nhap2:.asciiz"\nNhap chuoi thu hai: "
arra: .word 5
.text
la $s3, arra # s3 la dia chi cua mang chua ket qua

la $a0, nhap1
li $v0, 4
syscall

la $a0, string1
li $a1, 6
li $v0, 8
syscall
la $s0, string1 # s0 la dia chi chuoi 1

la $a0, nhap2
li $v0, 4
syscall

la $a0, string2
li $a1, 6
li $v0, 8
syscall
la $s1, string2 # s1 la dia chi chuoi 2

li $s4, 10

lb $t1, 4($s0) # lay ki tu cuoi cùng luu vao t1 
addi $t1, $t1, -48 # chuyen thanh so 
lb $t2, 4($s1) # lay ki tu cuoi cung luu vao t2 
addi $t2, $t2, -48 # chuyen thanh so 
add $s2, $t1, $t2 # s2 thanh ghi luu tong 
div $s2, $s4 # chia cho 10
mflo $t5 # thuong , là phan nh? 1 
mfhi $t4 # du , ket qua khi cong 2 so 
sw $t4,16($s3) #luu gia tri  vao mang

lb $t1, 3($s0)
addi $t1, $t1, -48
lb $t2, 3($s1)
addi $t2, $t2, -48
add $s2, $t1, $t2 # thanh ghi luu tong 
add $s2, $s2, $t5 # cong them phan nho 1 
div $s2, $s4
mflo $t5
mfhi $t4
sw $t4, 12($s3)

lb $t1, 2($s0)
addi $t1, $t1, -48
lb $t2, 2($s1)
addi $t2, $t2, -48
add $s2, $t1, $t2 # thanh ghi luu tong 
add $s2, $s2, $t5
div $s2, $s4
mflo $t5
mfhi $t4
sw $t4, 8($s3)

lb $t1, 1($s0)
addi $t1, $t1, -48
lb $t2, 1($s1)
addi $t2, $t2, -48
add $s2, $t1, $t2 # thanh ghi luu tong
add $s2, $s2, $t5
div $s2, $s4
mflo $t5
mfhi $t4 
sw $t4, 4($s3)

lb $t1, 0($s0)
addi $t1, $t1, -48
lb $t2, 0($s1)
addi $t2, $t2, -48
add $s2, $t1, $t2 # thanh ghi luu tong 
add $s2, $s2, $t5
sw $s2, 0($s3)

li $s6, 5 # bien dung lai 
li $t6, 0 # bien chay i = 0 
loop:
beq $t6, $s6, end
lw $t5, 0($s3)

add $a0, $0, $t5 # in ra 
addi $v0, $0, 1
syscall

add $s3, $s3, 4 # tang dia chi o len 
add $t6, $t6, 1 # i++ 
j loop

end:
li $v0, 10
syscall












