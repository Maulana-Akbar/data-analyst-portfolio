# data-analyst-portfolio-project

<h1 align="center">Analisis Pengaruh Harga Retail dan Tipe Outlet Terhadap Pendapatan Penjualan Ritel</h1>

<p align="center">
  <img src="https://img.shields.io/badge/Tools-Python-blue?style=for-the-badge&logo=python" alt="Python" />
  <img src="https://img.shields.io/badge/Libraries-Pandas%20%7C%20Seaborn-orange?style=for-the-badge" alt="Libraries" />
  <img src="https://img.shields.io/badge/Status-Completed-success?style=for-the-badge" alt="Status" />
</p>

---

## Project Overview

Dalam industri ritel modern, ketimpangan performa penjualan antar gerai sering kali menjadi kendala utama dalam optimalisasi pendapatan. Manajemen kerap menghadapi kesulitan dalam menentukan apakah fokus strategis harus diarahkan pada penyesuaian harga produk atau ekspansi format tipe gerai[cite: 4]. Project ini menggunakan Python untuk mengidentifikasi sejauh mana pengaruh harga eceran dan klasifikasi tipe outlet terhadap fluktuasi pendapatan penjualan, guna memberikan rekomendasi alokasi strategi bisnis yang tepat sasaran[cite: 4].

<blockquote align="center">
  <b>"Harga Retail vs Pengaruh Tipe Outlet"</b><br>
  <i>Pemilihan tipe outlet terbukti jauh lebih krusial dalam mendongkrak volume omzet penjualan dibandingkan sekadar mengandalkan tingkat harga produk.</i>
</blockquote>

---

## Business Questions

- Bagaimana karakteristik data dan sebaran variabel numerik maupun kategorikal pada dataset penjualan ritel?
- Bagaimana tahapan pembersihan data (*data cleaning*), penanganan nilai hilang (*missing values*), serta anomali visibilitas rak?
- Sejauh mana korelasi antara harga eceran produk (`Item_MRP`) terhadap total pendapatan penjualan (`Item_Outlet_Sales`)?
- Bagaimana pengaruh klasifikasi tipe outlet (`Outlet_Type`) dan kategori produk (`Item_Type`) terhadap variasi pendapatan penjualan?

---

## Dataset

- **Sumber:** `BigMart Sales Data.csv`[cite: 4]
- **Ukuran:** 8.523 baris $\times$ 12 kolom[cite: 4]
- **Isi dari Raw Data:**
  - **Data Outlet:** `Outlet_Identifier`, `Outlet_Establishment_Year`, `Outlet_Size`, `Outlet_Location_Type`, `Outlet_Type`, `Item_Outlet_Sales`[cite: 4]
  - **Data Produk:** `Item_Identifier`, `Item_Weight`, `Item_Fat_Content`, `Item_Visibility`, `Item_Type`, `Item_MRP`[cite: 4]

---

## Data Preparation & Cleaning

Langkah pembersihan dan manipulasi data yang dilakukan untuk memastikan kevalidan analisis:

- **1. Pengecekan Kualitas Data & Duplikasi:** Validasi awal menunjukkan tidak ada baris data yang duplikat (0,00%)[cite: 4].
- **2. Penanganan Missing Value:**
  - `Item_Weight` (17,17%): Diimputasi berdasarkan rata-rata kelompok `Item_Identifier` yang sama[cite: 4].
  - `Item_Visibility` (6,17%): Nilai anomali `0.0` sebanyak 526 baris diatasi dengan imputasi menggunakan nilai median berdasarkan produknya[cite: 4].
  - `Outlet_Size` (28,28%): Diimputasi menggunakan analisis *crosstab* berdasarkan relasi `Outlet_Type` dan `Outlet_Location_Type` (sebagian besar diisi kategori `'Small'`)[cite: 4].
- **3. Penyeragaman Kategori (`Item_Fat_Content`):** Merapikan variasi penulisan (*low fat*, *LF*, *reg*) menjadi dua kategori standar (*Low Fat* dan *Regular*)[cite: 4].
- **4. Analisis Outlier:** Teridentifikasi *outlier* pada `Item_Outlet_Sales` (186 baris) dan `Item_Visibility` (154 baris) menggunakan metode IQR, di mana seluruhnya **dipertahankan** karena merepresentasikan kondisi transaksi bisnis nyata[cite: 4].

---

## Tools & Technologies

- **Python:** Bahasa pemrograman utama untuk analisis data eksploratif (EDA)[cite: 4].
- **Pandas & NumPy:** Library untuk manipulasi dataframe, pembersihan data, dan agregasi statistik[cite: 4].
- **Matplotlib & Seaborn:** Library untuk visualisasi data, pembuatan matriks korelasi (*heatmap*), dan *scatter plot* multivariat[cite: 4].

---

## Key Findings

### 1. Korelasi Positif antara Harga Produk dan Potensi Pendapatan
- Analisis korelasi menunjukkan adanya hubungan linier positif antara harga eceran produk (`Item_MRP`) dengan total pendapatan penjualan dengan nilai koefisien **0.57**[cite: 4]. Semakin tinggi harga suatu produk, semakin besar pula potensi batas maksimal omzet yang dapat dihasilkan[cite: 4].

### 2. Tipe Outlet Merupakan Faktor Penentu Utama Variasi Omzet
- Pemecahan visualisasi melalui *facet grid* berdasarkan `Outlet_Type` membuktikan bahwa format gerai adalah pembeda performa yang paling ekstrem[cite: 4]. **Supermarket Type 3** secara konsisten mampu mendongkrak penjualan hingga belasan ribu, sementara **Grocery Store** hanya mampu mencetak angka di bawah 2.000 terlepas dari berapapun harga produknya[cite: 4].

### 3. Kategori Produk Memiliki Performa Penjualan yang Relatif Stabil
- Pengujian rata-rata omzet berdasarkan kategori produk (`Item_Type`) memperlihatkan selisih nilai yang rapat di kisaran angka **1.900 hingga 2.400**[cite: 4]. Hal ini mengindikasikan bahwa jenis barang bukanlah faktor pemicu utama yang menciptakan perbedaan omzet secara drastis di antara toko[cite: 4].

---

## Dashboard & Visualizations Highlights

Visualisasi utama yang dihasilkan dalam proyek ini mencakup:
- **Matriks Korelasi (Heatmap):** Analisis hubungan antarvariabel numerik untuk mendeteksi variabel dengan pengaruh terkuat[cite: 4].
- **Scatter Plot Multivariat:** Pemetaan hubungan antara harga retail (`Item_MRP`) dan penjualan (`Item_Outlet_Sales`) dikelompokkan berdasarkan tipe outlet[cite: 4].
- **Facet Grid Plot:** Perbandingan sebaran penjualan secara terpisah untuk masing-masing tipe outlet[cite: 4].
- **Bar Chart Kategori Produk:** Visualisasi perbandingan rata-rata omzet di berbagai kategori produk[cite: 4].

---

## Conclusion

Berdasarkan hasil analisis data, dapat disimpulkan bahwa meskipun harga eceran produk (`Item_MRP`) memiliki korelasi positif terhadap batas maksimal potensi penjualan, klasifikasi tipe outlet (`Outlet_Type`) terbukti menjadi faktor pembeda utama yang paling menentukan besar kecilnya pendapatan riil gerai[cite: 4]. Di sisi lain, performa penjualan antar kategori produk cenderung merata dan stabil, sehingga fokus strategis manajemen tidak perlu bertumpu pada perubahan jenis produk, melainkan pada pengembangan format gerai[cite: 4].

---

## Business Recommendations

Berdasarkan *insight* yang ditemukan, berikut adalah rekomendasi strategi bisnis yang diusulkan:

1. **Ekspansi dan Modernisasi Tipe Outlet:**
   Prioritas pengembangan bisnis dapat diarahkan pada ekspansi format Supermarket (Type 1 & Type 3), mengingat data membuktikan tipe gerai ini memiliki *leverage* paling efektif dalam mendongkrak volume omzet secara signifikan[cite: 4].
   
2. **Promosi Berbasis Kategori Produk Secara Merata:**
   Manajemen dapat mempertimbangkan skema promosi terpadu (*bundling*) pada kategori produk unggulan, sebagai opsi strategis untuk meningkatkan nilai rata-rata keranjang belanja per transaksi di seluruh lini produk yang stabil[cite: 4].

---

## Author

<p align="center">
  <a href="https://www.linkedin.com/in/radenmaulanaakbar" target="_blank">
    <img src="https://img.shields.io/badge/LinkedIn-Raden%20Maulana%20Akbar-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn Raden Maulana Akbar" />
  </a>
</p>
