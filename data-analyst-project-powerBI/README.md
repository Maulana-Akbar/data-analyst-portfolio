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

Proses pembersihan dan manipulasi data dilakukan untuk memastikan kelancaran analisis, antara lain:

* **Penilaian Kualitas Data:** Validasi untuk memastikan tidak ada nilai yang hilang atau kosong serta tidak ada data duplikat pada baris transaksi.
* **Konversi Tipe Data:** Mengubah tipe data pada kolom `Order Date` dan `Ship Date` menjadi format tanggal, kolom `Sales`, `Profit`, dan `Discount` menjadi format desimal (*float*), serta `Quantity` menjadi bilangan bulat (*integer*).
* **Identifikasi Anomali Kategorikal:** Evaluasi sebaran distribusi pada kolom `Ship Mode`, `Segment`, dan `Region`.
* **Rekayasa Fitur (*Feature Engineering*):**
  * Membuat kolom `Discount Segment` untuk mengelompokkan rentang nilai diskon.
  * Membuat kolom `Order Type` untuk membedakan transaksi yang menggunakan diskon dengan transaksi tanpa diskon.

---

## Tools & Technologies

* **Power BI Desktop:** Digunakan untuk pemodelan data, pembuatan ukuran (DAX Measures), dan pembuatan *Dashboard* interaktif.
* **Power Query:**# data-analyst-portfolio-project

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

Proses pembersihan dan manipulasi data dilakukan untuk memastikan kelancaran analisis, antara lain:

* **Penilaian Kualitas Data:** Validasi untuk memastikan tidak ada nilai yang hilang atau kosong serta tidak ada data duplikat pada baris transaksi.
* **Konversi Tipe Data:** Mengubah tipe data pada kolom `Order Date` dan `Ship Date` menjadi format tanggal, kolom `Sales`, `Profit`, dan `Discount` menjadi format desimal (*float*), serta `Quantity` menjadi bilangan bulat (*integer*).
* **Identifikasi Anomali Kategorikal:** Evaluasi sebaran distribusi pada kolom `Ship Mode`, `Segment`, dan `Region`.
* **Rekayasa Fitur (*Feature Engineering*):**
  * Membuat kolom `Discount Segment` untuk mengelompokkan rentang nilai diskon.
  * Membuat kolom `Order Type` untuk membedakan transaksi yang menggunakan diskon dengan transaksi tanpa diskon.

---

## Tools & Technologies

* **Power BI Desktop:** Digunakan untuk pemodelan data, pembuatan ukuran (DAX Measures), dan pembuatan *Dashboard* interaktif.
* **Power Query:**
