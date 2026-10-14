<h1 align="center">Analisis Efisiensi Periklanan dan Retensi Pelanggan</h1>

<p align="center">
  <img src="https://img.shields.io/badge/Tools-Power%20BI%20%7C%20PostgreSQL-yellow?style=for-the-badge&logo=powerbi" alt="Tools" />
  <img src="https://img.shields.io/badge/Language-SQL%20%7C%20DAX-blue?style=for-the-badge" alt="Language" />
  <img src="https://img.shields.io/badge/Data%20Prep-DBeaver-orange?style=for-the-badge" alt="Data Prep" />
  <img src="https://img.shields.io/badge/Status-Completed-success?style=for-the-badge" alt="Status" />
</p>

---

## Project Overview

Project ini menganalisis efisiensi biaya periklanan (*Paid Ads*) dan tingkat retensi pelanggan menggunakan dataset pemasaran digital. Tujuan utama dari analisis ini adalah untuk mengidentifikasi pemicu inefisiensi anggaran iklan, melacak titik kebocoran trafik konversi (*funnel drop-off*), mengevaluasi pengaruh retensi terhadap pendapatan, serta memberikan rekomendasi strategis berbasis data guna membantu mencegah pendarahan finansial akibat strategi akuisisi yang kurang optimal[cite: 16].

<blockquote align="center">
  <b>"The Customer Acquisition Trap"</b><br>
  <i>Kejatuhan struktur pemasaran digital membuktikan bahwa ketergantungan kronis pada iklan berbayar tanpa optimalisasi konversi halaman dapat menciptakan ilusi tingginya trafik sekaligus menghancurkan margin keuntungan secara fatal[cite: 16].</i>
</blockquote>

---

## Business Questions

- Bagaimana korelasi antara metrik pemasaran, konversi transaksi, dan durasi retensi pelanggan[cite: 25]?
- Bagaimana performa perbandingan antara total pendapatan (*revenue*) dan biaya iklan (*ad cost*) pada masing-masing saluran pemasaran[cite: 27]?
- Di tahap mana titik kebocoran trafik konversi (*conversion funnel drop-off*) paling kritis terjadi[cite: 28]?
- Sejauh mana pengaruh durasi retensi pelanggan (*retention month*) terhadap perolehan pendapatan bisnis[cite: 29]?

---

## Dataset

- **Sumber:** `practical_data_marketing_growth_analytics.csv` (Marketing Growth Analytics Dataset)[cite: 17]
- **Jumlah Baris:** 800 baris[cite: 19]
- **Jumlah Kolom:** 16 kolom[cite: 19]

---

## Data Preparation

Proses pembersihan dan manipulasi data dilakukan menggunakan SQL di DBeaver untuk memastikan kelancaran analisis. Berikut adalah tahapan yang dilakukan beserta hasilnya:

- **Penilaian Kualitas Data:** Validasi untuk memastikan tidak ada nilai yang hilang (*missing values*) serta tidak ada data duplikat pada baris transaksi[cite: 19].
  - **Hasil:** Dataset terbukti bersih dengan hasil **0 *missing values*** dan **0 data duplikat**[cite: 19].
- **Konversi Tipe Data:** Mengubah tipe data pada kolom `first_visit_date` menjadi format tanggal (`DATE`)[cite: 22].
  - **Hasil:** Kolom tanggal berhasil disesuaikan sehingga fungsi analisis berbasis waktu dapat berjalan dengan akurat[cite: 22].
- **Identifikasi Anomali / Outlier:** Evaluasi sebaran distribusi data numerik dan kategorikal[cite: 23, 24].
  - **Hasil:** Ditemukan anomali wajar pada `revenue` (150 transaksi bernilai tinggi) dan `ad_cost` (89 transaksi membutuhkan biaya besar). Pada kategori, dominasi kuat tercatat pada perangkat *Mobile* (63,00%) dan saluran *Paid Ads* (31,38%)[cite: 24].

---

## Tools & Technologies

- **PostgreSQL & DBeaver:** Digunakan untuk eksekusi kueri relasional, pembersihan data, dan transformasi tipe data.
- **Power BI Desktop:** Digunakan untuk pemodelan data, pembuatan ukuran, dan pembangunan *Dashboard* interaktif[cite: 30].
- **DAX (Data Analysis Expressions):** Digunakan untuk kalkulasi agregasi dan metrik performa bisnis.

---

## Key Findings

### 1. Analisis Korelasi Metrik Pemasaran
- Terjadinya konversi transaksi (*purchase*) memiliki **korelasi paling kuat** dengan `revenue` (0.88) dan durasi retensi pelanggan (`retention_month`, 0.81)[cite: 25].
- Sebaliknya, pengeluaran biaya iklan (`ad_cost`) hanya menunjukkan **korelasi yang sangat lemah (0.02)** terhadap konversi maupun pendapatan[cite: 25].

### 2. Performa Utama Bisnis & Inefisiensi Iklan Berbayar
- Total pendapatan tercatat sebesar **Rp41.003.905** dengan total biaya iklan **Rp10.948.907**[cite: 26].
- Rasio ROAS khusus iklan berbayar berada di angka tipis **1.20x** (mendekati titik impas) dengan rata-rata retensi hanya **0.43 bulan**, mengindikasikan dominasi *one-time buyer*[cite: 26].
- Saluran *Paid Ads* menyerap seluruh biaya iklan namun hanya menghasilkan pendapatan Rp13.177.258,00, sementara saluran organik secara kumulatif mampu menyumbang **Rp27.826.647,00** tanpa biaya iklan[cite: 27].

### 3. Kebocoran Trafik pada Tahap Pertimbangan (*Funnel Drop-off*)
- Rasio klik (*CTR*) tercatat sebesar 4.40% dari total 442.700 impresi, namun mengalami penurunan tajam di mana **hanya 1.69% pengunjung yang melanjutkan ke tahap *Add to Cart***[cite: 28].
- Sebaliknya, konversi dari keranjang ke pembelian (*Cart-to-Purchase*) tergolong cukup tinggi di angka 45.59%[cite: 28].

### 4. Pengaruh Retensi terhadap Pendapatan
- Pendapatan tercatat nihil pada periode awal (`retention_month = 0`) dan **mencapai puncaknya pada bulan pertama (Rp19.186.354)** sebelum berangsur melandai pada bulan-bulan berikutnya[cite: 29].
- Pola ini menunjukkan bahwa perolehan pendapatan mayoritas terakumulasi pada fase awal retensi pengguna[cite: 29].

---

## Dashboard Highlights

*Dashboard* interaktif Power BI yang dibuat mencakup visualisasi berikut:
- **Kartu Ringkasan (KPI):** Metrik untuk Total Revenue, Total Ad Cost, ROAS, dan Avg Retention[cite: 30].
- **Grafik Batang & Garis (*Ad Cost vs Revenue by Channel*):** Perbandingan penyerapan biaya iklan dan perolehan pendapatan di setiap saluran pemasaran[cite: 30].
- **Grafik Corong (*Conversion Funnel & Traffic Drop-off*):** Visualisasi penurunan trafik dari impresi hingga transaksi pembelian[cite: 30].
- **Grafik Tren Garis (*Revenue Trend by Retention Month*):** Analisis pergerakan pendapatan berdasarkan durasi retensi bulanan[cite: 30].
- **Filter Interaktif:** Filter berdasarkan saluran pemasaran (*Channel*) dan rentang tanggal kunjungan (*First Visit Date*)[cite: 30].

---

## Conclusion

Analisis membuktikan bahwa ketergantungan pada iklan berbayar (*Paid Ads*) menghasilkan efisiensi yang rendah dengan ROAS yang tertahan di angka 1.20x[cite: 26, 27]. Titik kebocoran utama terletak pada penurunan drastis pengunjung menuju *Add to Cart* (1.69%), serta dominasi *one-time buyer* dengan retensi singkat (0.43 bulan)[cite: 26, 28]. Perusahaan memiliki peluang besar untuk mengoptimalkan profitabilitas dengan mengalihkan anggaran ke kanal organik, memperbaiki antarmuka halaman produk, serta memperkuat program re-aktivasi retensi jangka panjang[cite: 27, 28, 29].

---

## Business Recommendations

Berdasarkan *insight* yang ditemukan, terdapat beberapa langkah penyesuaian strategi yang direkomendasikan untuk mendukung pertumbuhan bisnis:

1. **Efisiensi Anggaran Pemasaran & Optimalisasi Kanal Organik:**
   Pengalokasian biaya iklan berbayar yang berkinerja rendah disarankan untuk dikurangi, agar anggaran dapat dialihkan guna mengoptimalkan konten dan pencarian organik yang terbukti jauh lebih efisien dalam menyumbang pendapatan[cite: 32].

2. **Perbaikan Antarmuka (UX) dan Penawaran Halaman Produk:**
   Evaluasi serta perbaikan pada tampilan *landing page* dan informasi produk dianjurkan untuk segera dilakukan guna menekan tingkat kebocoran trafik (*drop-off*) yang ekstrem sebelum pengunjung masuk ke keranjang belanja[cite: 32].

3. **Penerapan Program Re-aktivasi & Retensi Pelanggan:**
   Strategi pemasaran dianjurkan untuk lebih difokuskan pada program re-aktivasi—seperti insentif/pemberian *voucher* untuk pembelian kedua—guna menekan dominasi *one-time buyer* dan menjaga stabilitas retensi pelanggan jangka panjang[cite: 32].

---

## Author

<p align="center">
  <a href="https://www.linkedin.com/in/radenmaulanaakbar" target="_blank">
    <img src="https://img.shields.io/badge/LinkedIn-Raden%20Maulana%20Akbar-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn Raden Maulana Akbar" />
  </a>
</p>
