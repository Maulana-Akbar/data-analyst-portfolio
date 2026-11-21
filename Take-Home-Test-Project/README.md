# data-analyst-portfolio-project

<h1 align="center">Analisis Kinerja Penjualan & Perjalanan Belanja Pelanggan E-Commerce (2019)</h1>

<p align="center">
  <img src="https://img.shields.io/badge/Tools-Python-3776AB?style=for-the-badge&logo=python&logoColor=white" alt="Python" />
  <img src="https://img.shields.io/badge/Library-Pandas-150458?style=for-the-badge&logo=pandas&logoColor=white" alt="Pandas" />
  <img src="https://img.shields.io/badge/Tools-Power%20BI-yellow?style=for-the-badge&logo=powerbi" alt="Power BI" />
  <img src="https://img.shields.io/badge/Language-DAX-blue?style=for-the-badge" alt="DAX" />
  <img src="https://img.shields.io/badge/Status-Completed-success?style=for-the-badge" alt="Status" />
</p>

---

## Project Overview

Project ini menganalisis performa penjualan, pola perilaku interaksi pengguna, dan efektivitas perjalanan belanja (*customer journey*) pada platform e-commerce sepanjang tahun 2019 menggunakan **Python** dan **Power BI**. Tujuan utama dari analisis ini adalah untuk mengidentifikasi titik hambatan konversi (*funnel bottleneck*), mengevaluasi pendorong utama pendapatan berdasarkan kategori dan waktu operasional, serta merumuskan rekomendasi strategis berbasis data untuk menekan tingkat pengabaian keranjang belanja (*cart abandonment*).

<blockquote align="center">
  <b>"Ilusi Trafik Kunjungan vs Konversi Pembelian"</b><br>
  <i>Tingginya tingkat pengabaian keranjang belanja (cart abandonment) hingga mencapai 70% di industri e-commerce global membuktikan bahwa tingginya trafik kunjungan dan minat awal konsumen tidak otomatis menjamin pertumbuhan pendapatan tanpa penyelesaian proses checkout yang optimal.</i>
</blockquote>

---

## Business Questions

- Bagaimana ringkasan performa penjualan dan tingkat konversi pelanggan e-commerce secara keseluruhan?
- Bagaimana pola tren penjualan bulanan serta kategori produk apa saja yang menjadi penyumbang pendapatan utama?
- Di tahap mana titik hambatan (*funnel bottleneck*) terjadi pada perjalanan belanja segmen pengguna `Non-Buyer`?
- Bagaimana perbandingan volume pendapatan dan efisiensi konversi (*Activity Conversion Rate*) berdasarkan periode waktu operasional?

---

## Dataset

- **Sumber:** `final_customer_data.xlsx` (E-Commerce Customer Interaction Dataset 2019)
- **Periode Data:** 1 Januari – 22 Desember 2019
- **Jumlah Baris:** 2.090 baris interaksi (*event-level*) dari 401 pengguna unik dan 2.064 sesi kunjungan
- **Jumlah Kolom:** 9 kolom utama (`User_id`, `Session_id`, `DateTime`, `Category`, `SubCategory`, `Action`, `Quantity`, `Rate`, `Total Price`)

---

## Data Preparation

Proses pembersihan, validasi, dan rekayasa fitur dilakukan menggunakan **Python (Pandas)** sebelum pemodelan di **Power BI**. Berikut adalah tahapan yang dilakukan beserta hasilnya:

- **Penilaian Kualitas & Pola Missing Values:** Validasi duplikasi baris serta pemeriksaan pola kekosongan data pada kolom `Quantity`, `Rate`, dan `Total Price` sebanyak 1.889 baris (`90,38%`).
  - **Hasil:** Ditemukan **0 data duplikat**, dan terbukti bahwa 1.889 baris kosong bersifat **struktural** karena seluruhnya merupakan aktivitas non-pembelian (`search`, `product_view`, `read_reviews`, `add_to_cart`, `checkout`), sedangkan 201 baris yang terisi penuh 100% merupakan transaksi `purchase`—sehingga nilai `NaN` dipertahankan tanpa imputasi.
- **Konversi Tipe Data:** Mengubah tipe data pada kolom `DateTime` menjadi format tanggal dan waktu (`datetime64`), kolom `User_id` dan `Session_id` menjadi `string`, serta `Quantity` menjadi bilangan bulat *nullable* (`Int64`).
  - **Hasil:** Seluruh tipe data berhasil distandardisasi sehingga kalkulasi agregasi numerik dan analisis berbasis waktu (*time-series*) berjalan akurat.
- **Standardisasi Teks & Taksonomi Produk:** Membersihkan karakter ilegal (spasi berlebih, tanda koma, dan `\n`), menyeragamkan kapitalisasi (*Title Case*), memperbaiki kesalahan ejaan (*typo* seperti `add_to_wishist`, `read_review`, `Gardern`, `Dumbells`, `Refrigirator`), serta menggabungkan kategori/subkategori yang tumpang tindih.
  - **Hasil:** Nilai unik berhasil dirapikan menjadi **95 kategori** (dari 105), **340 subkategori** (dari 364), dan **11 jenis `Action`** (dari 13), dengan tetap memisahkan `add_review` (pasca-pembelian) dan `product_review` (eksplorasi).
- **Deteksi Outlier Numerikal & Kategorikal:** Evaluasi sebaran menggunakan metode IQR pada variabel transaksi serta deteksi distribusi *long-tail* pada dimensi kategorikal.
  - **Hasil:** Ditemukan **29 *outlier* (`14,43%`)** pada `Total Price` (batas atas `> 18.500`) dan `Rate`, serta **11 *outlier* (`5,47%`)** pada `Quantity`. Seluruh *outlier* dipertahankan karena mencerminkan transaksi bernilai tinggi (`High-Value`) yang wajar dan menjadi dasar penggunaan **Median Order Value (`2.500`)** dibandingkan AOV (`9.455`).
- **Rekayasa Fitur (*Feature Engineering*):**
  - Membuat kolom `Month_Num`, `Month_Name`, `Day_Name`, dan `Time_Period` untuk mengelompokkan interaksi ke 4 periode waktu operasional (*Morning (05-11)*, *Afternoon (12-15)*, *Evening (16-18)*, dan *Night (19-04)*).
  - Membuat kolom `User_Status` (`Buyer` vs `Non-Buyer`), `Order_Segment` (`High-Value`, `Regular`, `Non-Purchase`), serta `Funnel_Step` dan `Funnel_Stage` untuk menyusun alur perjalanan belanja dari `Search` hingga `Purchase`.

---

## Tools & Technologies

- **Python (Pandas, Matplotlib, Seaborn):** Digunakan untuk *data exploration*, *data cleaning*, deteksi *outlier* (IQR), standardisasi taksonomi produk, dan *exploratory data analysis* (EDA).
- **Power BI Desktop:** Digunakan untuk pemodelan data, pembuatan ukuran dinamis (*DAX Measures*), dan pembangunan *Dashboard* interaktif.
- **DAX (Data Analysis Expressions):** Digunakan untuk kalkulasi agregasi metrik utama (`Total Revenue`, `Total Purchase`, `Median Order Value`, `Activity Conversion Rate`, dan `User Conversion Rate`).

---

## Key Findings

### 1. Kesenjangan antara Aktivitas Eksplorasi dan Konversi Pembelian
- Platform mencatatkan total pendapatan sebesar **1.900.530** dari **201 transaksi pembelian** dengan *Median Order Value* sebesar **2.500**.
- Namun, *Activity Conversion Rate* hanya berada di angka **9,62%** dan *User Conversion Rate* sebesar **41,65%**, yang menandakan bahwa **58,35% pengguna** masih tertahan pada tahap eksplorasi tanpa menyelesaikan pembelian.

### 2. Ketergantungan Pendapatan pada Lonjakan Q4 dan Kategori High-Value
- Pertumbuhan penjualan melonjak tajam pada kuartal keempat dengan puncak di **Oktober (602.700 / 56 transaksi)** dan **November (438.580 / 31 transaksi)** yang menyumbang **54,79% total pendapatan tahunan**.
- Kategori penyumbang pendapatan terbesar seperti **Tablets (225K)**, **Laptop And Desktop (90K)**, dan **Tv & Appliances (85K)** sepenuhnya ditopang transaksi segmen *High-Value*, sedangkan **Women Fashion** dan **Accessories** memiliki kontribusi kuat dari segmen *Regular*.

### 3. Kebocoran Konversi Pasca-Keranjang pada Segmen Non-Buyer
- Pengguna pada segmen `Non-Buyer` menunjukkan minat eksplorasi tinggi melalui aktivitas *Read Reviews* (**172 interaksi**), *Product View* (**150 interaksi**), dan *Search* (**135 interaksi**).
- Namun, dari **93 interaksi** yang telah mencapai tahap *Add to Cart*, sebanyak **95,70%** mengalami penurunan tajam sehingga hanya menyisakan **4 interaksi** pada tahap *Checkout* (**3%** dari tahap pencarian) tanpa satu pun pembelian.

### 4. Perbedaan Volume Pendapatan dan Efisiensi Konversi Antar-Periode Waktu
- Periode **Afternoon (12-15)** menghasilkan pendapatan tertinggi sebesar **779.200 (41,00% dari total pendapatan)** namun mencatatkan *Activity Conversion Rate* terendah di angka **10,19%**.
- Sebaliknya, periode **Night (19-04)** mencapai efisiensi konversi tertinggi sebesar **14,41%** dengan pendapatan **689.360**, sehingga **77,27% total pendapatan** terpusat pada jam siang hingga malam hari.

---

## Dashboard Highlights

*Dashboard* interaktif Power BI yang dibangun mencakup visualisasi berikut:
- **Kartu Ringkasan (KPI):** Metrik utama untuk `Total Revenue` (`1.900.530`), `Total Purchase` (`201`), `Median Order Value` (`2.500`), `Activity Conversion Rate` (`9,62%`), dan `User Conversion Rate` (`41,65%`).
- **Panel Filter Interaktif (*Slicers*):** Filter dinamis berdasarkan status pengguna (`User_Status`), segmen pesanan (`Order_Segment`), dan bulan (`Month`).
- **Grafik Tren Bulanan (*Area & Bar Chart*):** Visualisasi `Monthly Revenue Trend` dan `Monthly Purchase Trend` untuk memantau lonjakan musiman sepanjang tahun 2019.
- **Grafik Batang Kategori (*Clustered Bar Chart*):** Perbandingan `Top 7 Categories by Revenue & Order Segment` antara segmen `High-Value` dan `Regular`.
- **Corong Perjalanan Belanja (*Funnel Chart*):** Visualisasi `User Conversion Funnel` dari tahap `Search` hingga `Purchase` untuk mendeteksi titik penurunan konversi.
- **Grafik Kombinasi Waktu (*Line & Clustered Column Chart*):** Analisis `Revenue & Conversion Efficiency by Time Period` yang membandingkan total pendapatan dan efisiensi konversi di 4 periode waktu operasional.

---

## Conclusion

Platform e-commerce berhasil mencatatkan total pendapatan sebesar **1.900.530** dengan nilai belanja tipikal pelanggan sebesar **2.500**, namun pertumbuhan pendapatan masih bertumpu kuat pada lonjakan musiman Q4 (**54,79%**) dan kategori elektronik bernilai tinggi. Di sisi lain, **58,35% pengguna (`Non-Buyer`)** masih berhenti setelah memasukkan produk ke keranjang belanja (**95,70% penurunan** dari *Add to Cart* ke *Checkout*). Melalui penerapan pengingat keranjang otomatis, penargetan promosi berbasis waktu operasional, serta strategi *bundling* produk reguler, perusahaan berpeluang besar meningkatkan konversi transaksi harian tanpa harus bergantung pada lonjakan musiman semata.

---

## Business Recommendations

Berdasarkan *insight* yang ditemukan, berikut adalah langkah strategis yang direkomendasikan untuk meningkatkan konversi dan pendapatan platform:

1. **Implementasi Pengingat Keranjang Otomatis (*Automated Cart Recovery*):**
   Tim CRM dan Pemasaran disarankan untuk mengaktifkan sistem pengingat otomatis melalui notifikasi aplikasi atau surel dalam kurun **1 hingga 24 jam** bagi pengguna yang tertahan di tahap *Add to Cart*, disertai insentif potongan ongkos kirim bersyarat untuk menekan tingkat pembatalan keranjang.

2. **Optimalisasi Kampanye Berbasis Periode Waktu (*Time-Based Targeting*):**
   Tim Pemasaran Digital disarankan untuk memfokuskan anggaran promosi dan jadwal *flash sale* pada periode **Night (19-04)** yang memiliki kesiapan beli tertinggi (**14,41%**), sekaligus menjalankan kampanye penargetan ulang (*retargeting*) keranjang belanja bagi pengunjung aktif pada periode **Afternoon (12-15)**.

3. **Strategi *Bundling* Kategori Reguler dan Akselerasi Momentum Q4:**
   Tim Komersial disarankan untuk menerapkan paket *bundling* pada kategori reguler berfrekuensi tinggi seperti **Women Fashion**, **Mobile Accessories**, dan **Accessories** guna menjaga stabilitas penjualan harian di luar Q4, serta memusatkan kampanye promosi besar menjelang **Oktober–November** untuk memaksimalkan puncak permintaan tahunan.

---

## Author

<p align="center">
  <a href="https://www.linkedin.com/in/radenmaulanaakbar" target="_blank">
    <img src="https://img.shields.io/badge/LinkedIn-Raden%20Maulana%20Akbar-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn Raden Maulana Akbar" />
  </a>
  <a href="https://github.com/Maulana-Akbar" target="_blank">
    <img src="https://img.shields.io/badge/GitHub-Maulana--Akbar-181717?style=for-the-badge&logo=github&logoColor=white" alt="GitHub Maulana-Akbar" />
  </a>
</p>
