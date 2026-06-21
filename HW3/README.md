# 五格姓名學五行分析系統

**學號：s1112463**

---

## 程式簡介

本程式使用 **RISC-V Assembly Language** 撰寫，根據使用者輸入的姓名筆畫數，計算五格數理（天格、人格、地格、外格、總格），並依照筆畫尾數判斷其所屬五行（金、木、水、火、土）。

接著根據五行相生相剋規則，分析五格之間的關係，並輸出：

- 五格筆畫數
- 五行屬性
- 各格之間的相生、相剋或相同關係

---

## 輸入資料

使用者需依序輸入：

### 姓氏

- 姓氏第一個字筆畫數
- 姓氏第二個字筆畫數

若為單姓：

```text
第二個字輸入 0
```

例如：

```text
王 → 4,0
林 → 8,0
```

複姓：

```text
歐陽 → 15,17
司馬 → 5,10
```

---

### 名字

- 名字第一個字筆畫數
- 名字第二個字筆畫數

若為單名：

```text
第二個字輸入 0
```

例如：

```text
明 → 8,0
家豪 → 10,14
```

---

## 五格計算公式

設：

| 變數 | 內容 |
|--------|--------|
| t0 | 姓第一字 |
| t1 | 姓第二字 |
| t2 | 名第一字 |
| t3 | 名第二字 |

---

### 天格（Sky）

\[
天格=t0+t1
\]

---

### 人格（People）

\[
人格=t1+t2
\]

---

### 地格（Land）

\[
地格=t2+t3
\]

---

### 外格（Outside）

\[
外格=t0+t3
\]

---

### 總格（Total）

\[
總格=t0+t1+t2+t3
\]

---

## 單姓與單名修正規則

由於姓名可能只有一個姓氏字或一個名字字，因此需要額外調整。

---

### 單姓且單名

條件：

```text
t0 = 0 且 t3 = 0
```

修正：

```text
天格 +1
地格 +1
外格 = 2
```

---

### 單姓

條件：

```text
t0 = 0
```

修正：

```text
天格 +1
外格 +1
```

---

### 單名

條件：

```text
t3 = 0
```

修正：

```text
地格 +1
外格 +1
總格 +1
```

---

## 五行判斷規則

利用筆畫數對 10 取餘數：

\[
筆畫 \mod 10
\]

---

### 木（Wood）

```text
1、2
```

---

### 火（Fire）

```text
3、4
```

---

### 土（Earth）

```text
5、6
```

---

### 金（Metal）

```text
7、8
```

---

### 水（Water）

```text
9、0
```

---

## 五行代碼

程式內部使用數字表示五行：

| 數值 | 五行 |
|--------|--------|
| 1 | Wood |
| 2 | Fire |
| 3 | Earth |
| 4 | Metal |
| 5 | Water |

---

## 五行相生關係

相生順序：

```text
木 → 火 → 土 → 金 → 水 → 木
```

例如：

```text
Wood generate Fire
Fire generate Earth
Earth generate Metal
Metal generate Water
Water generate Wood
```

---

## 五行相剋關係

相剋順序：

```text
木剋土
土剋水
水剋火
火剋金
金剋木
```

例如：

```text
Wood restrain Earth
Earth restrain Water
Water restrain Fire
Fire restrain Metal
Metal restrain Wood
```

---

## compare 副程式

功能：

比較兩個五行之間的關係。

輸入：

```assembly
a2 = 第一個五行
a3 = 第二個五行
```

輸出：

| a1 | 關係 |
|------|------|
| 0 | equal |
| 1 | Left generate Right |
| 2 | Left restrain Right |
| 3 | Right restrain Left |
| 4 | Right generate Left |

---

## 程式架構

### input

讀取使用者輸入整數。

---

### computeStroke

計算：

- 天格
- 人格
- 地格
- 外格
- 總格

---

### determineZero

判斷：

- 單姓
- 單名
- 單姓單名

並進行修正。

---

### computeWuxin

功能：

1. 印出格數
2. 判斷五行
3. 回傳五行代碼

---

### compare

比較兩個五行之間的關係。

---

### printSky

輸出：

```text
Sky
```

---

### printPeople

輸出：

```text
People
```

---

### printLand

輸出：

```text
Land
```

---

### printOutside

輸出：

```text
Outside
```

---

### printTotal

輸出：

```text
Total
```

---

## 暫存器使用說明

| 暫存器 | 用途 |
|----------|----------|
| t0 | 姓第一字筆畫 |
| t1 | 姓第二字筆畫 |
| t2 | 名第一字筆畫 |
| t3 | 名第二字筆畫 |
| s0 | 天格 |
| s1 | 人格 |
| s2 | 地格 |
| s3 | 外格 |
| s4 | 總格 |
| s5 | 天格五行 |
| s6 | 人格五行 |
| s7 | 地格五行 |
| s8 | 外格五行 |
| s9 | 總格五行 |
| a1 | 五行關係代碼 |

---

## 執行流程

1. 輸入姓名四個字的筆畫數。
2. 計算五格。
3. 修正單姓或單名情況。
4. 計算各格五行。
5. 顯示五格資訊。
6. 比較各格五行關係。
7. 顯示相生、相剋或相同結果。
8. 結束程式。

---

## 輸出範例

```text
Sky = 13 Fire
People = 17 Metal
Land = 24 Fire
Outside = 20 Water
Total = 36 Earth

Sky restrain People
Sky equal Land
People generate Total
...
```

---

## 開發環境

- RISC-V Assembly Language
- RARS Simulator
- RV32IM Instruction Set

---

## 程式特色

- 實作五格姓名學計算。
- 自動判斷五行屬性。
- 支援單姓、複姓、單名、雙名。
- 分析五格間相生相剋關係。
- 使用模組化副程式設計。
- 展示 RISC-V 函式呼叫與條件分支技巧。
