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
	jal printID	### print 1112463
	
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
	
	jal computeInverse ### 算 inverse
	
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
	mul t0, s0, s1 ### t0 = d1 * d2
	mul s6, t0, s2 ### s6 = d1 * d2 * d3 = N
	
	div t1, s6, s0 ###  t1 = M / d1  = n1
	div t2, s6, s1 ###  t2 = M / d2  = n2
	div t3, s6, s2 ### t3 = M / d3   = n3
	
	mv s7, t1 ### s7 = n1
	mv s8, t2 ### s8 = n2
	mv s9, t3 ### s9 = n3
	ret

inverse:
	mv t0, a0 ### t0 = n1 mod d1
	mv t1, a1 ### t1 = d1
	
	li t2, 0 ### t2 = 0
	li t3, 1 ### t3 = 1
	
loop_inv:
	beqz t1, end_inv
	
	div t4, t0, t1 ### q
	rem t5, t0, t1 ### r
	
	mv t0, t1
	mv t1, t5
	
	mul t6, t4, t2
	sub t6, t3, t6
	
	mv t3, t2
	mv t2, t6
	
	j loop_inv

end_inv:
	mv a0, t3 ### 迴圈結束時, a0 = -1
	ret	


computeInverse:
	rem a0, s7, s0 ### a0 = n1 mod d1
	mv a1, s0 ### a1 = d1
	jal inverse
	mv t0, a0 ### t0 = -1
	
	rem t0, t0, s0      ### t0 = inverse mod d1
	add t0, t0, s0      ### 避免負數
	rem t0, t0, s0
	mul s7, s7, t0 ### s7 = magic1
	
	rem a0, s8, s1 ### a0 = n2 mod d2
	mv a1, s1 ### a1 = d2
	jal inverse
	mv t0, a0 
	
	rem t0, t0, s1      ### t0 = inverse mod d2
	add t0, t0, s1      ### 避免負數
	rem t0, t0, s1
	mul s8, s8, t0 ### s8 = magic2
	
	rem a0, s9, s2 ### a0 = n3 mod d3
	mv a1, s2 ### a1 = d3
	jal inverse
	mv t0, a0 
	
	rem t0, t0, s2      ### t0 = inverse mod d3
	add t0, t0, s2      ### 避免負數
	rem t0, t0, s2
	mul s9, s9, t0 ### s9 = magic3
	
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
	add s10, s10, s6
	rem s10, s10, s6
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


