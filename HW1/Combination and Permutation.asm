.data
str1: .string "s1112463"
strM: .string "input number M = "
strN: .string "input number N = "
strP: .string "P(M,N) = "
strC: .string "C(M,N) = "
strH: .string "H(M,N) = "
strPow: .string "M^N = " 

.text
main:
	jal printID
	jal printM 
	jal input # 呼叫 input 函式
	mv s0, a0 # a0 = M, 把輸入的值（在a0）存到 s0, s0 = M
	
	jal printN
	jal input  # 呼叫input函式
	mv  s1, a0 # a0 = N, 把輸入的值（在a0）存到 s1, s1 = N
	
	mv a0, s0 # s0 = M, 把s0的值複製到a0, a0 = M
	jal factoria 
	mv s2, a0 # 跑完factoria後, a0 = M!, a0複製到s2, s2 = M!
	
	mv a0, s1 # s1 = N, s1複製到a0, a0 = N
	jal factoria
	mv s3, a0 # a0 = N!, a0複製到s3, s3 = N!
	
	sub t1, s0, s1 # M - N, t1 = M - N
	
	mv a0, t1 # t1 = M - N, t1複製到a0, a0 = t1
	jal factoria 
	mv s4, a0 # a0 = (M - N)!, a0複製到s4, s4 = (M - N)!
	
	# 重複組合
	
	#
	
	jal printoutputP 
	
	
	

	
	printID:
		la a0, str1
		li a7, 4	# 4 = print s1112463
		ecall
		ret
	
	printM:
		la a0, strM
		li a7, 4
		ecall
		ret
	printN:
		la a0, strN
		li a7, 4
		ecall 
		ret
		
	input:
		li a7, 5 #  從input console讀int
		ecall
		ret	# 使用者輸入的數字會放在 a0
	
	factoria:
		li t0, 1  # t0 = 1
		mv t1, a0 # a0 = M(N)(M - N), a0複製到t1, t1 = M(N)(M - N)
		mv a0, t0 #  t0 = 1 = a0
	loop:
		bge t0, t1, endfactoria # t0 = 1, t1 = M(N)(N - M), 若 1 >= M(N)(N - M)，就結束迴圈，M(N)(N - M) >= 1時，迴圈繼續
		mul a0, a0, t1 # a0 = 1, t1 = M(N)(N - M), a0 * t1的結果存入 a0，a0 = M!(N!)(N - M)!
		addi t1, t1, -1 # t1 持續遞減1，存入t1
		jal x0, loop # 無條件跳到 loop，但不存返回位址
	endfactoria:	
		jr ra
		
	printoutputP :
		la a0, strP
		li a7, 4 # 4 = print P(M,N)  = 
		ecall
		
		
		

