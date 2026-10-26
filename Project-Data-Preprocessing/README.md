<h1 align="center">Market Basket Analysis: Menggali Pola Pembelian Konsumen untuk Meningkatkan Penjualan Ritel</h1>

<p align="center">
  <img src="https://img.shields.io/badge/Tools-Python%20%7C%20Power%20BI-blue?style=for-the-badge&logo=python" alt="Tools" />
  <img src="https://img.shields.io/badge/Libraries-Pandas%20%7C%20Mlxtend-orange?style=for-the-badge" alt="Libraries" />
  <img src="https://img.shields.io/badge/Status-Completed-success?style=for-the-badge" alt="Status" />
</p>

---

## Project Overview

Area kasir terbukti menjadi titik '*Impulse Buying*' paling krusial di industri ritel. Berkaca dari fenomena jurang *small basket size*, analisis ini diinisiasi untuk membedah apakah pola asosiasi produk pada dataset berpotensi mampu mendorong peningkatan ukuran keranjang yang sehat (strategi *cross-selling*), atau justru membiarkan potensi penjualan hilang begitu saja akibat ketiadaan strategi penataan tata letak yang tepat.

<blockquote align="center">
  <b>"Strategi Impulse Buying vs Stagnansi Ukuran Keranjang"</b><br>
  <i>Penempatan produk komplementer berskala kecil di area antrean kasir seringkali menjadi cara paling minim risiko untuk mengonversi pelanggan yang tadinya hanya membeli 1-2 barang menjadi 3 barang.</i>
</blockquote>

---

## Business Questions

- Bagaimana sebaran profil ukuran keranjang belanja (*basket size*) pelanggan ritel saat ini?
- Apa saja kombinasi produk yang memiliki korelasi pembelian terkuat dan berpotensi untuk didorong penjualannya?
- Bagaimana tren fluktuasi aktivitas transaksi harian untuk menyarankan waktu eksekusi strategi promosi yang sekiranya efektif?
- Seberapa besar proyeksi peningkatan nilai keranjang belanja rata-rata apabila rekomendasi strategi asosiasi produk diimplementasikan?

---

## Dataset

- **Sumber:** `Groceries_dataset.csv` (Kaggle Bootcamp Project)
- **Ukuran:** 38.765 baris data (sebelum *cleaning*) yang merekam transaksi 3.898 pelanggan unik selama periode 2014-2015.
- **Isi dari Raw Data:** Memuat 3 atribut utama yaitu `Member_number`, `Date`, dan `itemDescription` (mencakup 167 varian produk ritel).

---

## Data Preparation & Cleaning

Langkah pembersihan dan transformasi data yang dilakukan untuk mengupayakan kelancaran pemodelan *Association Rules*:

- **1. Pengecekan dan Perbaikan Tipe Data:** 
  - *Hasil:* Mengubah kolom `Member_number` dari tipe integer menjadi *string*, serta mengonversi kolom `Date` dari *string* menjadi tipe `datetime`.
- **2. Pembuatan Identitas Keranjang (Transaction ID):** 
  - *Hasil:* Dilakukan penggabungan antara `Member_number` dan `Date` untuk membentuk kolom `Transaction_ID` baru sebagai pengelompok pola keranjang harian pelanggan (menghasilkan 14.963 keranjang transaksi unik).
- **3. Pembersihan Inkonsistensi String:** 
  - *Hasil:* Menghapus keberadaan spasi berlebih (*whitespace*) pada teks di kolom `itemDescription`, khususnya pada entri produk seperti 'cream cheese ' dan 'roll products '.
- **4. Penanganan Duplikasi:** 
  - *Hasil:* Menghapus 759 baris duplikat (1,96%) yang timbul akibat pencatatan barang yang sama pada `Transaction_ID` yang sama. Total baris bersih menjadi 38.006.
- **5. Feature Engineering & Analisis Outlier:** 
  - *Hasil:* Membuat fitur tambahan meliputi `basket_size`, `Day_Name`, `Month`, dan `Basket_Category` (Small, Medium, Large). Sebanyak 746 transaksi *outlier* (> 4,5 barang) dipertahankan karena hal tersebut diasumsikan valid menandakan pelanggan yang berbelanja dalam jumlah masif.
- **6. Pembuatan Basket Matrix:** 
  - *Hasil:* Mengaplikasikan *One-Hot Encoding* untuk merestrukturisasi dataset transaksi menjadi matriks biner (0 dan 1) agar siap diolah oleh algoritma Apriori.

---

## Tools & Technologies

- **Python (Pandas & Mlxtend):** Bahasa pemrograman yang dimanfaatkan untuk *data cleaning*, rekayasa fitur (*feature engineering*), dan eksekusi algoritma Apriori untuk menemukan probabilitas *Association Rules*.
- **Power BI:** Platform visualisasi yang digunakan untuk merancang *dashboard* interaktif analisis pola belanja pelanggan.

---

## Key Findings

### 1. Dominasi Transaksi Segmen Keranjang Kecil
- Rata-rata ukuran keranjang belanja saat ini tertahan di angka 2,98 barang per nota. Hal ini diindikasikan oleh tingginya proporsi pelanggan harian yang hanya berbelanja 1 hingga 2 item (Segmen *Small* mendominasi sebesar 53,23%).

### 2. Kekuatan Asosiasi pada Produk Susu & Sosis
- Analisis algoritma Apriori menemukan kombinasi produk `sausage` dengan `yogurt, whole milk` mencatatkan nilai Lift tertinggi sebesar 2,18. Tingginya angka ini mengindikasikan probabilitas yang kuat dari produk-produk tersebut untuk dibeli secara bersamaan oleh pelanggan.

### 3. Puncak Aktivitas Transaksi pada Hari Kamis
- Tren aktivitas belanja harian memperlihatkan pola yang spesifik, di mana hari Kamis secara konsisten mencatatkan volume transaksi puncak (2.188 transaksi), sedangkan angka terendah jatuh pada hari Senin.

---

## Conclusion

Rata-rata volume belanja ritel saat ini terlihat belum maksimal akibat tertahan oleh dominasi keranjang berukuran kecil (1-2 item). Kendati demikian, ekstraksi pola dari 110 aturan asosiasi menunjukkan probabilitas keterikatan antarproduk yang menjanjikan (dengan nilai *Lift* mencapai 2,18). Pola laten ini dapat dijadikan referensi data yang solid bagi manajemen untuk mempertimbangkan pendorongan pembelian impulsif dan merangsang *basket size* melalui taktik letak barang dan paket penawaran.

---

## Business Recommendations

Berdasarkan *insight* yang ditemukan, berikut adalah beberapa rekomendasi strategis yang dapat dipertimbangkan:

1. **Optimalisasi Tata Letak Area Kasir & Ujung Lorong (End-Cap):**
   Manajemen disarankan untuk menyediakan *front-end chiller* yang berisi aneka keju di jalur antrean kasir guna memicu timbulnya pembelian impulsif. Selain itu, dapat dipertimbangkan pula pengaturan pajangan *end-cap* yang mendekatkan kompartemen produk segar dengan olahan susu agar konsumen lebih mudah melakukan *cross-buying*.
   
2. **Fokus Program Bundling pada Hari Puncak Transaksi:**
   Tim pemasaran dapat mempertimbangkan pengalokasian anggaran diskon dan paket penawaran (*bundling*) yang difokuskan pada 3 kombinasi produk teratas (contoh: *sausage, yogurt, dan whole milk*). Pelaksanaan taktik ini disarankan untuk dikonsentrasikan pada hari Kamis untuk mencoba memaksimalkan rasio konversi saat periode *traffic* pengunjung sedang tinggi.

3. **Pelaksanaan A/B Testing untuk Validasi Proyeksi AOV:**
   Sebagai langkah eksekusi dengan mitigasi risiko yang terukur, tim operasional disarankan untuk menjalankan *A/B Testing* selama satu bulan penuh khusus pada area pajangan *Whole milk* dan *Sausage*. Simulasi awal memproyeksikan bahwa potensi keberhasilan mengonversi 10% pelanggan dari intervensi ini dapat mendongkrak rata-rata keranjang (AOV) menjadi 3,28 barang per nota.

---

## Author

<p align="center">
  <a href="https://www.linkedin.com/in/radenmaulanaakbar" target="_blank">
    <img src="https://img.shields.io/badge/LinkedIn-Raden%20Maulana%20Akbar-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn Raden Maulana Akbar" />
  </a>
</p>
