.data
str1: .string "s1112463"
strM: .string "input number M = "
strN: .string "input number N = "
strP: .string "P(M,N) = "
strC: .string "C(M,N) = "
strH: .string "H(M,N) = "
strPow: .string "M^N = " 
strLine: .string "\n"
strError: .string "No Output"


.text
main:
	jal printID
	jal changline #換行
	
	jal printM 
	jal input 
	mv s0, a0 # a0 = M, 把輸入的值（在a0）存到 s0, s0 = M
	
	jal printN
	jal input  
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
	add t1, s0, s1 # t1 = M + N
	addi t1, t1, -1 # t1 = M + N -1
	mv a0, t1 # a0 = M + N -1
	jal factoria # a0 = (M + N -1)!
	mv s5, a0 # s5 = (M + N -1)!
	
	
	jal printoutputP # print P(M,N) 
	jal changline 
	
	jal printoutputC # print C(M,N)
	jal changline
	
	jal printoutputH # print H(M,N)
	jal changline
	
	jal power
	mv s6, a0 # a0 = M^N, s6 = M^N
	jal printpower # print M*N
	
	j end # 結束程式
	
	

	
	printID:
		la a0, str1
		li a7, 4	# 4 = print s1112463
		ecall
		ret
	
	changline:
		la a0, strLine
		li a7, 4
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
		li a7, 5 #  5 = 從input console讀int
		ecall
		ret	# 使用者輸入的數字會放在 a0
	
	factoria:
		li t0, 1  # t0 = 1
		mv t1, a0 # a0 = M(N)(M - N)(M + N -1), a0複製到t1, t1 = M(N)(M - N)(M + N -1)
		mv a0, t0 #  t0 = 1 = a0
	loop:
		bge t0, t1, endfactoria # t0 = 1, t1 = M(N)(N - M), 若 1 >= M(N)(N - M)，就結束迴圈，M(N)(N - M) >= 1時，迴圈繼續
		mul a0, a0, t1 # a0 = 1, t1 = M(N)(N - M), a0 * t1的結果存入 a0，a0 = M!(N!)(N - M)!(M + N -1)!
		addi t1, t1, -1 # t1 持續遞減1，存入t1
		jal x0, loop # 無條件跳到 loop，但不存返回位址
	endfactoria:	
		jr ra
		
	printoutputP :
		la a0, strP
		li a7, 4 # 4 = print P(M,N)  = 
		ecall
		
		#  印 P noOutput 條件,  
		li t1, 13
		mv a0, s0 # a0 = M
		blez s0, noOutput # if  M <=  0, noOutput
		bltz s1, noOutput # if  N < 0, noOutput
		beqz s1, output1 # if N == 0, output is 1
		blt s0, s1, noOutput # if M < N, noOutput
		bge s0, t1, noOutput # if M >= 13, noOutput
		
		
		div t1, s2, s4 # t1 = M! / (M - N)!
		
		mv a0, t1 # t1 = a0
		li a7, 1 # 1 =  print the integer
		ecall
		ret
	
	printoutputC:
		la a0, strC
		li a7, 4 # 4 = print C(M,N) = 
		ecall
		
		#  印 C noOutput 條件: 
		li t1, 13
		mv a0, s0 # a0 = M
		blez s0, noOutput # if  M <=  0, noOutput
		bltz s1, noOutput # if  N <  0, noOutput
		beqz s1, output1 # if N == 0, output is 1
		beq	s0, s1, output1 # if M == N, output is 1
		blt s0, s1, noOutput # if M < N, noOutput
		bge s0, t1, noOutput # if M >= 13, noOutput
		
		mul t1, s3, s4 # t1 = (M - N)! * N!
		div t1, s2, t1 # t1 =  M! /  (M - N)! * N!
		
		mv a0, t1 # a0 = t1
		li a7, 1 # 1 = print the interger
		ecall
		ret
	
	printoutputH:
		la a0, strH
		li a7, 4 # 4  = print H(M,N) = 
		ecall
		
		#  印 C noOutput 條件: 
		li t1, 13 # t1 = 13
		blez s0, noOutput # if M <= 0, noOutput
		bltz s1, noOutput # if N < 0, noOutput
		beqz s1, output1 # if N == 0, output must 1
		bge s0, t1, noOutput # if M >= 13, noOutput
		
		mul t0, s0, s5 # t0 = M * (M  + N -1)! 
		mul t1, s2, s3 # t1 = M! * N!
		div t2, t0, t1 #  t2 = M * (M  + N -1)! / M! * N! =  M * (M  + N -1)! / M * (M - 1) * N! = (M  + N -1)! / (M - 1) * N!
		mv a0, t2 # t2 = a0
		li a7, 1 # 1 = print the interger
		ecall 
		ret
	
	power:
		li t0, 1 # t0 = 1
		mv a0,s0 # a0 = M
	loopP:
		bge t0, s1, endpower # 如果t0 >= s1, 1 >= N, 則結束迴圈, 若1 < N, 則繼續迴圈
		mul a0, a0, s0 # a0 = M * M
		addi t0, t0, 1 # t0 = t0 + 1, 等於說M總共乘了N次, a0 = M^N
		jal x0, loopP	
	endpower:
		jr ra	
	
	printpower:
		la a0, strPow
		li a7, 4 # 4 = print M^N = 
		ecall
		
		#  印 Power noOutput 條件: 
		bltz s0, noOutput # if M < 0, no output
		bltz s1, noOutput # if N < 0, no output
		or t0, s0, s1 # t0 = M | N, if t0 == 0, M == 0 and N == 0
		beqz t0, noOutput # if M == 0 and N == 0, no output
		beqz s1, output1 # if N == 0 and M >0 , output must 1
		
		mv a0, s6 # a0 = M^N
		li a7, 1 # 1 = print the interger
		ecall
		ret
		
	noOutput:
		la a0, strError # a0 = No Output 
		li a7, 4	# 4 = print No Output
		ecall
		jr ra
	
	output1:	
		li a0, 1 #  a0 = 1
		li a7, 1 # 1 = print a0
		ecall
		jr ra

	end:
		li a7, 10 #  10 = exit the program
		ecall
		
		
