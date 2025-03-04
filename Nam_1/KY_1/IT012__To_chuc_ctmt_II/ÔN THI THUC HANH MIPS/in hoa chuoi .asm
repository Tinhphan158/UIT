#viet chuong trinh nhap vao 1 chuoi, xuat ra chuoi HOA
.data
String: .space 100
Nhap: .asciiz "Nhap vao 1 chuoi: "
Xuat: .asciiz "Chuoi vua nhap chuyen qua chu HOA la: "
.text
.globl main
main:

addi $v0,$0,4
la $a0,Nhap
syscall

la $a0,String
addi $a1,$0,100
addi $v0,$0,8
syscall
#chuoi vua nhap dang nam trong String

la $s0,String
add $t0,$0,$0
add $t1,$s0,$t0
lb $s1,0($t1)
# $s0 la dia chi o dau tien cua chuoi
# $t0 la bien chay
# $t1 la dia chi cua tung ki tu cua chuoi
# $s1 la gia tri cua tung ki tu cua chuoi

Next:
add $t1,$s0,$t0
lb $s1,0($t1)
#2 dong tren de cap nhat $t1 va $s1

bne $s1,$0, VongLap #$s1 bang 0 la het chuoi
addi $v0,$0,4
la $a0,Xuat
syscall

addi $v0,$0,4
la $a0,String
syscall

addi $v0,$0,10
syscall
VongLap:
li $t6,10
beq $s1,$t6,BayQuaKhongKiemTra
li $t4,'A'
slt $t3,$s1,$t4
bne $t3,$0,VongLapKhongPhaiKiTuHoa #ki tu nay nho hon A nen ko phai la HOA
li $t4,'Z'
slt $t3,$t4,$s1
bne $t3,$0,VongLapKhongPhaiKiTuHoa #ki tu nay lon hon Z nen ko phai la HOA
BayQuaKhongKiemTra:
#Neu khong phai la 2 truong hop tren thi ki tu la Hoa
addi $t0,$t0,1
j Next
VongLapKhongPhaiKiTuHoa:

addi $s5,$s1,-32
sb $s5,0($t1)
addi $t0,$t0,1
j Next
