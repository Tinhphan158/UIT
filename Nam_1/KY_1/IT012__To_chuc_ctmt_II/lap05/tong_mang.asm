.data
mang: .space 100
nhap1: .asciiz "Nhap so luong phan tu mang: "
nhap2: .asciiz "Mang da nhap la: "
nhap3: .asciiz "a["
nhap4: .asciiz "] = "
tap: .asciiz " "
kq: .asciiz "Tong cac phan tu cua mang = " 
.text 
# nhap so luong pt mang
li $v0, 4
la $a0, nhap1
syscall

li $v0, 5 
syscall 

addi $t0, $v0, 0 # luu so luong phan tu mang vào $t0 

addi $t1, $0, 0  # tao chi so mang
la $a1, mang # ??a chi o dau tien cua mang 
addi $s1, $0, 0 
Nhap_mang:
# kt so lan lap
subu $t2, $t1, $t0 
bgez $t2, ketthuc_nhap # neu $t2 >= 0 thì nhay den nhan 

li $v0, 4 # xuat dau ngoac 
la $a0, nhap3
syscall

li $v0, 1
la $a0, ($t1)
syscall


li $v0, 4
la $a0, nhap4
syscall 

li $v0, 5
syscall
sw $v0, ($a1) 
add $s1, $s1, $v0 

# tang chi so va dia chi o len
addi $t1, $t1, 1
addi $a1, $a1, 4
j Nhap_mang 

ketthuc_nhap:
li $v0, 4
la $a0, nhap2
syscall
# khoi tao lai mang de xuat
addi $t1, $0, 0
la $a1, mang
xuat1:
subu $t2, $t1, $t0 
bgez $t2, xuat_kq
# xuat a[i] 
li $v0, 1
lw $a0, ($a1)
syscall

li $v0, 4
la $a0, tap
syscall

# tang chi so va dia chi o 
addi $t1, $t1, 1
addi $a1, $a1, 4
j xuat1 

xuat_kq:
li $v0, 4
la $a0, kq
syscall 
li $v0, 1
la $a0, ($s1) 
syscall 