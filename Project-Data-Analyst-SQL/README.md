# data-analyst-portfolio-project

<h1 align="center">Analisis Biaya Pengiriman E-Commerce: Strategi Menekan Ongkir Mahal di Wilayah Terpencil</h1>

<p align="center">
  <img src="https://img.shields.io/badge/Tools-SQL-blue?style=for-the-badge&logo=postgresql" alt="SQL" />
  <img src="https://img.shields.io/badge/Database-PostgreSQL-orange?style=for-the-badge" alt="PostgreSQL" />
  <img src="https://img.shields.io/badge/Status-Completed-success?style=for-the-badge" alt="Status" />
</p>

---

## Project Overview

Dalam industri *e-commerce*, ketimpangan biaya pengiriman (*freight value disparity*) ke wilayah terpencil sering kali menjadi hambatan utama dalam ekspansi pasar dan retensi pelanggan[cite: 5]. Tingginya ongkos kirim ke area non-metropolitan sering dianggap disebabkan oleh berat atau dimensi barang, padahal jarak geografis dan ketiadaan pasokan lokal merupakan pemicu utamanya[cite: 5]. Project ini menggunakan SQL untuk mengidentifikasi pola *outlier* pada biaya pengiriman, mengisolasi faktor penyebab utama di daerah terdampak, serta memberikan saran efisiensi logistik yang tepat sasaran bagi platform *third-party marketplace*[cite: 5].

<blockquote align="center">
  <b>"Ketimpangan Logistik Wilayah Terpencil vs Jarak Distribusi"</b><br>
  <i>Tingginya ongkos kirim ke wilayah non-metropolitan bukan dipicu oleh berat atau dimensi barang, melainkan murni akibat jarak geografis yang jauh serta ketiadaan pasokan seller lokal.</i>
</blockquote>

---

## Business Questions

- Bagaimana ringkasan distribusi dan karakteristik makro dari ongkos kirim pada transaksi *e-commerce* yang berhasil terkirim (*delivered*)?
- Seberapa besar porsi dan persebaran *outlier* biaya pengiriman ekstrem yang membebani operasional platform?
- Wilayah mana saja yang mengalami tingkat ketimpangan ongkir tertinggi, dan bagaimana korelasi geografisnya?
- Apakah tingginya biaya pengiriman di wilayah terpencil disebabkan oleh berat barang atau murni akibat jarak distribusi?

---

## Dataset

- **Sumber:** `olist_customers_dataset`, `olist_products_dataset`, `olist_orders_dataset`, dan `olist_order_items_dataset.csv`[cite: 5]
- **Relasi Tabel:** Menggunakan skema relasional terintegrasi antara data pesanan, item produk, informasi pelanggan, dan spesifikasi produk[cite: 5].

---

## Data Preparation & Cleaning

Langkah pembersihan dan pengelolaan data yang dilakukan menggunakan PostgreSQL:

- **1. Pengecekan Duplikasi:** 
  - *Hasil:* Ditemukan duplikasi pada tabel produk (`olist_products_dataset`) untuk ID produk tertentu, yang kemudian dibersihkan dengan menghapus data duplikat bernilai redundan[cite: 5].
- **2. Penanganan Missing Value:**
  - Kolom tanggal pesanan yang kosong pada `olist_orders_dataset` (seperti `order_approved_at`, `order_delivered_carrier_date`, `order_delivered_customer_date`) dipertahankan apa adanya karena merepresentasikan status pesanan dibatalkan (*canceled*), belum sampai, atau barang hilang[cite: 5].
  - Imputasi dilakukan pada kategori produk kosong menjadi `'unknown'` serta metrik teks/foto diatur bernilai `0`[cite: 5].
- **3. Konversi Tipe Data:** Mengubah kolom berakhiran *date* yang awalnya bertipe teks (*varchar*) menjadi tipe data *timestamp* yang valid[cite: 5].

---

## Tools & Technologies

- **SQL (PostgreSQL):** Digunakan untuk manipulasi data relasional, pembersihan, agregasi kueri kompleks, serta analisis statistik[cite: 5].
- **Relational Database Management:** Pengelolaan skema multitable menggunakan pemetaan relasi antar-tabel secara terstruktur[cite: 5].

---

## Key Findings

### 1. Distribusi Ongkos Kirim Nasional Miring ke Kanan (Right-Skewed)
- Analisis ringkasan menunjukkan rata-rata ongkir nasional ($19,95$ Reais) lebih tinggi dari nilai median ($16,26$ Reais)[cite: 5]. Rentang harga ekstrem hingga $409,68$ Reais mengindikasikan adanya kelompok transaksi tertentu yang dibebani biaya pengiriman sangat tinggi di atas batas wajar[cite: 5].

### 2. Masalah Pembengkakan Logistik Terisolasi pada 10,25% Transaksi
- Ekstraksi statistik metode IQR mengisolasi $11.296$ barang ($10,25\%$ dari total nasional) sebagai *outlier* ongkir mahal[cite: 5]. Hal ini membuktikan bahwa inefisiensi logistik bukan masalah merata, melainkan kasus terisolasi yang jika diselesaikan akan memotong biaya logistik platform secara drastis[cite: 5].

### 3. Disparitas Logistik Ekstrem Terkonsentrasi di Wilayah Terpencil (Rondônia)
- Pemetaan geografis menunjukkan ketimpangan drastis antar-wilayah[cite: 5]. Negara bagian Rondônia (RO) menjadi area paling terdampak dengan $61,17\%$ transaksi tergolong *outlier* dan median ongkir membengkak hingga $34,82$ Reais (lebih dari $2\times$ lipat median nasional)[cite: 5].

### 4. Ongkos Kirim Mahal Dipicu oleh Jarak Distribusi, Bukan Berat Barang
- Analisis mendalam (*deep-dive*) transaksi di RO menunjukkan bahwa pemicu *outlier* didominasi barang berbobot ringan seperti *beleza_saude* ($\sim 1$ kg) dan *telefonia* ($273$ gram)[cite: 5]. Temuan ini mementahkan asumsi bahwa ongkir mahal disebabkan oleh berat produk, melainkan murni akibat jarak serta ketiadaan *seller* lokal[cite: 5].

---

## Conclusion

Berdasarkan hasil analisis data, dapat disimpulkan bahwa masalah pembengkakan biaya pengiriman di platform *e-commerce* bukanlah persoalan yang merata di seluruh lini, melainkan kasus terisolasi yang hanya menimpa sekitar $10\%$ transaksi di wilayah non-metropolitan[cite: 5]. Lonjakan tarif ekstrem ini terbukti tidak berkorelasi dengan berat atau dimensi fisik produk, melainkan murni dipicu oleh jarak geografis yang jauh dari pusat penjual serta ketiadaan pasokan *merchant* lokal[cite: 5].

---

## Business Recommendations

Berdasarkan *insight* yang ditemukan, terdapat beberapa langkah penyesuaian strategi yang direkomendasikan untuk mendukung efisiensi operasional platform:

1. **Evaluasi Pengiriman Kolektif (*Bulk Shipping*) via Kargo Mitra:**
   Tim Bisnis disarankan untuk mengevaluasi opsi kerja sama konsinyasi atau *bulk shipping* dengan mitra kargo di wilayah Utara untuk *top seller* (khususnya kategori *telefonia*), dengan tujuan memotong biaya ongkir eceran jarak jauh tanpa menambah beban aset fisik milik platform[cite: 5].
   
2. **Negosiasi Tarif Khusus (*Flat-Rate*) Paket Ringan:**
   Tim Logistik disarankan untuk menjajaki negosiasi skema tarif khusus dengan kurir mitra untuk paket berbobot di bawah $1$ kg ke wilayah (RO, PB, MA), dengan tujuan menekan biaya pengiriman barang ringan seperti *telefonia* ($273$ gram) yang saat ini rata-rata ongkirnya masih membengkak hingga $41,86$ Reais[cite: 5].
   
3. **Prioritas Akuisisi Penjual Lokal (*Merchant Onboarding*):**
   Tim *Merchant Acquisition* disarankan memprioritaskan perekrutan *seller* baru di wilayah RO dan sekitarnya untuk kategori *esporte_lazer* dan *
