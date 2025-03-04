.data
nhap1: .asciiz "\nNhap chuoi ma ban thich: "
nhap2: .asciiz "\nChuoi sau khi bien doi la : "
nhap3: .asciiz "So luong chu thuong trong chuoi la: "
string: .space 1000 # buffer , so luong ki tu toi da 
.text

li $v0, 4
la $a0, nhap1
syscall

li $v0, 8
la $a0, string 
li $a1, 100 
syscall
la $t0, string # luu chuoi da nhap vao $t0, $t0 chua dia chi ki tu dau tien 
 
#tim do dai chuoi vua nhap 

addi $s0, $0, 0 # tao bien dem do dai chuoi 
dem:
lb $t9, ($t0)
beq $t9, 10, tiep # 10 la ki tu xuong dong , neu $t9 = ki tu xuong dong thi nhay den nhan 
addi $s0, $s0, 1 # tang bien dem len 1 
addi $t0, $t0, 1 # tang dia chi len 1 , dich qua ki tu tiép theo 
j dem 

# luc nay $s0 la do dai chuoi 
tiep:
addi $t1, $0, 0 # bien chay  i = 0 
addi $t2, $s0, -1 # bien chay j = do dai - 1 

add $t7, $0, $a0
add $a1 ,$0 ,$t7 
lap:
add $t3, $t7, $t1 # dia chi string[i]
lb $t4, ($t3) # gia tri cua string[i] 
add $t5, $t7, $t2 # dia chi string[j] 
lb $t6, ($t5) # gia tri string [j] 
sb $t4, ($t5) #string [j] = string [i]
sb $t6, ($t3)# string [i] = string [j]

addi $t1, $t1, 1 # i++
addi $t2, $t2, -1 # j--

sgt $s2, $t1, $t2 # neu i > j thi $s2 =  1, nguoc lai thi $s2 = 0
beqz $s2, lap # neu $s2 = 0 thi lap 

xuat: 
li $v0, 4
la $a0, nhap2
syscall

li $v0, 4
la $a0, string
syscall

add $s4, $0, 0  # bien dem chu thuong  
la $s2, string # luu dia chi dau tien vào s2 
addi $s7, $0, 0 # bien kiem tra so lan lap , den khi bang do dai chuoi $s0 
dem1:
lb $t8, ($s2)
sge $s3, $t8, 97 # n?u $t1 >= 97 thì $t2 = 1
sle $s5, $t8, 122 # n?u $t1 <= 122 thì $t3 = 1
add $s6, $s3, $s5 
beq $s6, 2, tang_dem 
addi $s2, $s2, 1
addi $s7, $s7, 1 
beq $s7, $s0, tiep1 # so sanh voi do dai chuoi , bang thi ket thuc 
j dem1 
tang_dem:
addi $s4, $s4, 1
addi $s7, $s7, 1 
beq $s7, $s0, tiep1 # so sanh voi do dai chuoi , bang thi ket thuc
j dem1 

tiep1:

li $v0, 4
la $a0, nhap3
syscall

li $v0, 1
add $a0, $s4, $0 
syscall 

li $v0, 10
syscall 
  



 



