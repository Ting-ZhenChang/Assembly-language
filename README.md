# Assembly-language

## 介紹

- 使用RISC-V認識計算機概論和組合語言
- 利用RISC-V的一些basic指令去解決問題
- 使用RARS實作

## 使用RARS

STEP 1: 確認java版本且環境

<img width="1779" height="665" alt="螢幕擷取畫面 2026-03-10 190848" src="https://github.com/user-attachments/assets/5da9bbc4-d601-43e4-b27d-2eeb785fd330" />

STEP 2: 開空白文件

STEP 3: 完成程式碼後，save as檔案

STEP 4: 組譯 > Run

## 常用basic instructions / syscalls / pseudo instructions

| basic instructions | syscalls |  pseudo instructions | 解釋
|--|--|--|--|
|mv a0, s0|||把s0的值複製到a0, s0 = a0|
|addi t1, t1, -1|||t1 - 1 的結果存入t1|
|jal x0, loop|||無條件跳到 loop，但不存返回位址|
|||jr ra|Jump to address in ra 暫存器|
|mul t0, s0, s5|||s0 * s5的結果放入t0|
||la a0, str1 <br> li a7,4 <br> ecall||把 str1 的「位置（記憶體位址）」放進 a0 <br> li = load immediate , a7 = 4 , 4代表印字串 <br> 搭配ecall , 執行印strl的字串 |
||li a7, 5 <br> ecall <br> ret || 呼叫系統幫你讀入一個整數, a7 = 5 , 5代表讀入整數 (read integer) <br> 呼叫作業系統執行：這時候系統會等你輸入一個數字,按 Enter 之後 ,輸入的數字會放在a0 <br> 回到呼叫這個 function 的地方| 
||mv a0, t1 <br> li a7, 1 <br> ecall <br> ret || 把t1放進 a0 <br> 告訴系統：我要印整數 , 1代表印整數 <br> 呼叫系統： 把 a0 的整數印出來 <br> 執行印出 |





