.data 
	string1: .asciiz "Chao ban! Ban la sinh vien nam thu may? \n "
	string2: .asciiz "Hihi, minh la sinh vien nam thu 1 ^_^ \n "
.text 
	la $a0, string1 
	li $v0, 4
	syscall
	la $a0, string2 
	li $v0, 4 
	syscall
	
	
	
	
	
	
