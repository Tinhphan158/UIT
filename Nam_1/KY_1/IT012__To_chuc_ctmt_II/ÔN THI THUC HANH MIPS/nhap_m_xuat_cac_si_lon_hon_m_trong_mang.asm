.data
input1: .asciiz "Nhap So Luong Phan Tu Mang: "
input2: .asciiz "\nNhap Phan Tu arr["
input3: .asciiz "] = "
input4: .asciiz "Nhap Vao 1 So Nguyen: "
space: .asciiz "\t"
output: .asciiz "Ket Qua: "
arr: .word 0:100 

.text
main:

# Nhap So Luong Phan Tu
la $a0,input1
li $v0,4
syscall

# Chuyen qua thanh ghi $t0
li $v0,5
syscall
move $t0,$v0


# Nhap cac phan tu cua mang

li $t1,0
la $t2,arr

lap:
li $v0,4
la $a0,input2
syscall

li $v0, 1
la $a0, ($t1)
syscall

li $v0, 4
la $a0, input3 
syscall

li $v0,5
syscall

sw $v0,($t2)
addi $t1,$t1,1
addi $t2,$t2,4
blt $t1,$t0,lap

# Nhap M
li $v0,4
la $a0,input4
syscall
li $v0,5
syscall
move $t3,$v0


li $v0,4
la $a0,output
syscall

# xu ly
li $t1,0
la $t2,arr
xuly:
lw $t4,($t2)
ble $t4,$t3,tiep
# input on display
li $v0,1
move $a0,$t4
syscall

# KHoang Trang
li $v0,4
la $a0,space
syscall

tiep:
addi $t1,$t1,1
addi $t2,$t2,4
blt $t1,$t0,xuly

li $v0,10
syscall