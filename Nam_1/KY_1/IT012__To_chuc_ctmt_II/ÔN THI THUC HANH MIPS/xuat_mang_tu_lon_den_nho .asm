# nhap va xuat mang mot chieu cac so nguyen
# cac thanh ghi su dung:
#  $t0:  so luong phan tu n
#  $t1:  chi so mang
#  $a1:  dia chi co so mang
  .data
input1:  .asciiz  "Nhap n: "
input2:  .asciiz  "a["
input3:  .asciiz  "] = "
output1:  .asciiz  "\nMang da nhap: "
xuat_chuoi_da_xap_xep:  .asciiz  "\nMnag xap xep tang dan la: "
space: .asciiz  " "
array:  .word  100   # int array[100]
.text
# nhap n
  la  $a0, input1# "nhap n"
  addi  $v0, $zero, 4
  syscall

  addi  $v0, $zero, 5
  syscall
  addi  $t0, $v0, 0 # t0: so luong phan tu

# khoi tao
  addi  $t1, $zero, 0 #  $t1:  chi so mang , chi so trong ngoac 
  la  $a1, array  #  $a1:  dia chi co so cua mang

NhapMang:
# kiem tra so lan lap
  subu  $t2, $t1, $t0 # chi so - so phan tu
  bgez  $t2, KetThucNhap # bgez s,label # nhay  nhãn label neu thanh ghi $t2 >=0

  # xuat dau nhac nhap
  la    $a0, input2  # "["
  addi  $v0, $zero, 4
  syscall

  addi  $a0, $t1, 0
  addi  $v0, $zero, 1
  syscall

  la    $a0, input3  # "]"
  addi  $v0, $zero, 4
  syscall

# nhap so nguyen va luu vao array[i]
  addi  $v0, $zero, 5
  syscall
  sw    $v0, 0($a1) # a1 la dia chi cua co so

# tang chi so
  addi  $t1, $t1, 1 # tang chi so len 1
  addi  $a1, $a1, 4 # tang dia chi len 4

  j    NhapMang

KetThucNhap:
  la    $a0, output1 # "Mang da nhap: "
  addi  $v0, $zero, 4 
  syscall
  
  #XUAT MANG
# khoi tao
  la    $a1, array
  addi  $t1, $zero, 0
XuatMang1:
# kiem tra so lan lap
  subu  $t2, $t1, $t0
  bgez  $t2, khoi_tao

# xuat phan tu array[i]
  lw    $a0, 0($a1)
  addi  $v0, $zero, 1
  syscall

  # xuat khoang trang
  la $a0,space
  li $v0,4
  syscall

# tang chi so
  addi  $t1, $t1, 1
  addi  $a1, $a1, 4

  j    XuatMang1

# khoi tao
khoi_tao:
  la    $a1, array
  addi  $t1, $zero, 0
#===================xu ly===============================
# t1 la bien chay lon
# t3 la bien chay nho
# a1 la dia chi cua ptu
#a0 la gia tri cua a[t1] tuc la arr[i]
#a2 la gia tri cua a[t3] tuc la arr[i+1] 
# t0 là s? l??ng ph?n t?
xu_ly:
# kiem tra so lan lap
  subu  $t2, $t1, $t0
  bgez  $t2, xong # $t2 >=0 nhay toi ket thuc

# lay gia tri phan tu a0
  lw    $a0, ($a1) # a0 == a[t1]
  	# khoi tao t3 = t1 + 1: j= i + 1
  	la    $a2, array
  	addi  $t3, $t1, 1
  	# a2 la dia chi cua tiep theo cua a0  a[0] + 4 * j
  	mul $s6, $t3, 4
  	add  $a2, $a2, $s6
  	
  lap:
	# kiem tra so lan lap
  	subu  $t7, $t3, $t0
  	bgez  $t7, thoat # $t7 >=0 nhay toi ket thuc
	
	# lay gia tri ptu a3
  	lw    $a3, ($a2) # a3 == a[t3] 
  	#so sanh a3 voi a0, neu a3 < a0 thì haon doi hai so
  		sgt $t5, $a3, $a0 # a3 < a0 neu dúng thì 1 sai thì 0
  		beq $t5, 0 , khong_thoa # beq t5, 0 , lable ( == )
  		
  		# neu t5 == 1 thi chay tiep
  		# hoan doi gia tri hai so
  		addi $t8, $a3, 0
  		addi $a3, $a0, 0
  		addi $a0, $t8, 0
  		# luu gia tri moi do l?i
  		sw    $a0, ($a1)
  		sw    $a3, ($a2)
  	khong_thoa:	
	# tang chi so
  	addi  $t3, $t3, 1
  	addi  $a2, $a2, 4
  	j lap
thoat:
# tang chi so
  addi  $t1, $t1, 1
  addi  $a1, $a1, 4

  j    xu_ly
#===================xuat mang===========================
xong:
  la    $a0, xuat_chuoi_da_xap_xep # "Mang da nhap: "
  addi  $v0, $zero, 4 
  syscall
# khoi tao
  la    $a1, array
  addi  $t1, $zero, 0
XuatMang:
# kiem tra so lan lap
  subu  $t2, $t1, $t0
  bgez  $t2, KetThuc

# xuat phan tu array[i]
  lw    $a0, ($a1)
  addi  $v0, $zero, 1
  syscall

  # xuat khoang trang
  la $a0,space
  li $v0,4
  syscall

# tang chi so
  addi  $t1, $t1, 1
  addi  $a1, $a1, 4

  j    XuatMang

KetThuc:
  li $v0,10
  syscall
