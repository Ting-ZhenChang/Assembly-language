.data
_nine: .word 9
_changline: .string "\n"
_space: .string ""

.text
main:
	li t0, 1 # t0 = i
	li t4, 9 # t4 = 9

outer_loop:
	bge t0, t4, end   #  while ( i < = 9 ) {
	jal ra, printIn   #  printin( i )  	# 跳到 printIn，把下一行的位置存給ra
	addi t0, t0, 1    # i = i+1; 
	j outer_loop      # }
printIn:
	mv a0, t0 # a0 = t0 = i
	li a7, 1  #a7 = 1
	ecall
	
	la a0, _changline
	li a7, 4 # 4 = print string
	ecall
	ret	# 要回去outer_loop
	
end:
	li a7,10 # 10 = exit
	ecall
