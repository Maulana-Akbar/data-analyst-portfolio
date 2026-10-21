# data-analyst-portfolio-project

<h1 align="center">Analisis Kegagalan Layanan Digital dan Kabin terhadap Retensi Pelanggan Setia</h1>

<p align="center">
  <img src="https://img.shields.io/badge/Tools-PostgreSQL_|_Power_BI-blue?style=for-the-badge&logo=postgresql" alt="PostgreSQL & Power BI" />
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

Tingginya angka ketidakpuasan penumpang kelas ekonomi membuktikan bahwa masalah utama bisnis penerbangan saat ini tidak lagi didominasi oleh kendala operasional seperti penundaan jadwal (*delay*), melainkan pada kegagalan titik sentuh digital (*Online Boarding*) dan minimnya fasilitas kabin (*Inflight Entertainment*). Ketidakmampuan memberikan pengalaman yang mulus (*seamless*) pada segmen kelas ekonomi menciptakan risiko bisnis yang fatal, di mana 76,64% dari penumpang yang tidak puas merupakan *Loyal Customer*. *Project* ini diinisiasi untuk mengidentifikasi pemicu utama ketidakpuasan serta merumuskan strategi perbaikan layanan guna mencegah penurunan tingkat retensi pelanggan (*customer churn*).

<blockquote align="center">
  <b>"Pergeseran Pemicu Kepuasan Pelanggan Maskapai Penerbangan"</b><br>
  <i>Ketidakpuasan penumpang bukan dipicu oleh keterlambatan operasional, melainkan kegagalan pengalaman digital dan minimnya fasilitas kabin yang mengancam retensi pelanggan setia.</i>
</blockquote>

---

## Business Questions

- Titik sentuh layanan (*touchpoints*) mana yang paling menentukan apakah penumpang pulang dengan perasaan puas atau tidak puas?
- Seberapa besar kesenjangan tingkat kepuasan antar segmen demografi penerbangan (kelas penerbangan dan tipe perjalanan)?
- Bagaimana tingkat korelasi antara keterlambatan penerbangan (*delay*) dibandingkan dengan layanan digital dan kabin terhadap kepuasan akhir penumpang?
- Bagaimana merumuskan strategi perbaikan layanan untuk mencegah *churn* pada basis *Loyal Customer* di segmen yang terdampak?

---

## Dataset

- **Sumber Data:** `Customer Satisfaction and Sentiment Analysis.csv`
- **Dimensi Data:** 100.000 baris dan 25 kolom.
- **Konteks:** Data merekam jejak perjalanan (*customer journey*) mulai dari profil demografi awal, layanan di darat (*check-in/booking*), kenyamanan di udara (*inflight entertainment & seat comfort*), hingga durasi keterlambatan.

---

## Data Preparation & Cleaning

Langkah pembersihan dan pengelolaan data yang dilakukan menggunakan PostgreSQL:

- **1. Pengecekan Konsistensi & Duplikasi:** Tidak ditemukan anomali nilai kategorikal dan tidak ada data duplikat pada ke-100.000 baris. 
- **2. Penanganan Missing Value:** Ditemukan *missing values* sebanyak 300 baris (0,3%) pada kolom `Arrival Delay in Minutes`. Untuk menghindari asumsi spekulatif akibat dinamika variabel di udara, data *null* tersebut dihapus menggunakan perintah `DELETE`.
- **3. Konversi Tipe Data:** Mengubah tipe data pada kolom `Arrival Delay in Minutes` menjadi `integer` (`int4`) menggunakan klausa `ALTER TABLE` guna menyeragamkan format dengan kolom `Departure Delay in Minutes`.
- **4. Pengecekan Outlier:** Outlier pada jarak terbang (*Flight Distance*) dan durasi keterlambatan tetap dipertahankan karena secara *domain knowledge* industri penerbangan merupakan data operasional yang valid (mewakili penerbangan rute jarak jauh dan gangguan operasional nyata).

---

## Tools & Technologies

- **SQL (PostgreSQL):** Digunakan untuk ekstraksi data, pembersihan nilai yang hilang (*data cleaning*), manipulasi *database*, serta identifikasi *outlier*.
- **Microsoft Power BI:** Digunakan untuk analisis univariat, bivariat, multivariat (matriks korelasi), serta perancangan *dashboard* analitik interaktif.

---

## Key Findings

### 1. Loyalitas Tidak Menjamin Kepuasan Layanan (Anomali Bisnis)
- Meskipun 81,71% dari total populasi penumpang berstatus *Loyal Customer*, mayoritas dari mereka (56,66%) justru merasa *Neutral/Dissatisfied*. Hal ini mengindikasikan bahwa tingginya loyalitas saat ini tidak mencerminkan kepuasan terhadap layanan maskapai.

### 2. Disparitas Kualitas Layanan Menekan Kelas Ekonomi & Personal Travel
- Sumber ketidakpuasan utama terpusat pada penumpang kelas *Eco*, yang menyumbang 36,62% dari total ketidakpuasan. Secara spesifik, segmen *Personal Travel* di kelas ini paling tertekan, di mana 27,86% merasa tidak puas berbanding hanya 3,14% yang merasa puas.

### 3. Pemicu Utama Kepuasan: Layanan Digital & Hiburan (Bukan Ketepatan Waktu)
- Analisis *heatmap* korelasi membuktikan bahwa skor kepuasan (CSAT) paling dipengaruhi oleh *Online boarding* (0,39) dan *Inflight entertainment* (0,32). Sebaliknya, faktor keterlambatan (*Arrival Delay*) berkorelasi sangat minim (-0,04) terhadap CSAT, mematahkan anggapan bahwa *delay* adalah sumber komplain terbesar.

### 4. Ancaman Churn Massal pada Basis Pelanggan Utama
- Dari seluruh penumpang kelas *Eco* yang tidak puas, mayoritas mutlak sebesar 76,64% adalah *Loyal Customer*. Hal ini adalah peringatan krusial bahwa maskapai berisiko kehilangan basis pelanggan utamanya apabila kualitas layanan tak kunjung dibenahi.

---

## Conclusion

Berdasarkan hasil analisis, dapat disimpulkan bahwa rendahnya performa skor CSAT (43,34%) bukan berakar dari masalah jadwal keterlambatan penerbangan, melainkan berpusat pada minimnya standardisasi fitur *Online Boarding* dan kelangkaan fasilitas hiburan (*Inflight Entertainment*). Kesenjangan layanan ini terutama sangat dirasakan oleh penumpang *Personal Travel* di kelas Ekonomi (*Eco*). Tingginya porsi *Loyal Customer* (76,64%) pada segmen yang tidak puas ini menandakan adanya ancaman *customer churn* yang sangat serius bagi kelangsungan bisnis maskapai ke depannya.

---

## Business Recommendations

Berdasarkan *insight* data yang ditemukan, berikut langkah strategis yang direkomendasikan untuk menekan angka ketidakpuasan:

1. **Standardisasi & Optimalisasi Layanan *Online Boarding***
   Tim IT dan operasional disarankan melakukan perbaikan *bug* UI/UX pada aplikasi *mobile*, meningkatkan kapasitas *server check-in*, dan merilis fitur *auto check-in* 24 jam sebelum keberangkatan untuk mengatasi antrean sekaligus mendongkrak pengalaman digital.

2. **Peremajaan & Pengadaan Paket *Add-on* Hiburan Kelas *Eco***
   Maskapai disarankan melakukan pembaruan/peremajaan layar (*screen*) di armada khusus kelas *Eco*. Sebagai opsi efisiensi, dapat dirilis paket *add-on* hiburan berbiaya rendah (seperti *Wi-Fi streaming* atau penyewaan tablet prabayar) untuk menunjang rute penerbangan jarak jauh segmen *Personal Travel*.

3. **Program Retensi & Apresiasi Khusus *Loyal Customer***
   Tim CRM disarankan untuk mengintegrasikan status *Loyal Customer* kelas *Eco* ke dalam sistem *check-in* secara otomatis guna memberikan insentif khusus, seperti layanan *priority boarding* atau penawaran kuota *Wi-Fi* gratis, untuk meminimalisir niatan pindah ke kompetitor.
