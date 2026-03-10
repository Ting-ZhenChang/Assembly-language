.data              # 資料區
str1: .string "Julia"

.global __start

.text # 程式區
__start:
        la       a0, str1       # a0 = str1 的記憶體地址
        li       a7, 4          # a7 = 4，4是systemcalls的編號，代表字串
        ecall	                  # OS print string at address a0
   
        
        li       a7, 10         # a7 = 10，10是systemcalls的編號，代表EXIT 
        ecall
     
