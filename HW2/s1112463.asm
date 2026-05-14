### s1112463
.data
strID: .string "s1112463\n"
prompt_D1: .string "input divisor 1 :"
prompt_D2: .string "input divisor 2 :"
prompt_D3: .string "input divisor 3 :"
prompt_R1: .string "input remainder 1 :"
prompt_R2: .string "input remainder 2 :"
prompt_R3: .string "input remainder 3 :"

msg_magic: .string "magic numbers are "
comma: .string ","
msg_ans: .string "\nanswer="

.text
main:
	jal printID	### print s1112463
	
	jal printD1
	jal input
	mv s0, a0 ### s0 = d1
	
	jal printD2
	jal input
	mv s1, a0 ### s1 = d2
	
	jal printD3
	jal input 
	mv s2, a0 ### s2 = d3
	
	jal printR1
	jal input
	mv s3, a0 ### s3 = r1
	
	jal printR2
	jal input
	mv s4, a0 ### s4 = r2
	
	jal printR3
	jal input
	mv s5, a0 ### s5 = r3
	
	jal compute ###算出N, n1, n2, n3
	
	jal printMagic ### 印出 magic numbers的值
	
	jal computeAns
	
	jal finalAns ### 印出answer mod N的值
	
	j end	### 結束程式
printID:
	la a0, strID
	li a7, 4
	ecall
	ret

printD1:
	la a0, 	prompt_D1
	li a7, 4 ### print "input divisor 1 :"
	ecall
	ret
printD2:
	la a0, prompt_D2
	li a7, 4 ### print "input divisor 2 :"
	ecall
	ret
printD3:
	la a0, prompt_D3
	li a7, 4 ### print "input divisor 3 :"
	ecall
	ret
printR1:
	la a0, prompt_R1
	li a7, 4 ### print "input remainder 1 :"
	ecall 
	ret
printR2:
	la a0, prompt_R2
	li a7,4 ### print "input remainder 2 :"
	ecall 
	ret 
printR3:
	la a0, prompt_R3
	li a7, 4 ### print "input remainder 3 :"
	ecall 
	ret
input:
	li a7, 5 ### read interger
	ecall
	ret
compute:
	### N = d1*d2*d3
	mul t0, s0, s1
	mul s6, t0, s2      ### s6 = N

	### n1 = N/d1
	div t1, s6, s0

	### n2 = N/d2
	div t2, s6, s1

	### n3 = N/d3
	div t3, s6, s2

	# ## find  n1 mod d1 的 inverse
	rem t4, t1, s0      ### t4 = n1 mod d1
	li t5, 1           

findInv1:
	mul t6, t4, t5
	rem t6, t6, s0

	li t0, 1
	beq t6, t0, doneInv1

	addi t5, t5, 1
	j findInv1

doneInv1:
	mul s7, t1, t5   ### magic1 = n1 * inverse

	### find  n2 mod d2 的 inverse
	rem t4, t2, s1
	li t5, 1

findInv2:
	mul t6, t4, t5
	rem t6, t6, s1

	li t0, 1
	beq t6, t0, doneInv2

	addi t5, t5, 1
	j findInv2

doneInv2:
	mul s8, t2, t5  ### magic2
	
	### find n3 mod d3 的 inverse
	rem t4, t3, s2
	li t5, 1

findInv3:
	mul t6, t4, t5
	rem t6, t6, s2

	li t0, 1
	beq t6, t0, doneInv3

	addi t5, t5, 1
	j findInv3

doneInv3:
	mul s9, t3, t5  ### magic3

	ret
	
printMagic:
	la a0, msg_magic
	li a7, 4 ### print "magic numbers are "
	ecall
	
	li a7, 1 ### 1 表示印出值
	mv a0, s7 ### 印出 n1 的值
	ecall
	
	la a0, comma
	li a7,4 ### 印出逗號
	ecall
	
	li a7, 1
	mv a0, s8 ### 印出 n2 的值
	ecall
	
	la a0, comma
	li a7, 4 ### 印出逗號
	ecall
	
	li a7, 1 
	mv a0, s9 ### 印出 n3 的值
	ecall
	
	la a0, comma
	li a7, 4 ### 印出逗號
	ecall
	
	li a7, 1
	mv a0, s6 ### 印出 N 的值
	ecall
	ret

computeAns:
	mul t0, s3, s7 ### r1*n1
	mul t1, s4, s8 ### r2*n2
	mul t2, s5, s9 ### r3*n3	
	
	add t0, t0, t1 ###  (r1*n1) + (r2*n2)
	add t0, t0, t2 ### t0 = (r1*n1) + (r2*n2) + (r3*n3) = answer
	
	rem s10, t0, s6 ### s10 = answer mod N,  rem之後的結果表示remainder
	
	ret
finalAns:
	la a0, msg_ans
	li a7, 4 ### print "\nanswer="
	ecall
	
	li a7, 1
	mv a0, s10 ### 印出 answer mod N 的值
	ecall
	ret
end:
	li a7, 10
	ecall

