# data-analyst-portfolio-project

<h1 align="center">Employee Attrition & High-Performance Loss Analysis</h1>

<p align="center">
  <img src="https://img.shields.io/badge/Tools-Microsoft%20Excel-green?style=for-the-badge&logo=microsoftexcel" alt="Microsoft Excel" />
  <img src="https://img.shields.io/badge/Status-Completed-success?style=for-the-badge" alt="Status" />
</p>

---

## Project Overview

Project ini menganalisis pola dan pendorong utama keluarnya karyawan (*attrition*) serta mendeteksi risiko kehilangan talenta berkinerja tinggi (*high-performer loss*) menggunakan Microsoft Excel[cite: 2]. Berdasarkan 3.000 baris data karyawan mentah, analisis ini bertujuan untuk mengevaluasi validasi status karyawan melalui tanggal keluar (`ExitDate`), sebaran performa (Rating 1–5), serta identifikasi *outlier* pada tingkat departemen dan jenis kepegawaian[cite: 2].

<blockquote align="center">
  <b>"Analisis Risiko Kehilangan Talenta Terbaik"</b><br>
  <i>Tingginya angka pengunduran diri karyawan yang dibarengi dengan hilangnya talenta berkinerja tinggi dapat mengancam stabilitas dan produktivitas operasional perusahaan.</i>
</blockquote>

---

## Business Questions

- **Q1 (Validasi Status & Attrition Makro):** Berapa jumlah riil karyawan yang *resign* berdasarkan validasi tanggal keluar (`ExitDate`), dan berapa tingkat *overall attrition rate* perusahaan?[cite: 2]
- **Q2 (Kualitas Attrition & High-Performance Loss):** Berapa banyak karyawan berkinerja tinggi (Rating 4 & 5) yang mengundurkan diri, dan apakah proporsinya melampaui ambang batas toleransi risiko?[cite: 2]
- **Q3 (Unit Kerja & Departemen Terdampak):** Departemen dan jenis kepegawaian mana yang paling banyak menyumbang *outlier* karyawan berkinerja tinggi yang mengundurkan diri?[cite: 2]

---

## Dataset

- **Sumber:** `employee_data.csv`[cite: 2]
- **Jumlah Baris:** 3.000 baris[cite: 2]
- **Jumlah Kolom:** 26 kolom[cite: 2]
- **Isi dari Raw Data:**
  - Identitas & tanggal masuk/keluar (`EmpID`, `StartDate`, `ExitDate`, `TerminationDescription`)[cite: 2]
  - Struktur organisasi (`DepartmentType`, `Division`, `BusinessUnit`, `Supervisor`)[cite: 2]
  - Status kepegawaian (`EmployeeStatus`, `EmployeeType`, `PayZone`, `Title`)[cite: 2]
  - Kinerja (`Performance Score`, `Current Employee Rating`)[cite: 2]
  - Demografi (`DOB`, `Gender`, `Race`, `Marital Status`, `State`, `LocationCode`, `ADEmail`)[cite: 2]

---

## Data Preparation

Langkah pembersihan dan transformasi data yang dilakukan agar siap dianalisis:

- **1. Cek Duplikasi:** Menggunakan rumus `COUNTA()` dan `UNIQUE()` pada `EmpID`. Ketika jumlah data unik sama dengan jumlah semua data, maka dipastikan tidak ada data yang duplikasi[cite: 2].
- **2. Konversi Tipe Data:** Menggunakan `DATEVALUE()` untuk mengubah tanggal bertipe teks menjadi format *Date* asli[cite: 2].
- **3. Missing Value:** Kolom `ExitDate` dan `TerminationDescription` yang kosong pada 48,9% baris (1.468 data) dipertahankan apa adanya karena bermakna karyawan masih Aktif (bukan data hilang/error). Untuk mengetahui jumlahnya menggunakan rumus `COUNTBLANK()`[cite: 2].
- **4. Inkonsistensi Data:** Mengoreksi kolom status awal yang hanya mencatat 321 *resign*. Dibuat logika acuan: jika `ExitDate` terisi, maka statusnya adalah "Resigned" (total 1.532 baris)[cite: 2].
- **5. Penanganan Outlier:** Mengidentifikasi 356 karyawan berkinerja tinggi (Rating 4 & 5) yang mengundurkan diri sebagai *Outlier*, untuk ditandai sebagai indikator utama *Bad Attrition* (melampaui ambang batas toleransi risiko 15%)[cite: 2].
- **6. Kolom Baru (Formula):**
  - `Status`: Kolom untuk menentukan jumlah karyawan yang *resign*[cite: 2].
  - `Cek_outlier`: Kolom untuk mengecek karyawan yang *resign* dengan *performance rating* $\ge$ 4[cite: 2].

---

## Tools & Technologies

- **Microsoft Excel:** Formula (`IF`, `COUNTIF`, `COUNTA`, `DATEDIF`), Data Validation, PivotTable & PivotChart, Conditional Formatting, Slicer Filter, dan Interactive Executive Dashboard[cite: 2].

---

## Key Findings

### 1. Tingginya Attrition Rate Makro
- Perusahaan mengalami tingkat *attrition* yang sangat tinggi yaitu **51,07%** (sebanyak **1.532** dari 3.000 karyawan *resign*)[cite: 2].

### 2. Ancaman Hilangnya Talenta Terbaik (High-Performance Loss)
- Terdapat **356** karyawan berkinerja tinggi (Rating 4 & 5) yang mengundurkan diri, menyumbang **23,24%** dari total karyawan yang *resign*, di mana angka ini melampaui ambang batas toleransi risiko sebesar 15%[cite: 2].

### 3. Departemen Production & Sales Paling Rentan
- Departemen **Production** (250 *outlier*) dan **Sales** (59 *outlier*) menjadi penyumbang terbesar hilangnya karyawan berkinerja tinggi[cite: 2].

---

## Dashboard Highlights

*Dashboard* interaktif Excel yang dibuat mencakup visualisasi berikut:
- **Ringkasan Kartu (KPI):** Total Resigned (1532), Attrition Rate (51,07%), dan High-Performance Loss (356)[cite: 2].
- **Slicer Filter:** Berdasarkan `DepartmentType` dan `EmployeeType`[cite: 2].
- **Grafik Batang & Pie Chart:** Sebaran status karyawan berdasarkan *Performance Rating* dan proporsi status karyawan[cite: 2].
- **Analisis Departemen:** Sebaran *High-Performer Loss* per departemen[cite: 2].

---

## Conclusion

Perusahaan menghadapi masalah serius terkait tingginya angka *attrition* makro (51,1%) serta ancaman kritis berupa hilangnya talenta berkinerja tinggi (23,24%) yang terkonsentrasi di departemen *Production* dan *Sales*. Hal ini memerlukan evaluasi mendalam serta tindakan retensi talenta yang tepat agar operasional perusahaan tidak terganggu.

---

## Business Recommendations

Berdasarkan *insight* dari analisis, berikut adalah rekomendasi strategi yang diberikan:

1. **Tinjau Ulang Kepuasan Karyawan:** 
   Melakukan evaluasi menyeluruh terhadap tingkat kepuasan karyawan guna menekan angka pengunduran diri secara makro[cite: 2].
2. **Berikan Insentif untuk High Performer:** 
   Menyediakan program insentif, penghargaan, dan jalur pengembangan karier khusus kepada karyawan dengan kinerja tinggi untuk mencegah *High-Performance Loss*[cite: 2].
3. **Evaluasi Beban & Lingkungan Kerja (Production & Sales):** 
   Melakukan evaluasi mendalam terkait beban kerja serta kondisi lingkungan kerja khusus di divisi *Production* dan *Sales* yang menjadi penyumbang *outlier* terbesar[cite: 2].

---

## Author

<p align="center">
  <a href="https://www.linkedin.com/in/radenmaulanaakbar" target="_blank">
    <img src="https://img.shields.io/badge/LinkedIn-Raden%20Maulana%20Akbar-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn Raden Maulana Akbar" />
  </a>
</p>
