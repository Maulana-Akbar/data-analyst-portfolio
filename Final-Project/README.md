# data-analyst-portfolio-project

<h1 align="center">Analisis Kompresi Margin: Evaluasi Efektivitas Program Loyalitas Terhadap Profitabilitas Ritel</h1>

<p align="center">
  <img src="https://img.shields.io/badge/Tools-PostgreSQL_|_Power_BI_|_Python-blue?style=for-the-badge&logo=python" alt="PostgreSQL & Power BI & Python" />
  <img src="https://img.shields.io/badge/Database-PostgreSQL-orange?style=for-the-badge" alt="PostgreSQL" />
  <img src="https://img.shields.io/badge/Status-Completed-success?style=for-the-badge" alt="Status" />
</p>

<p align="center">
  <a href="https://www.linkedin.com/in/radenmaulanaakbar" target="_blank">
    <img src="https://img.shields.io/badge/LinkedIn-Raden_Maulana_Akbar-blue?style=for-the-badge&logo=linkedin" alt="LinkedIn Profile" />
  </a>
</p>

---

## Project Overview

Evaluasi strategis ini diinisiasi berdasarkan kekhawatiran terhadap risiko "jebakan diskon" di industri ritel FMCG. Banyak bisnis terjebak dalam pemberian potongan harga yang terlalu agresif untuk program loyalitas, yang secara tidak disadari menekan harga jual terlalu dekat dengan harga modal dasar. Akibatnya, skema insentif tersebut memicu kompresi margin dan menggerus profitabilitas operasional. Proyek ini bertujuan untuk mendiagnosis efektivitas struktur insentif *membership* serta merumuskan kembali strategi harga demi mengembalikan kesehatan margin tanpa mengorbankan retensi pelanggan.

<blockquote align="center">
  <b>"Jebakan Diskon dan Kompresi Margin Ritel"</b><br>
  <i>Keberhasilan program loyalitas ritel sangat bergantung pada kalibrasi insentif yang presisi. Pemberian diskon agresif yang menekan harga jual justru memicu kompresi margin dan menggerus profitabilitas operasional perusahaan.</i>
</blockquote>

---

## Business Questions

- Sejauh mana tingkat profitabilitas dan margin kesehatan perusahaan saat ini di tengah berjalannya program loyalitas?
- Berapa besar proporsi transaksi yang berada di bawah standar performa margin (*Underperforming*) akibat tekanan pemberian diskon?
- Apakah kontribusi pendapatan dari pelanggan *Member* sebanding dengan pelanggan *Non-Member*?
- Bagaimana merumuskan strategi perbaikan harga dan rekomendasi taktis agar tidak terjadi kebocoran margin yang berlebihan?

---

## Dataset

- **Sumber Data:** `Indian FMCG Retail Sales Customer Inventory (2024).csv`
- **Dimensi Data:** 100.000 baris transaksi dan 21 kolom.
- **Konteks:** Data merekam transaksi ritel FMCG tingkat faktur (*invoice-level*) di 8 kota metropolitan India sepanjang tahun 2024. Variabel kunci meliputi operasional (saluran penjualan, jenis produk) dan finansial (status keanggotaan pelanggan, harga modal, harga jual, pendapatan, biaya).

---

## Data Preparation & Cleaning

Langkah pembersihan dan pengelolaan data yang dilakukan:

- **1. Standarisasi Tipe Data:** Melakukan konversi format tanggal (`Invoice_Date` ke `datetime`), format ID (`Invoice_ID` ke `string`), `Loyalty_Flag` ke `boolean`, serta 7 variabel kategorikal (`City`, `Store_Format`, dll.) ke `category` demi efisiensi memori RAM.
- **2. Penanganan Missing Value:** Terdapat nilai kosong pada demografi pelanggan. Untuk `Customer_Age` (40.08%), ditangani dengan pembuatan kolom *Age_Group* dengan label 'Unknown'. Untuk `Customer_Gender` (5.05%), diimputasi dengan label 'O' (*Others*).
- **3. Penanganan Integritas Data (ID Collision):** Ditemukan 62 `Invoice_ID` duplikat namun dengan rincian transaksi berbeda (kemungkinan karena tidak adanya sistem terpusat antar cabang). Data tetap dipertahankan dan dibuat *Primary Key* baru (`Transaction_ID`) agar analisis tingkat transaksi tetap valid.
- **4. Pengecekan Outlier:** Outlier terdeteksi pada metrik finansial (`Margin`, `Revenue`, `Cost`), namun dipertahankan sepenuhnya sebagai pencilan alami bisnis (*natural business outliers*) yang didorong oleh tingginya nilai transaksi/kuantitas, bukan kesalahan input.
- **5. Feature Engineering:** Membuat variabel penanda kebocoran margin (`Margin_Leakage_Flag`) untuk membedakan transaksi *Underperforming* (< 19.34%) dan *Overperforming* (>= 19.34%).

---

## Tools & Technologies

- **Python (Pandas, Numpy):** Digunakan untuk pembersihan nilai yang hilang (*data cleaning*), standarisasi tipe data, pembuatan fitur baru (*feature engineering*), serta analisis univariat dan bivariat.
- **Microsoft Power BI:** Digunakan untuk analisis visual komprehensif, evaluasi performa profitabilitas, serta perancangan *dashboard* analitik tingkat eksekutif.

---

## Key Findings

### 1. Tingginya Nilai Pendapatan Berisiko (*Revenue at Risk*)
- Perusahaan memang meraup *Total Revenue* sebesar 39,3 Juta, dengan rata-rata margin 19.34%. Namun, terdapat potensi risiko pendapatan (*Revenue at Risk*) mencapai 17,04 Juta akibat tekanan pemberian diskon yang berlebihan pada transaksi. 

### 2. Mayoritas Transaksi Berstatus *Underperforming*
- Dari total transaksi harian, sebanyak 47,22% atau 47.220 transaksi tergolong *Underperforming* (di bawah rata-rata margin), yang memperburuk kebocoran margin finansial secara masif.

### 3. Program Loyalitas (*Membership*) Kurang Efektif
- Pelanggan *Non-Member* justru memberikan kontribusi pendapatan yang jauh melampaui kelompok *Member* (15,6 Juta berbanding 6,6 Juta pada transaksi *Overperforming*). Pada kedua segmen pelanggan tersebut, tingkat pendapatan *Underperforming* tercatat sangat tinggi (sekitar 43%). Hal ini menunjukkan bahwa program loyalitas diskon tidak efektif dalam mendorong profit.

### 4. Akar Masalah: Tekanan pada Harga Jual (*Selling Price*)
- Rata-rata biaya modal (*Cost Price*) untuk barang yang *Underperforming* dan *Overperforming* sama-sama stabil (di kisaran 104-105). Namun, harga jual (*Selling Price*) untuk barang yang *Underperforming* sangat tertekan ke nilai 120.37 (dibandingkan 140.85 pada *Overperforming*). Hal ini membuktikan bahwa hancurnya margin semata-mata dipicu oleh pemberian harga diskon yang berlebihan ke pelanggan.

---

## Conclusion

Berdasarkan hasil analisis, terbukti bahwa kompresi margin dan rendahnya profitabilitas operasional ritel tidak disebabkan oleh tingginya biaya modal (*Cost Price*), melainkan akibat tekanan yang ekstrem terhadap Harga Jual (*Selling Price*) karena pemberian skema diskon program loyalitas yang agresif. Dominasi pelanggan *Non-Member* sebagai penyumbang pendapatan terbesar sekaligus mengonfirmasi ketidakefektifan program keanggotaan saat ini.

---

## Business Recommendations

Berdasarkan *insight* data finansial, berikut adalah langkah strategis yang direkomendasikan untuk menambal kebocoran margin:

1. **Pengetatan Batas Maksimum Diskon (*Price Floor*)**
   Manajemen sangat disarankan untuk merumuskan ulang struktur harga dengan menetapkan batas bawah harga (*price floor*) dan memperketat batas maksimal diskon pada seluruh *channel* dan kategori. Hal ini penting agar transaksi *Underperforming* dapat diminimalisir dan profitabilitas terkunci di area yang sehat.

2. **Revitalisasi Skema Program Loyalitas (*Membership*)**
   Mengingat *Non-Member* adalah penyumbang pendapatan terbesar, perusahaan perlu mendesain ulang insentif *Membership*. Diskon harus dialihkan atau dikurangi, lalu digantikan dengan nilai tambah (*value-added*) atau skema *reward* yang tidak secara langsung memotong harga jual (*Selling Price*).

3. **Strategi Up-Selling dan Taktik *Product Bundling***
   Analisis menemukan korelasi kuat bahwa tingginya margin digerakkan oleh peningkatan ukuran keranjang belanja (*Units*) per nota. Pemasaran harus difokuskan pada taktik *bundling* produk dan *up-selling* untuk menekan beban operasional, alih-alih mengejar konversi penjualan harian dalam nominal kecil secara satuan.
