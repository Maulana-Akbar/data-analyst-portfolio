
# data-analyst-portfolio-project

<h1 align="center">Superstore Profitability & Discount Impact Analysis</h1>

<p align="center">
  <img src="https://img.shields.io/badge/Tools-Power%20BI-yellow?style=for-the-badge&logo=powerbi" alt="Power BI" />
  <img src="https://img.shields.io/badge/Language-DAX-blue?style=for-the-badge" alt="DAX" />
  <img src="https://img.shields.io/badge/Data%20Prep-Power%20Query-orange?style=for-the-badge" alt="Power Query" />
  <img src="https://img.shields.io/badge/Status-Completed-success?style=for-the-badge" alt="Status" />
</p>

---

## Project Overview

Project ini menganalisis hubungan antara angka penjualan (*Sales*), tingkat diskon (*Discount Rate*), dan profitabilitas (*Profit*) menggunakan dataset **Sample - Superstore**. Tujuan utama dari analisis ini adalah untuk mengidentifikasi pemicu utama kebocoran profit (*profit leakage*), mengevaluasi batas aman pemberian diskon, dan memberikan rekomendasi bisnis berbasis data guna mencegah pendarahan finansial akibat strategi pemotongan harga yang tidak terkendali.

<blockquote align="center">
  <b>"Ilusi Volume Penjualan vs Margin Keuntungan"</b><br>
  <i>Kejatuhan ritel raksasa seperti Bed Bath & Beyond membuktikan bahwa ketergantungan kronis pada diskon agresif dapat menciptakan ilusi tingginya omzet sekaligus menghancurkan margin keuntungan secara fatal.</i>
</blockquote>

---

## Business Questions

* **Bagaimana dampak pemberian diskon terhadap profitabilitas perusahaan secara keseluruhan?**
* **Berapa ambang batas maksimal diskon (*tipping point*) sebelum transaksi berbalik menjadi rugi?**
* **Sub-kategori produk dan wilayah (*Region*) mana yang menjadi penyumbang kerugian terbesar akibat diskon?**
* **Bagaimana tren kebocoran profit pada produk berbiaya logistik tinggi secara historis (2014–2017)?**

---

## Dataset

* **Source:** `Sample - Superstore.csv` (Retail Dataset)
* **Total Records:** 9,994 Baris
* **Total Features:** 21 Kolom

---

## Data Preparation

Proses pembersihan dan manipulasi data dilakukan untuk memastikan akurasi analisis:

* **Data Quality Assessment:** Validasi tidak ditemukannya *missing values* dan data duplikat (*0 duplicates*).
* **Data Type Conversion (Locale US):**
  * Mengubah `Order Date` dan `Ship Date` menjadi tipe `Date`.
  * Mengubah `Sales`, `Profit`, dan `Discount` menjadi `Decimal/Float`.
  * Mengubah `Quantity` menjadi `Integer`.
* **Outlier Identification (Categorical):** Evaluasi distribusi pada `Ship Mode` (Standard Class 59.72%), `Segment` (Consumer 51.94%), dan `Region` (West 32.05%).
* **Feature Engineering (DAX / Calculated Columns):**
  * **`Discount Segment`**: Pengelompokan rentang diskon (`0% (No Discount)`, `1%-10%`, `11%-20%`, `21%-30%`, `31%-40%`, `41%+`).
  * **`Order Type`**: Pengelompokan status transaksi (`No Discount` vs `Discounted`).

---

## Tools & Technologies

* **Power BI Desktop:** Pemodelan data, pembuatan *DAX Measures*, dan pembuatan interaktif *Dashboard*.
* **Power Query (M Language):** *Data Cleaning* dan transformasi *Locale*.
* **DAX (Data Analysis Expressions):** *Feature Engineering* dan kalkulasi agregasi.

---

## Key Findings

### 1. High Sales Volume vs Thin Margin Leakage
* **Total Sales:** **$2,297,200.86**
* **Total Profit:** **$286,397.00**
* **Discount Rate:** **15.62%**
* **Profit Margin:** **12.47%**
* Merekam volume pendapatan kotor yang masif, namun rata-rata diskon 15.62% memberikan tekanan berat yang menahan margin keuntungan di angka tipis 12.47%.

### 2. Ambang Batas Aman Diskon (The 20% Tipping Point)
* Transaksi pada segmen diskon **0% hingga 20%** konsisten menghasilkan profit positif (puncak tertinggi pada rentang **1%–10%** dengan rata-rata profit **$96.06**).
* Ketika diskon melewati **20%**, rata-rata profit berbalik menjadi negatif dan menghasilkan kerugian terdalam pada segmen **31%–40%** sebesar **-$109.22**.

### 3. Sub-Kategori Produk Berbiaya Logistik Tinggi Penyumbang Rugi Terbesar
* Seluruh produk tanpa diskon mencatatkan profit positif (tertinggi pada **Copiers** di angka **$1,616.19** dan **Machines** sebesar **$935.79**).
* Pemberian diskon pada produk berat/logistik tinggi langsung menyeret profitabilitas ke area negatif, dengan kerugian rata-rata terparah pada sub-kategori **Machines (-$276.20)** dan **Tables (-$125.51)**.

### 4. Kebocoran Profit Terpusat pada Wilayah Tertentu
* Transaksi tanpa diskon di seluruh wilayah bernilai positif (tertinggi di **East** sebesar **$950.86**).
* Kerugian rata-rata akibat diskon pada produk *Tables & Machines* terparah terkonsentrasi di wilayah **South (-$422.46)** dan **East (-$263.32)**.

### 5. Pendarahan Finansial Konsisten Sepanjang Tahun (2014–2017)
* Evaluasi tren historis menunjukkan transaksi *Tables & Machines* tanpa diskon (*garis merah*) selalu berada di area positif hingga puncak **$2.8K**.
* Sebaliknya, transaksi berdiskon (*garis hijau*) hampir selalu berada di bawah garis nol, membuktikan adanya pendarahan finansial kronis yang terjadi berkelanjutan.

---

## Dashboard Highlights

Interaktif Power BI Dashboard (**Profit Leakage Analysis**) mencakup:
* **KPI Metrics Card:** *Total Sales, Total Profit, Discount Rate, & Profit Margin*.
* **Scatter Plot / Matrix:** *The Impact of Discounts on Profit*.
* **Bar Chart:** *Average Profit by Discount Segment* & *Average Profit by Sub-Category and Order Type*.
* **Regional Analysis Chart:** *Average Profit by Region: Tables & Machines Performance*.
* **Line Trend Chart:** *Profitability Trend Over Time for Tables & Machines (2014–2017)*.

<p align="center">
  <img src="https://via.placeholder.com/800x450.png?text=Profit+Leakage+Analysis+Power+BI+Dashboard" alt="Profit Leakage Analysis Dashboard" width="100%" />
</p>

---

## Business Recommendations

1. **Pembatasan Ketat Ambang Batas Diskon Maksimal (Max Discount Cap):**
   Tetapkan aturan operasional yang melarang pemberian diskon di atas **20%** pada seluruh lini produk.
2. **Restrukturisasi Kebijakan Harga Produk Berbiaya Logistik Tinggi:**
   Tinjau ulang skema harga dan margin pada sub-kategori produk berat seperti **Machines** dan **Tables**, serta hentikan promosi diskon tidak terkendali pada kategori ini.
3. **Pengetatan Strategi Penjualan Wilayah Berisiko Tinggi:**
   Evaluasi ulang efektivitas promosi dan struktur biaya di wilayah yang mencatatkan kerugian
