## 問題一
原本的版本是錯誤的, 沒考慮到無解、ab互質 bc互質 ac不互質、不互質加重複、ab互質 ac互質 bc不互質、ab互質 bc互質 ac不互質、和0等條件，因此需要修改。
## 問題二
如果32 * 32 個暫存器時, 會需要64個bits. 所以要用:
````
mul x3, x1, x2
mulu x4, x1, x2
````
搭配這兩個指令才能存放64 bits

# Chinese Remainder Theorem (CRT) Solver

**學號：s1112463**

---

## 程式簡介

本程式使用 **RISC-V Assembly Language** 撰寫，用來求解中國餘數定理（Chinese Remainder Theorem, CRT）問題。

使用者輸入：

- 三個除數（Divisor）
- 三個餘數（Remainder）

程式會：

1. 計算總乘積 N
2. 計算三個 Magic Number
3. 利用中國餘數定理求出答案
4. 輸出 Magic Numbers 與最終解

---

## 中國餘數定理

已知：

\[
X \equiv r_1 \pmod{d_1}
\]

\[
X \equiv r_2 \pmod{d_2}
\]

\[
X \equiv r_3 \pmod{d_3}
\]

其中：

- \(d_1,d_2,d_3\) 兩兩互質
- \(r_1,r_2,r_3\) 為對應餘數

則可利用中國餘數定理求得唯一解：

\[
X \equiv
r_1M_1+
r_2M_2+
r_3M_3
\pmod N
\]

其中：

\[
N=d_1d_2d_3
\]

---

## Magic Number 計算方式

### Step 1：計算 N

\[
N=d_1\times d_2\times d_3
\]

---

### Step 2：計算 n1、n2、n3

\[
n_1=\frac{N}{d_1}
\]

\[
n_2=\frac{N}{d_2}
\]

\[
n_3=\frac{N}{d_3}
\]

---

### Step 3：求 Modular Inverse

尋找：

\[
(n_1^{-1}) \bmod d_1
\]

使得：

\[
n_1\times n_1^{-1}\equiv1 \pmod{d_1}
\]

同理可求：

\[
n_2^{-1}
\]

\[
n_3^{-1}
\]

---

### Step 4：計算 Magic Numbers

\[
Magic_1=n_1\times n_1^{-1}
\]

\[
Magic_2=n_2\times n_2^{-1}
\]

\[
Magic_3=n_3\times n_3^{-1}
\]

程式中分別儲存在：

| Register | 內容 |
|-----------|-----------|
| s7 | Magic1 |
| s8 | Magic2 |
| s9 | Magic3 |

---

## 程式架構

### printID

輸出學號。

---

### printD1、printD2、printD3

顯示輸入除數提示：

```text
input divisor 1 :
input divisor 2 :
input divisor 3 :
```

---

### printR1、printR2、printR3

顯示輸入餘數提示：

```text
input remainder 1 :
input remainder 2 :
input remainder 3 :
```

---

### input

讀取使用者輸入整數。

回傳值：

```assembly
a0
```

---

### compute

負責執行主要 CRT 計算：

#### 計算 N

```assembly
N = d1 × d2 × d3
```

#### 計算

```assembly
n1 = N / d1
n2 = N / d2
n3 = N / d3
```

#### 尋找模反元素（Inverse）

利用暴力搜尋法：

```assembly
(n × inverse) mod d = 1
```

找到 inverse 後：

```assembly
magic = n × inverse
```

---

### printMagic

輸出：

```text
magic numbers are
```

以及：

```text
magic1,magic2,magic3,N
```

---

### computeAns

利用 CRT 公式計算：

\[
Answer=
r_1Magic_1
+r_2Magic_2
+r_3Magic_3
\]

接著：

\[
Answer \bmod N
\]

得到最終解。

---

### finalAns

輸出：

```text
answer=
```

以及最終結果。

---

## 暫存器使用說明

| 暫存器 | 用途 |
|----------|----------|
| s0 | d1 |
| s1 | d2 |
| s2 | d3 |
| s3 | r1 |
| s4 | r2 |
| s5 | r3 |
| s6 | N |
| s7 | Magic1 |
| s8 | Magic2 |
| s9 | Magic2 |
| s10 | Final Answer |
| a0 | 函式參數與回傳值 |
| t0~t6 | 暫存運算資料 |

---

## 演算法流程

1. 輸入三個除數 d1、d2、d3。
2. 輸入三個餘數 r1、r2、r3。
3. 計算：

   \[
   N=d_1d_2d_3
   \]

4. 計算：

   \[
   n_1,n_2,n_3
   \]

5. 尋找三個模反元素。
6. 計算三個 Magic Number。
7. 輸出 Magic Numbers。
8. 計算：

   \[
   r_1Magic_1+r_2Magic_2+r_3Magic_3
   \]

9. 對 N 取模。
10. 輸出最終答案。

---

## 執行範例

### Input

```text
input divisor 1 : 3
input divisor 2 : 5
input divisor 3 : 7

input remainder 1 : 2
input remainder 2 : 3
input remainder 3 : 2
```

---

### 計算過程

\[
N=3\times5\times7=105
\]

\[
n_1=35
\]

\[
n_2=21
\]

\[
n_3=15
\]

Magic Numbers：

\[
35\times2=70
\]

\[
21\times1=21
\]

\[
15\times1=15
\]

因此：

\[
Answer
=
2\times70
+
3\times21
+
2\times15
\]

\[
=233
\]

\[
233\bmod105=23
\]

---

### Output

```text
s1112463

magic numbers are 70,21,15,105

answer=23
```

---

## 開發環境

- RISC-V Assembly Language
- RARS Simulator
- RV32IM Instruction Set

---

## 程式特色

- 實作中國餘數定理（CRT）。
- 自行搜尋 Modular Inverse。
- 使用副程式設計，提高程式可讀性。
- 將 Magic Number 與最終答案分開輸出。
- 適合作為 RISC-V 組合語言與數論演算法的實作範例。
