# Assembly-language

## 介紹

- 使用RISC-V認識計算機概論和組合語言
- 利用RISC-V的一些basic指令去解決問題
- 使用RARS實作

## 使用RARS

STEP 1: 確認java版本環境

<img width="1779" height="665" alt="螢幕擷取畫面 2026-03-10 190848" src="https://github.com/user-attachments/assets/5da9bbc4-d601-43e4-b27d-2eeb785fd330" />


STEP 2: 開空白文件

STEP 3: 完成程式碼後，save as檔案

STEP 4: 組譯 > Run



如要開啟舊檔:

 ```text

RARS 是用 Java 寫的， 所以 rars_27a7c1f.jar 是RISC-V 模擬器

負責:
- 讀 .asm
- 組譯（assemble）
- 模擬 CPU 執行

.asm = 原始碼，所以必須依靠RARS開啟

```
👉 Step 1：開 RARS

 ```text
java -jar rars_27a7c1f.jar
 ```
👉 Step 2：在 RARS 裡面
File → Open

```text
XXX.asm
```

## 常用basic instructions / syscalls / pseudo instructions

| basic instructions | syscalls |  pseudo instructions | 解釋
|--|--|--|--|
|mv a0, s0|||把s0的值複製到a0, s0 = a0|
|addi t1, t1, -1|||t1 - 1 的結果存入t1|
|jal x0, loop|||無條件跳到 loop，但不存返回位址|
|jal ra, printIn|||跳到 printIn，把下一行的位置存給ra|
|||jr ra|Jump to address in ra 暫存器|
|mul t0, s0, s5|||s0 * s5的結果放入t0|
||la a0,str1 <br> li a7,4 <br> ecall||把 str1 的「a0 = str1 的記憶體位置（address）<br> li = load immediate , 4 = 印a0地址的內容|
||li a7, 5 <br> ecall <br> ret || 呼叫系統幫你讀入一個整數, a7 = 5 , 5代表讀入整數 (read integer) <br> 呼叫作業系統執行：這時候系統會等你輸入一個數字,按 Enter 之後 ,輸入的數字會放在a0 <br> 回到呼叫這個 function 的地方| 
||mv a0,t1 <br> li a7, 1 <br> ecall <br> ret || a0 = t1 <br> 1 = 印出a0的數字 |
|bge t0, t4, end|||t0 >= t4, 就結束程式|
|blt s0, s1, noOutput|||( branch if less than), s0 < s1, 則noOutput|
|addi t0, t0, 1|||t0 = t0++ |
||mv a0, t0 <br> li a7, 1 <br> ecall | | a0 = t0 <br> 1 = 把a0裡的數字印出來 |
|||blez s0, noOutput|( branch if less than or equal to zero ), s0 <= 0, 則noOuput|
|||bltz s1, noOutput|( branch if less than zero ), s1 < 0, 則noOuput|
|||beqz s1, output1|( branch if equal zero ), s1 = 0, 則Ouput1|







