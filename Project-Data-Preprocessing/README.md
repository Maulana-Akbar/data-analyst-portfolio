# data-analyst-portfolio-project

<h1 align="center">Analisis Jenis Produk dan Visibilitas Ruang Pajang Terhadap Penjualan Ritel</h1>

<p align="center">
  <img src="https://img.shields.io/badge/Tools-Python-blue?style=for-the-badge&logo=python" alt="Python" />
  <img src="https://img.shields.io/badge/Libraries-Pandas%20%7C%20NumPy-orange?style=for-the-badge" alt="Libraries" />
  <img src="https://img.shields.io/badge/Status-Completed-success?style=for-the-badge" alt="Status" />
</p>

---

## Project Overview

Ruang pajang (rak) toko ritel yang terbatas menuntut manajemen untuk menata produk secara strategis guna mendongkrak omzet[cite: 3]. Tantangan utamanya adalah memastikan karakteristik dan tingkat visibilitas produk di rak benar-benar menghasilkan penjualan yang optimal, bukan sekadar membuang ruang[cite: 3]. Project ini menggunakan Python untuk menganalisis hubungan antara jenis produk, visibilitas rak, serta performa penjualan pada dataset **BigMart Sales**[cite: 3].

<blockquote align="center">
  <b>"Optimalisasi Ruang Rak vs Performa Penjualan"</b><br>
  <i>Ruang pajang yang luas tidak otomatis menaikkan angka penjualan tanpa didukung oleh permintaan pasar yang tinggi.</i>
</blockquote>

---

## Business Questions

- Bagaimana sebaran dan karakteristik data penjualan ritel serta kondisi kualitas data (missing values, duplikasi, dan anomali)?
- Bagaimana tahapan pembersihan data (*data cleaning*) dan penanganan anomali visibilitas rak bernilai nol?
- Jenis produk apa saja yang menjadi penyumbang omzet terbesar serta memiliki rata-rata penjualan per produk tertinggi?
- Bagaimana dinamika pengaruh tingkat visibilitas ruang pajang (*Item Visibility*) terhadap performa penjualan produk?

---

## Dataset

- **Sumber:** `BigMart Sales Data.csv`[cite: 3]
- **Ukuran:** 8.523 baris $\times$ 12 kolom[cite: 3]
- **Isi dari Raw Data:**
  - **Data Outlet:** `Outlet_Identifier`, `Outlet_Establishment_Year`, `Outlet_Size`, `Outlet_Location_Type`, `Outlet_Type`, `Item_Outlet_Sales`[cite: 3]
  - **Data Produk:** `Item_Identifier`, `Item_Weight`, `Item_Fat_Content`, `Item_Visibility`, `Item_Type`, `Item_MRP`[cite: 3]

---

## Data Preparation & Cleaning

Langkah pembersihan dan transformasi data yang dilakukan untuk memastikan kelancaran analisis:

- **1. Pengecekan Duplikasi:** 
  - *Hasil:* **0% data duplikat** (seluruh baris valid)[cite: 3].
- **2. Penanganan Missing Value:**
  - `Item_Weight`: Ditemukan 1.463 data hilang (17,17%). Diimputasi menggunakan rata-rata berat dari `Item_Identifier` yang sama, dan sisa 4 data diimputasi dengan rata-rata keseluruhan[cite: 3].
  - `Outlet_Size`: Ditemukan 2.410 data hilang (28,28%). Berdasarkan analisis *crosstab*, data dikelompokkan dan diimputasi menggunakan kategori `'Small'`[cite: 3].
- **3. Penyeragaman Kategori (`Item_Fat_Content`):**
  - *Hasil:* Berhasil merapikan variasi penulisan (*Low Fat*, *Regular*, *low fat*, *LF*, *reg*) menjadi 2 kategori standar (*Low Fat* dan *Regular*)[cite: 3].
- **4. Penanganan Anomali Visibilitas (`Item_Visibility`):**
  - *Hasil:* Ditemukan 526 baris (6,17%) anomali bernilai `0.0` (barang menghasilkan penjualan tetapi keterlihatan rak 0). Nilai tersebut diimputasi menggunakan rata-rata visibilitas dari masing-masing `Outlet_Identifier`[cite: 3].
- **5. Analisis Outlier:**
  - Teridentifikasi outlier pada `Item_Outlet_Sales` (186 baris) dan `Item_Visibility` (154 baris) menggunakan metode IQR. Seluruh outlier **dipertahankan** karena mewakili kondisi bisnis nyata (*high-performing products*), bukan kesalahan input[cite: 3].

---

## Tools & Technologies

- **Python:** Bahasa pemrograman utama untuk pengolahan dan analisis data[cite: 3].
- **Pandas & NumPy:** Library untuk manipulasi dataframe, pembersihan data (*data cleaning*), pengelompokan (*grouping*), dan agregasi statistik[cite: 3].

---

## Key Findings

### 1. Dominasi Omzet Penjualan
- Jenis produk seperti **Fruits and Vegetables** dan **Snack Foods** menjadi penyumbang total omzet terbesar bagi ritel karena memiliki jumlah varian produk yang paling masif di toko (di atas 1.200 produk)[cite: 3].

### 2. Performa Penjualan per Produk Tertinggi (High Value)
- Meskipun jumlah produknya lebih sedikit, jenis produk **Starchy Foods** (rata-rata 2.374,33) dan **Seafood** (rata-rata 2.326,07) mencatatkan rata-rata penjualan per produk tertinggi dibanding kategori lainnya[cite: 3].

### 3. Dinamika Visibilitas Ruang Pajang (Rak)
- Jenis produk **Breakfast** menduduki peringkat teratas dalam hal rata-rata visibilitas rak (0.09), namun penjualannya berada di papan tengah. Hal ini membuktikan bahwa ruang pajang yang luas tidak otomatis mendongkrak penjualan tanpa dukungan permintaan pasar yang tinggi[cite: 3].

---

## Conclusion

Analisis menunjukkan bahwa penataan ruang pajang tidak boleh hanya mengandalkan luasnya area rak semata, melainkan harus diselaraskan dengan performa dan tingkat perputaran produk. Kategori produk dengan varian masif dan nilai rata-rata penjualan tinggi (*Starchy Foods* dan *Seafood*) memegang peran krusial dalam efisiensi etalase ritel[cite: 3].

---

## Business Recommendations

Berdasarkan *insight* yang ditemukan, berikut adalah rekomendasi strategi bisnis yang diusulkan:

1. **Optimalisasi Ulang Ruang Etalase:**
   Segera evaluasi dan kurangi jatah rak premium untuk produk **Breakfast**. Visibilitas yang luas nyatanya tidak mengerek penjualan mereka, sehingga ruang pajang berharga ini sebaiknya dilimpahkan ke kategori dengan perputaran yang lebih stabil[cite: 3].
   
2. **Strategi Promosi Kategori Unggulan:**
   Kategori **Starchy Foods** dan **Seafood** terbukti ampuh menghasilkan margin dan performa penjualan yang kuat. Disarankan untuk menerapkan strategi *bundling* produk serta menempatkannya di etalase strategis guna memancing keranjang belanja konsumen yang lebih besar[cite: 3].

---

## Author

<p align="center">
  <a href="https://www.linkedin.com/in/radenmaulanaakbar" target="_blank">
    <img src="https://img.shields.io/badge/LinkedIn-Raden%20Maulana%20Akbar-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn Raden Maulana Akbar" />
  </a>
</p>
