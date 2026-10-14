Marketing & Growth Analytics Insights

Project Overview

Project ini menganalisis efisiensi periklanan dan retensi pelanggan berdasarkan data performa pemasaran. Fokus utama dari analisis ini adalah untuk mengidentifikasi pemicu utama inefisiensi biaya iklan (Ad Cost), melacak titik kebocoran konversi (drop-off), serta memberikan rekomendasi bisnis berbasis data guna mencegah kerugian finansial akibat ketergantungan kronis pada iklan berbayar (Paid Ads).

"Jebakan Biaya Iklan vs Retensi Pelanggan"

Kejatuhan struktur pemasaran pada model akuisisi agresif membuktikan bahwa ketergantungan pada Paid Ads tanpa ditopang oleh konversi halaman dan retensi jangka panjang hanya akan menciptakan ilusi tingginya trafik sekaligus menghancurkan margin keuntungan secara fatal.

Problem Statement & Business Questions

Mengapa pengeluaran iklan berbayar yang masif gagal memberikan pengembalian modal yang sepadan (low ROAS)?

Di mana titik kebocoran trafik (traffic drop-off) paling krusial terjadi dalam conversion funnel?

Bagaimana pola retensi pelanggan berdampak terhadap akumulasi pendapatan (revenue) bisnis secara keseluruhan?

Langkah strategis apa yang dapat diambil untuk mengoptimalkan anggaran periklanan dan meningkatkan retensi pembeli?

Dataset

Sumber: practical_data_marketing_growth_analytics.csv

Jumlah Baris: 800 baris

Jumlah Kolom: 16 kolom (user_id, first_visit_date, channel, source, device, sessions, page_views, bounce, add_to_cart, purchase, revenue, ad_cost, clicks, impressions, repeat_purchase, retention_month)

Data Preparation & Cleaning

Proses pembersihan dan manipulasi data dilakukan menggunakan PostgreSQL untuk memastikan integritas dan akurasi analisis. Berikut adalah tahapan yang dilakukan:

Pemeriksaan Kualitas Data:

Hasil: Dataset terbukti bersih dengan 0 missing values dan 0 data duplikat dari total 800 baris data.

Konversi Tipe Data:

Mengubah tipe data pada kolom first_visit_date dari VARCHAR(50) menjadi tipe DATE.

Hasil: Tipe data berhasil disesuaikan sehingga fungsi kalkulasi berbasis waktu (time-series) dan agregasi berjalan akurat.

Analisis Outlier & Konsistensi Data:

Outlier Numerikal: Ditemukan 150 outlier pada revenue (wajar karena nilai transaksi tinggi) dan 89 outlier pada ad_cost (menandakan adanya pengeluaran iklan terpusat yang tinggi).

Outlier Kategorikal: Mayoritas pengguna mengakses platform melalui perangkat Mobile (63.00%) dan saluran Paid Ads (31.38%).

Hasil: Ditemukan bahwa tingkat keterlibatan lanjutan tergolong sangat rendah karena didominasi pengguna yang tidak melakukan add_to_cart (58.88%), tidak purchase (81.25%), dan tidak repeat_purchase (94.00%).

Tools & Technologies

Power BI Desktop: Digunakan untuk pemodelan data, pembuatan measures (DAX), visualisasi conversion funnel, dan pembuatan interactive dashboard.

PostgreSQL: Digunakan untuk tahap data exploration, data cleaning, konversi tipe data, serta uji konsistensi kolom.

SQL: Digunakan untuk kueri manipulasi data (Data Manipulation & Transformation).

Key Findings & Data Insights

Korelasi Metrik Pemasaran:

Konversi transaksi (purchase) memiliki korelasi paling kuat dengan revenue (0.88) dan durasi retensi pelanggan (retention_month, 0.81).

Sebaliknya, pengeluaran biaya iklan (ad_cost) hanya menunjukkan korelasi yang sangat lemah (0.02) terhadap konversi maupun pendapatan.

Inefisiensi Saluran Iklan Berbayar (Paid Ads):

Saluran Paid Ads menyerap seluruh biaya iklan sebesar Rp10.948.907,00 namun hanya menghasilkan pendapatan Rp13.177.258,00 (ROAS 1.20x / mendekati titik impas).

Saluran organik secara kumulatif mampu menyumbang Rp27.826.647,00 tanpa mengeluarkan biaya iklan sama sekali.

Titik Kebocoran Trafik Utama (Landing Page Drop-off):

Dari total 442.700 impressions, rasio klik (CTR) tercatat 4.40% (19.493 klik).

Penurunan tajam terjadi saat hanya 1.69% (329 pengguna) yang melanjutkannya ke tahap add_to_cart. Kebocoran utama terjadi pada landing page.

Namun, konversi dari keranjang ke pembelian (Cart-to-Purchase) tergolong tinggi di angka 45.59% (150 pembeli).

Dominasi One-Time Buyer & Konsentrasi Retensi:

Rata-rata retensi pelanggan berada di angka 0.43 bulan, menandakan dominasi pembeli sekali transaksi.

Pendapatan mencapai puncaknya pada bulan pertama (Rp19.186.354,00) dan berangsur melandai pada bulan-bulan berikutnya.

Dashboard Highlights

Dashboard interaktif Power BI mencakup visualisasi berikut:

Kartu Ringkasan (KPI Cards): Metrik untuk Total Revenue (Rp41,00M), Total Ad Cost (Rp10,95M), ROAS (1.20x), dan Avg Retention (0.43 bulan).

Grafik Kombinasi (Bar & Line Chart): Perbandingan Ad Cost vs Revenue berdasarkan Marketing Channel.

Conversion Funnel: Pelacakan titik drop-off trafik mulai dari Impressions, Clicks, Add to Cart, hingga Purchase.

Tren Pendapatan (Line Chart): Revenue Trend by Retention Month untuk melihat pengaruh retensi terhadap pendapatan.

Conclusion

Bisnis saat ini mengalami inefisiensi alokasi pemasaran akibat ketergantungan pada saluran iklan berbayar yang menghasilkan ROAS sangat rendah. Hambatan utama konversi berada pada tahap landing page sebelum masuk ke keranjang belanja, serta minimnya retensi jangka panjang yang menyebabkan arus kas menumpuk hanya di bulan pertama.

Business Recommendations

Efisiensi Anggaran Pemasaran & Optimalisasi Kanal Organik:

Pengalokasian biaya iklan berbayar yang berkinerja rendah disarankan untuk dikurangi, agar anggaran dapat dialihkan guna mengoptimalkan konten dan pencarian organik yang terbukti jauh lebih efisien dalam menyumbang pendapatan.

Perbaikan Antarmuka (UX) dan Penawaran Halaman Produk:

Evaluasi serta perbaikan pada tampilan landing page dan informasi produk dianjurkan untuk segera dilakukan guna menekan tingkat kebocoran trafik (drop-off) yang ekstrem sebelum pengunjung masuk ke keranjang belanja.

Penerapan Program Re-aktivasi & Retensi Pelanggan:

Strategi pemasaran dianjurkan untuk lebih difokuskan pada program re-aktivasi—seperti insentif/pemberian voucher untuk pembelian kedua—guna menekan dominasi one-time buyer dan menjaga stabilitas retensi pelanggan jangka panjang.

Author

Catatan Penggunaan:

Semua teks, metrik, ringkasan data cleaning, key findings, hingga rekomendasi bisnis di atas telah disesuaikan 100% dengan isi dokumen PDF Anda.

Format badge, garis pemisah <hr>, penulisan variabel dengan backticks (misal `Paid Ads`), serta blok kutipan dibuat presisi sesuai gaya gambar contoh.

Anda tinggal mengganti URL pada tautan badge LinkedIn di bagian Author dengan tautan profil resmi Anda.
