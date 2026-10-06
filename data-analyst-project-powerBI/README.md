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

Project ini menganalisis hubungan antara angka penjualan (`Sales`), tingkat diskon (`Discount`), dan profitabilitas (`Profit`) menggunakan dataset **Sample - Superstore**. Tujuan utama dari analisis ini adalah untuk mengidentifikasi pemicu utama kebocoran profit, mengevaluasi batas aman pemberian diskon, dan memberikan rekomendasi bisnis berbasis data guna membantu mencegah penurunan finansial akibat strategi pemotongan harga yang kurang optimal.

<blockquote align="center">
  <b>"Ilusi Volume Penjualan vs Margin Keuntungan"</b><br>
  <i>Kejatuhan ritel raksasa membuktikan bahwa ketergantungan pada diskon yang terlalu tinggi dapat menciptakan ilusi tingginya pendapatan sekaligus menggerus margin keuntungan.</i>
</blockquote>

---

## Business Questions

* Bagaimana dampak pemberian diskon terhadap profitabilitas perusahaan secara keseluruhan?
* Berapa ambang batas maksimal diskon (*tipping point*) sebelum transaksi berbalik menjadi rugi?
* `Sub-Category` produk dan wilayah (`Region`) mana yang menjadi penyumbang kerugian terbesar ketika diberikan diskon?
* Bagaimana tren keuntungan dan kerugian pada produk berbiaya logistik tinggi secara historis pada tahun 2014 hingga 2017?

---

## Dataset

* **Sumber:** [`Sample - Superstore.csv`](https://www.kaggle.com/datasets/vivek468/superstore-dataset-final/data) (Retail Dataset)
* **Jumlah Baris:** 9.994 baris
* **Jumlah Kolom:** 21 kolom

---
 
## Data Preparation

Proses pembersihan dan manipulasi data dilakukan untuk memastikan kelancaran analisis. Berikut adalah tahapan yang dilakukan beserta hasilnya:

* **Penilaian Kualitas Data:** Validasi untuk memastikan tidak ada nilai yang hilang atau kosong serta tidak ada data duplikat pada baris transaksi.
  * **Hasil:** Dataset terbukti bersih dengan hasil **0 *missing values*** dan **0 data duplikat**.
* **Konversi Tipe Data:** Mengubah tipe data pada kolom `Order Date` dan `Ship Date` menjadi format tanggal, kolom `Sales`, `Profit`, dan `Discount` menjadi format desimal (*float*), serta `Quantity` menjadi bilangan bulat (*integer*).
  * **Hasil:** Seluruh tipe data berhasil disesuaikan (mengikuti standar *Locale* United States) sehingga fungsi kalkulasi numerik dan analisis berbasis waktu (*time-series*) dapat berjalan dengan akurat.
* **Identifikasi Anomali Kategorikal:** Evaluasi sebaran distribusi (*outlier* kategorikal) pada beberapa metrik dimensi seperti `Ship Mode`, `Segment`, dan `Region`.
  * **Hasil:** Ditemukan dominasi transaksi pada opsi pengiriman *Standard Class* (59,72%), pelanggan segmen *Consumer* (51,94%), serta konsentrasi penjualan tertinggi di region *West* (terutama negara bagian California sebesar 20,02%).
* **Rekayasa Fitur (*Feature Engineering*):**
  * Membuat kolom `Discount Segment` untuk mengelompokkan rentang nilai diskon. 
    * **Hasil:** Terbentuk 6 kelompok rentang diskon (Mulai dari *0% (No Discount)* hingga *41%+*) yang mempermudah evaluasi ambang batas aman pemotongan harga.
  * Membuat kolom `Order Type` untuk membedakan transaksi yang menggunakan diskon dengan transaksi harga normal. 
    * **Hasil:** Transaksi berhasil dipisahkan secara tegas menjadi dua kategori (*Discounted* dan *No Discount*) untuk memperjelas perbandingan profitabilitas antara keduanya.

---

## Tools & Technologies

* **Power BI Desktop:** Digunakan untuk pemodelan data, pembuatan ukuran (DAX Measures), dan pembuatan *Dashboard* interaktif.
* **Power Query:** Digunakan untuk tahap pembersihan data dan transformasi bahasa atau *locale*.
* **DAX (Data Analysis Expressions):** Digunakan untuk kalkulasi agregasi dan rekayasa fitur data.

---

## Key Findings

### 1. Tingginya Penjualan Belum Tentu Berbanding Lurus dengan Margin
* Meskipun perusahaan berhasil mencatatkan nilai `Sales` yang masif sebesar **$2,297,200.86**, rata-rata pemberian diskon yang menyentuh **15.62%** memberikan tekanan yang menyebabkan margin keuntungan tertahan di angka tipis **12.47%** (dengan total `Profit` **$286,397**).

### 2. Ambang Batas Aman Diskon
* Transaksi pada rentang `Discount` **0% hingga 20%** konsisten menghasilkan profit yang positif, dengan rata-rata `Profit` tertinggi sebesar **$96.06** pada rentang diskon 1%–10%.
* Ketika diskon yang diberikan melebihi **20%**, rata-rata `Profit` berbalik menjadi negatif, mencatatkan kerugian terdalam pada segmen diskon 31%–40% sebesar **-$109.22**.

### 3. Kerugian Terpusat pada Produk Berbiaya Logistik Tinggi
* Seluruh produk yang terjual tanpa diskon mencatatkan profitabilitas positif.
* Namun, penerapan diskon pada produk berat menyeret performa keuntungan ke area negatif. Kerugian rata-rata terparah dialami oleh produk dalam `Sub-Category` **Machines (-$276.20)** dan **Tables (-$125.51)**.

### 4. Kebocoran Profit Berdasarkan Wilayah 
* Transaksi tanpa diskon di seluruh wilayah (`Region`) bernilai positif. 
* Ketika produk *Tables & Machines* dijual dengan diskon, wilayah **South** dan **East** mencatatkan kerugian rata-rata terparah, masing-masing sebesar **-$422.46** dan **-$263.32**.

### 5. Tren Pendarahan Finansial Secara Historis
* Evaluasi tren tahun 2014 hingga 2017 menunjukkan bahwa transaksi *Tables & Machines* tanpa diskon selalu stabil di area positif. Sebaliknya, transaksi dengan diskon pada produk yang sama konsisten berada di area negatif, menandakan adanya pendarahan finansial yang terus berulang setiap tahunnya.

---

## Dashboard Highlights

*Dashboard* interaktif Power BI yang dibuat mencakup visualisasi berikut:
* **Kartu Ringkasan (KPI):** Metrik untuk total `Sales`, total `Profit`, rata-rata `Discount`, dan Profit Margin.
* **Grafik Penyebaran (Scatter Plot):** Analisis dampak pemberian diskon terhadap perolehan profit.
* **Grafik Batang (Bar Chart):** Rata-rata profit berdasarkan kelompok diskon (`Discount Segment`) dan rata-rata profit berdasarkan `Sub-Category`.
* **Analisis Regional:** Kinerja profitabilitas untuk produk *Tables & Machines* di setiap `Region`.
* **Grafik Tren Garis (Line Chart):** Tren profitabilitas historis (2014–2017).

---

## Conclusion

Perusahaan telah berhasil mencatatkan volume penjualan yang kuat di pasar. Meskipun demikian, penggunaan diskon yang kurang terukur memberikan dampak pengurangan yang cukup signifikan terhadap potensi keuntungan perusahaan. Dengan mempertimbangkan optimalisasi kebijakan batas diskon, mengevaluasi promosi pada kategori produk tertentu, serta menyesuaikan strategi promosi di masing-masing regional, perusahaan memiliki peluang yang sangat besar untuk meningkatkan margin profit tanpa perlu mengorbankan pertumbuhan omzet.

---

## Business Recommendations

Berdasarkan *insight* yang ditemukan, terdapat beberapa langkah penyesuaian strategi yang direkomendasikan untuk mendukung pertumbuhan profit perusahaan:

1. **Penyesuaian Ambang Batas Diskon Maksimal:**
   Disarankan bagi perusahaan untuk mempertimbangkan kebijakan pembatasan diskon maksimal di angka **20%** pada sebagian besar lini produk. Hal ini direkomendasikan karena data historis menunjukkan pemberian diskon di atas angka tersebut rentan memicu kerugian finansial.
   
2. **Evaluasi Kebijakan Harga untuk Produk Berbiaya Logistik Tinggi:**
   Sangat direkomendasikan untuk meninjau kembali skema harga dan struktur margin pada produk dengan biaya operasional tinggi, seperti `Machines` dan `Tables`. Sebaiknya, pemberian promosi diskon pada kategori ini dievaluasi atau dikurangi agar tidak membebani margin keuntungan.
   
3. **Peninjauan Kembali Strategi Penjualan di Wilayah Tertentu:**
   Terdapat indikasi kerugian akibat diskon yang cukup signifikan di wilayah **South** dan **East**. Oleh karena itu, disarankan untuk melakukan evaluasi terhadap struktur biaya promosi di wilayah-wilayah tersebut agar profitabilitas dapat ditingkatkan.
   
4. **Peralihan Strategi Promosi ke Metode Bundling:**
   Sebagai alternatif dari pemotongan harga langsung, direkomendasikan untuk mulai menerapkan strategi *bundling* produk. Menggabungkan produk yang banyak diminati dengan produk bermargin tinggi diharapkan dapat mempertahankan antusiasme pembeli sekaligus menjaga tingkat profitabilitas secara menyeluruh.

---

<p align="center">
  <img src="https://img.shields.io/badge/Tools-Power%20BI-yellow?style=for-the-badge&logo=powerbi" alt="Power BI" />
  <img src="https://img.shields.io/badge/Language-DAX-blue?style=for-the-badge" alt="DAX" />
  <img src="https://img.shields.io/badge/Data%20Prep-Power%20Query-orange?style=for-the-badge" alt="Power Query" />
  <img src="https://img.shields.io/badge/Status-Completed-success?style=for-the-badge" alt="Status" />
</p>

<p align="center">
  <a href="https://www.linkedin.com/in/radenmaulanaakbar" target="_blank">
    <img src="https://img.shields.io/badge/LinkedIn-Raden%20Maulana%20Akbar-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn Raden Maulana Akbar" />
  </a>
</p>
