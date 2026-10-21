/*										==================================================
											   MINI PROJECT MARKETING ANALYSIS WITH SQL
										================================================== 
 	Dataset yang digunakan merupakan hasil import dari penyelenggara bootcamp yang berekstensi .csv bernama 
 	practical_data_marketing_growth_analytics.csv yaitu dataset analitik pemasaran digital (digital marketing & growth analytics) 
 	level pengguna (user-level dataset). Dataset ini merekam riwayat akuisisi, interaksi website, performa biaya iklan, 
 	hingga aktivitas konversi dan retensi dari pengguna unik. 

	
 
==================================================
		SECTION A: DATA EXPLORATION
==================================================
1. Penjelasan setiap kolom:
   
	a. 	Unnamed: 0							: Indeks bawaan dari baris data (bisa diabaikan atau dihapus saat tahap Data Cleaning).
	b. 	id									: Nomor identifikasi unik untuk setiap penumpang.
	c,	Gender								: Jenis kelamin dari penumpang (Male/Pria atau Female/Wanita).
	d. 	Customer Type						: Kategori tingkat loyalitas pelanggan maskapai (Loyal Customer atau Disloyal Customer).
	e.	Age									: Usia penumpang pada saat penerbangan.
	f.	Type of Travel						: Tujuan dari perjalanan pelanggan (Business travel untuk urusan pekerjaan/bisnis atau Personal travel 
											  untuk urusan pribadi).
	g.	Class								: Kelas penerbangan yang digunakan oleh pelanggan (Business, Eco, atau Eco Plus).
	h.	Flight Distance						: Jarak tempuh dari penerbangan tersebut.
	i.	Inflight wifi service				: Tingkat kepuasan pelanggan terhadap koneksi/layanan WiFi di pesawat (Skala 0-5).
	j.	Departure/Arrival time convenient	: Tingkat kepuasan terhadap waktu keberangkatan maupun kedatangan (Skala 0-5).
	k.	Ease of Online booking				: Tingkat kepuasan terhadap kemudahan memesan tiket maskapai secara online (Skala 0-5).
	l.	Gate location						: Tingkat kepuasan terhadap kemudahan akses dan lokasi gerbang keberangkatan di bandara (Skala 0-5).
	m.	Food and drink						: Tingkat kepuasan pelanggan terhadap kualitas sajian makanan dan minuman di pesawat (Skala 0-5).
	n.	Online boarding						: Tingkat kepuasan terhadap kelancaran proses boarding secara daring (Skala 0-5).
	o.	Seat comfort						: Tingkat kepuasan terhadap kenyamanan kursi pesawat yang diduduki (Skala 0-5).
	p.	Inflight entertainment				: Tingkat kepuasan terhadap fasilitas hiburan yang tersedia selama penerbangan (Skala 0-5).
	q.	On-board service					: Tingkat kepuasan terhadap pelayanan yang diberikan oleh awak kabin selama di pesawat (Skala 0-5).
	r.	Leg room service					: Tingkat kepuasan terhadap kelegaan dan ruang kaki (leg room) pada tempat duduk (Skala 0-5).
	s.	Baggage handling					: Tingkat kepuasan terhadap penanganan koper/bagasi oleh pihak maskapai (Skala 0-5).
	t.	Checkin service						: Tingkat kepuasan terhadap proses layanan saat melakukan check-in di loket (Skala 0-5).
	u.	Inflight service					: Tingkat kepuasan pelanggan terhadap layanan kru selama penerbangan secara umum (Skala 0-5).
	v.	Cleanliness							: Tingkat kepuasan pelanggan terhadap kebersihan kabin pesawat (Skala 0-5).
	w.	Departure Delay in Minutes			: Total durasi keterlambatan saat pesawat diberangkatkan (dalam menit).
	x.	Arrival Delay in Minutes			: Total durasi keterlambatan saat pesawat tiba di bandara tujuan (dalam menit).
	y.	satisfaction						: Variabel sentimen/target: Merupakan sentimen akhir pelanggan yang dikategorikan sebagai 
											  Satisfied (Puas) atau Neutral or dissatisfied (Netral / Tidak Puas).
	 
 	==================================================
           SECTION A: DATA EXPLORATION
    ================================================== 
*/

-- 1.Pemeriksaan kondisi dataset (jumlah baris, jumlah kolom, duplikasi,dan missing values)
	SELECT 
	    'Jumlah Baris' AS "Indikator Pemeriksaan", 
	    (SELECT COUNT(*) FROM customer_satisfaction_and_sentiment_analysis) AS "Jumlah Pemeriksaan"
	
	UNION ALL
	
	SELECT 
	    'Jumlah Kolom', 
	    (SELECT COUNT(*) 
	     FROM information_schema.columns 
	     WHERE table_name = 'customer_satisfaction_and_sentiment_analysis')
	
	UNION ALL
	
	SELECT 
	    'Jumlah Duplikasi', 
	    (SELECT COUNT(*) FROM customer_satisfaction_and_sentiment_analysis) - 
	    (SELECT COUNT(*) FROM (SELECT DISTINCT * FROM customer_satisfaction_and_sentiment_analysis) sub)
	
	UNION ALL
	
	SELECT 
	    'Jumlah Missing Values',
	    (SELECT 
	        (COUNT(*) FILTER (WHERE "Unnamed: 0" IS NULL)) +
	        (COUNT(*) FILTER (WHERE id IS NULL)) +
	        (COUNT(*) FILTER (WHERE "Gender" IS NULL)) +
	        (COUNT(*) FILTER (WHERE "Customer Type" IS NULL)) +
	        (COUNT(*) FILTER (WHERE "Age" IS NULL)) +
	        (COUNT(*) FILTER (WHERE "Type of Travel" IS NULL)) +
	        (COUNT(*) FILTER (WHERE "Class" IS NULL)) +
	        (COUNT(*) FILTER (WHERE "Flight Distance" IS NULL)) +
	        (COUNT(*) FILTER (WHERE "Inflight wifi service" IS NULL)) +
	        (COUNT(*) FILTER (WHERE "Departure/Arrival time convenient" IS NULL)) +
	        (COUNT(*) FILTER (WHERE "Ease of Online booking" IS NULL)) +
	        (COUNT(*) FILTER (WHERE "Gate location" IS NULL)) +
	        (COUNT(*) FILTER (WHERE "Food and drink" IS NULL)) +
	        (COUNT(*) FILTER (WHERE "Online boarding" IS NULL)) +
	        (COUNT(*) FILTER (WHERE "Seat comfort" IS NULL)) +
	        (COUNT(*) FILTER (WHERE "Inflight entertainment" IS NULL)) +
	        (COUNT(*) FILTER (WHERE "On-board service" IS NULL)) +
	        (COUNT(*) FILTER (WHERE "Leg room service" IS NULL)) +
	        (COUNT(*) FILTER (WHERE "Baggage handling" IS NULL)) +
	        (COUNT(*) FILTER (WHERE "Checkin service" IS NULL)) +
	        (COUNT(*) FILTER (WHERE "Inflight service" IS NULL)) +
	        (COUNT(*) FILTER (WHERE "Cleanliness" IS NULL)) +
	        (COUNT(*) FILTER (WHERE "Departure Delay in Minutes" IS NULL)) +
	        (COUNT(*) FILTER (WHERE "Arrival Delay in Minutes" IS NULL)) +
	        (COUNT(*) FILTER (WHERE "satisfaction" IS NULL))
	     FROM customer_satisfaction_and_sentiment_analysis);
	


--2. cek missing values per kolom
	WITH PengecekanMissing AS (
	    SELECT 'Unnamed: 0' AS "Nama Kolom", COUNT(*) FILTER (WHERE "Unnamed: 0" IS NULL) AS "Jumlah Missing", ROUND(COUNT(*) FILTER (WHERE "Unnamed: 0" IS NULL) * 100.0 / COUNT(*), 2) AS "Persentase (%)" FROM customer_satisfaction_and_sentiment_analysis
	    UNION ALL SELECT 'id', COUNT(*) FILTER (WHERE id IS NULL), ROUND(COUNT(*) FILTER (WHERE id IS NULL) * 100.0 / COUNT(*), 2) FROM customer_satisfaction_and_sentiment_analysis
	    UNION ALL SELECT 'Gender', COUNT(*) FILTER (WHERE "Gender" IS NULL), ROUND(COUNT(*) FILTER (WHERE "Gender" IS NULL) * 100.0 / COUNT(*), 2) FROM customer_satisfaction_and_sentiment_analysis
	    UNION ALL SELECT 'Customer Type', COUNT(*) FILTER (WHERE "Customer Type" IS NULL), ROUND(COUNT(*) FILTER (WHERE "Customer Type" IS NULL) * 100.0 / COUNT(*), 2) FROM customer_satisfaction_and_sentiment_analysis
	    UNION ALL SELECT 'Age', COUNT(*) FILTER (WHERE "Age" IS NULL), ROUND(COUNT(*) FILTER (WHERE "Age" IS NULL) * 100.0 / COUNT(*), 2) FROM customer_satisfaction_and_sentiment_analysis
	    UNION ALL SELECT 'Type of Travel', COUNT(*) FILTER (WHERE "Type of Travel" IS NULL), ROUND(COUNT(*) FILTER (WHERE "Type of Travel" IS NULL) * 100.0 / COUNT(*), 2) FROM customer_satisfaction_and_sentiment_analysis
	    UNION ALL SELECT 'Class', COUNT(*) FILTER (WHERE "Class" IS NULL), ROUND(COUNT(*) FILTER (WHERE "Class" IS NULL) * 100.0 / COUNT(*), 2) FROM customer_satisfaction_and_sentiment_analysis
	    UNION ALL SELECT 'Flight Distance', COUNT(*) FILTER (WHERE "Flight Distance" IS NULL), ROUND(COUNT(*) FILTER (WHERE "Flight Distance" IS NULL) * 100.0 / COUNT(*), 2) FROM customer_satisfaction_and_sentiment_analysis
	    UNION ALL SELECT 'Inflight wifi service', COUNT(*) FILTER (WHERE "Inflight wifi service" IS NULL), ROUND(COUNT(*) FILTER (WHERE "Inflight wifi service" IS NULL) * 100.0 / COUNT(*), 2) FROM customer_satisfaction_and_sentiment_analysis
	    UNION ALL SELECT 'Departure/Arrival time convenient', COUNT(*) FILTER (WHERE "Departure/Arrival time convenient" IS NULL), ROUND(COUNT(*) FILTER (WHERE "Departure/Arrival time convenient" IS NULL) * 100.0 / COUNT(*), 2) FROM customer_satisfaction_and_sentiment_analysis
	    UNION ALL SELECT 'Ease of Online booking', COUNT(*) FILTER (WHERE "Ease of Online booking" IS NULL), ROUND(COUNT(*) FILTER (WHERE "Ease of Online booking" IS NULL) * 100.0 / COUNT(*), 2) FROM customer_satisfaction_and_sentiment_analysis
	    UNION ALL SELECT 'Gate location', COUNT(*) FILTER (WHERE "Gate location" IS NULL), ROUND(COUNT(*) FILTER (WHERE "Gate location" IS NULL) * 100.0 / COUNT(*), 2) FROM customer_satisfaction_and_sentiment_analysis
	    UNION ALL SELECT 'Food and drink', COUNT(*) FILTER (WHERE "Food and drink" IS NULL), ROUND(COUNT(*) FILTER (WHERE "Food and drink" IS NULL) * 100.0 / COUNT(*), 2) FROM customer_satisfaction_and_sentiment_analysis
	    UNION ALL SELECT 'Online boarding', COUNT(*) FILTER (WHERE "Online boarding" IS NULL), ROUND(COUNT(*) FILTER (WHERE "Online boarding" IS NULL) * 100.0 / COUNT(*), 2) FROM customer_satisfaction_and_sentiment_analysis
	    UNION ALL SELECT 'Seat comfort', COUNT(*) FILTER (WHERE "Seat comfort" IS NULL), ROUND(COUNT(*) FILTER (WHERE "Seat comfort" IS NULL) * 100.0 / COUNT(*), 2) FROM customer_satisfaction_and_sentiment_analysis
	    UNION ALL SELECT 'Inflight entertainment', COUNT(*) FILTER (WHERE "Inflight entertainment" IS NULL), ROUND(COUNT(*) FILTER (WHERE "Inflight entertainment" IS NULL) * 100.0 / COUNT(*), 2) FROM customer_satisfaction_and_sentiment_analysis
	    UNION ALL SELECT 'On-board service', COUNT(*) FILTER (WHERE "On-board service" IS NULL), ROUND(COUNT(*) FILTER (WHERE "On-board service" IS NULL) * 100.0 / COUNT(*), 2) FROM customer_satisfaction_and_sentiment_analysis
	    UNION ALL SELECT 'Leg room service', COUNT(*) FILTER (WHERE "Leg room service" IS NULL), ROUND(COUNT(*) FILTER (WHERE "Leg room service" IS NULL) * 100.0 / COUNT(*), 2) FROM customer_satisfaction_and_sentiment_analysis
	    UNION ALL SELECT 'Baggage handling', COUNT(*) FILTER (WHERE "Baggage handling" IS NULL), ROUND(COUNT(*) FILTER (WHERE "Baggage handling" IS NULL) * 100.0 / COUNT(*), 2) FROM customer_satisfaction_and_sentiment_analysis
	    UNION ALL SELECT 'Checkin service', COUNT(*) FILTER (WHERE "Checkin service" IS NULL), ROUND(COUNT(*) FILTER (WHERE "Checkin service" IS NULL) * 100.0 / COUNT(*), 2) FROM customer_satisfaction_and_sentiment_analysis
	    UNION ALL SELECT 'Inflight service', COUNT(*) FILTER (WHERE "Inflight service" IS NULL), ROUND(COUNT(*) FILTER (WHERE "Inflight service" IS NULL) * 100.0 / COUNT(*), 2) FROM customer_satisfaction_and_sentiment_analysis
	    UNION ALL SELECT 'Cleanliness', COUNT(*) FILTER (WHERE "Cleanliness" IS NULL), ROUND(COUNT(*) FILTER (WHERE "Cleanliness" IS NULL) * 100.0 / COUNT(*), 2) FROM customer_satisfaction_and_sentiment_analysis
	    UNION ALL SELECT 'Departure Delay in Minutes', COUNT(*) FILTER (WHERE "Departure Delay in Minutes" IS NULL), ROUND(COUNT(*) FILTER (WHERE "Departure Delay in Minutes" IS NULL) * 100.0 / COUNT(*), 2) FROM customer_satisfaction_and_sentiment_analysis
	    UNION ALL SELECT 'Arrival Delay in Minutes', COUNT(*) FILTER (WHERE "Arrival Delay in Minutes" IS NULL), ROUND(COUNT(*) FILTER (WHERE "Arrival Delay in Minutes" IS NULL) * 100.0 / COUNT(*), 2) FROM customer_satisfaction_and_sentiment_analysis
	    UNION ALL SELECT 'satisfaction', COUNT(*) FILTER (WHERE "satisfaction" IS NULL), ROUND(COUNT(*) FILTER (WHERE "satisfaction" IS NULL) * 100.0 / COUNT(*), 2) FROM customer_satisfaction_and_sentiment_analysis
	)
	SELECT * 
	FROM PengecekanMissing
	WHERE "Jumlah Missing" > 0;

-- 3. Cek konsistensi semua kolom
	SELECT 
	    'Unnamed: 0' AS "Nama Kolom",
	    COUNT(DISTINCT "Unnamed: 0") AS "Unik (Sensitif Kapital)",
	    COUNT(DISTINCT LOWER("Unnamed: 0"::TEXT)) AS "Unik (Huruf Kecil)",
	    CASE WHEN COUNT(DISTINCT "Unnamed: 0") = COUNT(DISTINCT LOWER("Unnamed: 0"::TEXT)) THEN 'Konsisten (Aman)' ELSE 'Tidak Konsisten (Periksa)' END AS "Status Pengecekan"
	FROM customer_satisfaction_and_sentiment_analysis
	
	UNION ALL
	
	SELECT 
	    'id',
	    COUNT(DISTINCT id),
	    COUNT(DISTINCT LOWER(id::TEXT)),
	    CASE WHEN COUNT(DISTINCT id) = COUNT(DISTINCT LOWER(id::TEXT)) THEN 'Konsisten (Aman)' ELSE 'Tidak Konsisten (Periksa)' END
	FROM customer_satisfaction_and_sentiment_analysis
	
	UNION ALL
	
	SELECT 
	    'Gender',
	    COUNT(DISTINCT "Gender"),
	    COUNT(DISTINCT LOWER("Gender"::TEXT)),
	    CASE WHEN COUNT(DISTINCT "Gender") = COUNT(DISTINCT LOWER("Gender"::TEXT)) THEN 'Konsisten (Aman)' ELSE 'Tidak Konsisten (Periksa)' END
	FROM customer_satisfaction_and_sentiment_analysis
	
	UNION ALL
	
	SELECT 
	    'Customer Type',
	    COUNT(DISTINCT "Customer Type"),
	    COUNT(DISTINCT LOWER("Customer Type"::TEXT)),
	    CASE WHEN COUNT(DISTINCT "Customer Type") = COUNT(DISTINCT LOWER("Customer Type"::TEXT)) THEN 'Konsisten (Aman)' ELSE 'Tidak Konsisten (Periksa)' END
	FROM customer_satisfaction_and_sentiment_analysis
	
	UNION ALL
	
	SELECT 
	    'Age',
	    COUNT(DISTINCT "Age"),
	    COUNT(DISTINCT LOWER("Age"::TEXT)),
	    CASE WHEN COUNT(DISTINCT "Age") = COUNT(DISTINCT LOWER("Age"::TEXT)) THEN 'Konsisten (Aman)' ELSE 'Tidak Konsisten (Periksa)' END
	FROM customer_satisfaction_and_sentiment_analysis
	
	UNION ALL
	
	SELECT 
	    'Type of Travel',
	    COUNT(DISTINCT "Type of Travel"),
	    COUNT(DISTINCT LOWER("Type of Travel"::TEXT)),
	    CASE WHEN COUNT(DISTINCT "Type of Travel") = COUNT(DISTINCT LOWER("Type of Travel"::TEXT)) THEN 'Konsisten (Aman)' ELSE 'Tidak Konsisten (Periksa)' END
	FROM customer_satisfaction_and_sentiment_analysis
	
	UNION ALL
	
	SELECT 
	    'Class',
	    COUNT(DISTINCT "Class"),
	    COUNT(DISTINCT LOWER("Class"::TEXT)),
	    CASE WHEN COUNT(DISTINCT "Class") = COUNT(DISTINCT LOWER("Class"::TEXT)) THEN 'Konsisten (Aman)' ELSE 'Tidak Konsisten (Periksa)' END
	FROM customer_satisfaction_and_sentiment_analysis
	
	UNION ALL
	
	SELECT 
	    'Flight Distance',
	    COUNT(DISTINCT "Flight Distance"),
	    COUNT(DISTINCT LOWER("Flight Distance"::TEXT)),
	    CASE WHEN COUNT(DISTINCT "Flight Distance") = COUNT(DISTINCT LOWER("Flight Distance"::TEXT)) THEN 'Konsisten (Aman)' ELSE 'Tidak Konsisten (Periksa)' END
	FROM customer_satisfaction_and_sentiment_analysis
	
	UNION ALL
	
	SELECT 
	    'Inflight wifi service',
	    COUNT(DISTINCT "Inflight wifi service"),
	    COUNT(DISTINCT LOWER("Inflight wifi service"::TEXT)),
	    CASE WHEN COUNT(DISTINCT "Inflight wifi service") = COUNT(DISTINCT LOWER("Inflight wifi service"::TEXT)) THEN 'Konsisten (Aman)' ELSE 'Tidak Konsisten (Periksa)' END
	FROM customer_satisfaction_and_sentiment_analysis
	
	UNION ALL
	
	SELECT 
	    'Departure/Arrival time convenient',
	    COUNT(DISTINCT "Departure/Arrival time convenient"),
	    COUNT(DISTINCT LOWER("Departure/Arrival time convenient"::TEXT)),
	    CASE WHEN COUNT(DISTINCT "Departure/Arrival time convenient") = COUNT(DISTINCT LOWER("Departure/Arrival time convenient"::TEXT)) THEN 'Konsisten (Aman)' ELSE 'Tidak Konsisten (Periksa)' END
	FROM customer_satisfaction_and_sentiment_analysis
	
	UNION ALL
	
	SELECT 
	    'Ease of Online booking',
	    COUNT(DISTINCT "Ease of Online booking"),
	    COUNT(DISTINCT LOWER("Ease of Online booking"::TEXT)),
	    CASE WHEN COUNT(DISTINCT "Ease of Online booking") = COUNT(DISTINCT LOWER("Ease of Online booking"::TEXT)) THEN 'Konsisten (Aman)' ELSE 'Tidak Konsisten (Periksa)' END
	FROM customer_satisfaction_and_sentiment_analysis
	
	UNION ALL
	
	SELECT 
	    'Gate location',
	    COUNT(DISTINCT "Gate location"),
	    COUNT(DISTINCT LOWER("Gate location"::TEXT)),
	    CASE WHEN COUNT(DISTINCT "Gate location") = COUNT(DISTINCT LOWER("Gate location"::TEXT)) THEN 'Konsisten (Aman)' ELSE 'Tidak Konsisten (Periksa)' END
	FROM customer_satisfaction_and_sentiment_analysis
	
	UNION ALL
	
	SELECT 
	    'Food and drink',
	    COUNT(DISTINCT "Food and drink"),
	    COUNT(DISTINCT LOWER("Food and drink"::TEXT)),
	    CASE WHEN COUNT(DISTINCT "Food and drink") = COUNT(DISTINCT LOWER("Food and drink"::TEXT)) THEN 'Konsisten (Aman)' ELSE 'Tidak Konsisten (Periksa)' END
	FROM customer_satisfaction_and_sentiment_analysis
	
	UNION ALL
	
	SELECT 
	    'Online boarding',
	    COUNT(DISTINCT "Online boarding"),
	    COUNT(DISTINCT LOWER("Online boarding"::TEXT)),
	    CASE WHEN COUNT(DISTINCT "Online boarding") = COUNT(DISTINCT LOWER("Online boarding"::TEXT)) THEN 'Konsisten (Aman)' ELSE 'Tidak Konsisten (Periksa)' END
	FROM customer_satisfaction_and_sentiment_analysis
	
	UNION ALL
	
	SELECT 
	    'Seat comfort',
	    COUNT(DISTINCT "Seat comfort"),
	    COUNT(DISTINCT LOWER("Seat comfort"::TEXT)),
	    CASE WHEN COUNT(DISTINCT "Seat comfort") = COUNT(DISTINCT LOWER("Seat comfort"::TEXT)) THEN 'Konsisten (Aman)' ELSE 'Tidak Konsisten (Periksa)' END
	FROM customer_satisfaction_and_sentiment_analysis
	
	UNION ALL
	
	SELECT 
	    'Inflight entertainment',
	    COUNT(DISTINCT "Inflight entertainment"),
	    COUNT(DISTINCT LOWER("Inflight entertainment"::TEXT)),
	    CASE WHEN COUNT(DISTINCT "Inflight entertainment") = COUNT(DISTINCT LOWER("Inflight entertainment"::TEXT)) THEN 'Konsisten (Aman)' ELSE 'Tidak Konsisten (Periksa)' END
	FROM customer_satisfaction_and_sentiment_analysis
	
	UNION ALL
	
	SELECT 
	    'On-board service',
	    COUNT(DISTINCT "On-board service"),
	    COUNT(DISTINCT LOWER("On-board service"::TEXT)),
	    CASE WHEN COUNT(DISTINCT "On-board service") = COUNT(DISTINCT LOWER("On-board service"::TEXT)) THEN 'Konsisten (Aman)' ELSE 'Tidak Konsisten (Periksa)' END
	FROM customer_satisfaction_and_sentiment_analysis
	
	UNION ALL
	
	SELECT 
	    'Leg room service',
	    COUNT(DISTINCT "Leg room service"),
	    COUNT(DISTINCT LOWER("Leg room service"::TEXT)),
	    CASE WHEN COUNT(DISTINCT "Leg room service") = COUNT(DISTINCT LOWER("Leg room service"::TEXT)) THEN 'Konsisten (Aman)' ELSE 'Tidak Konsisten (Periksa)' END
	FROM customer_satisfaction_and_sentiment_analysis
	
	UNION ALL
	
	SELECT 
	    'Baggage handling',
	    COUNT(DISTINCT "Baggage handling"),
	    COUNT(DISTINCT LOWER("Baggage handling"::TEXT)),
	    CASE WHEN COUNT(DISTINCT "Baggage handling") = COUNT(DISTINCT LOWER("Baggage handling"::TEXT)) THEN 'Konsisten (Aman)' ELSE 'Tidak Konsisten (Periksa)' END
	FROM customer_satisfaction_and_sentiment_analysis
	
	UNION ALL
	
	SELECT 
	    'Checkin service',
	    COUNT(DISTINCT "Checkin service"),
	    COUNT(DISTINCT LOWER("Checkin service"::TEXT)),
	    CASE WHEN COUNT(DISTINCT "Checkin service") = COUNT(DISTINCT LOWER("Checkin service"::TEXT)) THEN 'Konsisten (Aman)' ELSE 'Tidak Konsisten (Periksa)' END
	FROM customer_satisfaction_and_sentiment_analysis
	
	UNION ALL
	
	SELECT 
	    'Inflight service',
	    COUNT(DISTINCT "Inflight service"),
	    COUNT(DISTINCT LOWER("Inflight service"::TEXT)),
	    CASE WHEN COUNT(DISTINCT "Inflight service") = COUNT(DISTINCT LOWER("Inflight service"::TEXT)) THEN 'Konsisten (Aman)' ELSE 'Tidak Konsisten (Periksa)' END
	FROM customer_satisfaction_and_sentiment_analysis
	
	UNION ALL
	
	SELECT 
	    'Cleanliness',
	    COUNT(DISTINCT "Cleanliness"),
	    COUNT(DISTINCT LOWER("Cleanliness"::TEXT)),
	    CASE WHEN COUNT(DISTINCT "Cleanliness") = COUNT(DISTINCT LOWER("Cleanliness"::TEXT)) THEN 'Konsisten (Aman)' ELSE 'Tidak Konsisten (Periksa)' END
	FROM customer_satisfaction_and_sentiment_analysis
	
	UNION ALL
	
	SELECT 
	    'Departure Delay in Minutes',
	    COUNT(DISTINCT "Departure Delay in Minutes"),
	    COUNT(DISTINCT LOWER("Departure Delay in Minutes"::TEXT)),
	    CASE WHEN COUNT(DISTINCT "Departure Delay in Minutes") = COUNT(DISTINCT LOWER("Departure Delay in Minutes"::TEXT)) THEN 'Konsisten (Aman)' ELSE 'Tidak Konsisten (Periksa)' END
	FROM customer_satisfaction_and_sentiment_analysis
	
	UNION ALL
	
	SELECT 
	    'Arrival Delay in Minutes',
	    COUNT(DISTINCT "Arrival Delay in Minutes"),
	    COUNT(DISTINCT LOWER("Arrival Delay in Minutes"::TEXT)),
	    CASE WHEN COUNT(DISTINCT "Arrival Delay in Minutes") = COUNT(DISTINCT LOWER("Arrival Delay in Minutes"::TEXT)) THEN 'Konsisten (Aman)' ELSE 'Tidak Konsisten (Periksa)' END
	FROM customer_satisfaction_and_sentiment_analysis
	
	UNION ALL
	
	SELECT 
	    'satisfaction',
	    COUNT(DISTINCT "satisfaction"),
	    COUNT(DISTINCT LOWER("satisfaction"::TEXT)),
	    CASE WHEN COUNT(DISTINCT "satisfaction") = COUNT(DISTINCT LOWER("satisfaction"::TEXT)) THEN 'Konsisten (Aman)' ELSE 'Tidak Konsisten (Periksa)' END
	FROM customer_satisfaction_and_sentiment_analysis;
	

--4. Melihat variasi Departure Delay pada 300 baris yang NULL:
	SELECT 
	    "Departure Delay in Minutes",
	    COUNT(*) AS jumlah_baris
	FROM customer_satisfaction_and_sentiment_analysis
	WHERE "Arrival Delay in Minutes" IS NULL
	GROUP BY "Departure Delay in Minutes"
	ORDER BY jumlah_baris DESC;
	

/*
 	==================================================
	 			SECTION B: DATA CLEANING
	==================================================
*/

--1. Menghapus Nilai Null pada Kolom Arrival Delay in Minutes 
	DELETE FROM customer_satisfaction_and_sentiment_analysis
	WHERE "Arrival Delay in Minutes" IS NULL;

-- 2. pemeriksaan ulang
	SELECT 
	    'Jumlah Baris' AS "Indikator Pemeriksaan", 
	    (SELECT COUNT(*) FROM customer_satisfaction_and_sentiment_analysis) AS "Jumlah Pemeriksaan"
	
	UNION ALL
	
	SELECT 
	    'Jumlah Kolom', 
	    (SELECT COUNT(*) 
	     FROM information_schema.columns 
	     WHERE table_name = 'customer_satisfaction_and_sentiment_analysis')
	
	UNION ALL
	
	SELECT 
	    'Jumlah Duplikasi', 
	    (SELECT COUNT(*) FROM customer_satisfaction_and_sentiment_analysis) - 
	    (SELECT COUNT(*) FROM (SELECT DISTINCT * FROM customer_satisfaction_and_sentiment_analysis) sub)
	
	UNION ALL
	
	SELECT 
	    'Jumlah Missing Values',
	    (SELECT 
	        (COUNT(*) FILTER (WHERE "Unnamed: 0" IS NULL)) +
	        (COUNT(*) FILTER (WHERE id IS NULL)) +
	        (COUNT(*) FILTER (WHERE "Gender" IS NULL)) +
	        (COUNT(*) FILTER (WHERE "Customer Type" IS NULL)) +
	        (COUNT(*) FILTER (WHERE "Age" IS NULL)) +
	        (COUNT(*) FILTER (WHERE "Type of Travel" IS NULL)) +
	        (COUNT(*) FILTER (WHERE "Class" IS NULL)) +
	        (COUNT(*) FILTER (WHERE "Flight Distance" IS NULL)) +
	        (COUNT(*) FILTER (WHERE "Inflight wifi service" IS NULL)) +
	        (COUNT(*) FILTER (WHERE "Departure/Arrival time convenient" IS NULL)) +
	        (COUNT(*) FILTER (WHERE "Ease of Online booking" IS NULL)) +
	        (COUNT(*) FILTER (WHERE "Gate location" IS NULL)) +
	        (COUNT(*) FILTER (WHERE "Food and drink" IS NULL)) +
	        (COUNT(*) FILTER (WHERE "Online boarding" IS NULL)) +
	        (COUNT(*) FILTER (WHERE "Seat comfort" IS NULL)) +
	        (COUNT(*) FILTER (WHERE "Inflight entertainment" IS NULL)) +
	        (COUNT(*) FILTER (WHERE "On-board service" IS NULL)) +
	        (COUNT(*) FILTER (WHERE "Leg room service" IS NULL)) +
	        (COUNT(*) FILTER (WHERE "Baggage handling" IS NULL)) +
	        (COUNT(*) FILTER (WHERE "Checkin service" IS NULL)) +
	        (COUNT(*) FILTER (WHERE "Inflight service" IS NULL)) +
	        (COUNT(*) FILTER (WHERE "Cleanliness" IS NULL)) +
	        (COUNT(*) FILTER (WHERE "Departure Delay in Minutes" IS NULL)) +
	        (COUNT(*) FILTER (WHERE "Arrival Delay in Minutes" IS NULL)) +
	        (COUNT(*) FILTER (WHERE "satisfaction" IS NULL))
	     FROM customer_satisfaction_and_sentiment_analysis);
	
--3. Mengubah tipe data kolom Arrival Delay in Minutes
	ALTER TABLE customer_satisfaction_and_sentiment_analysis
	ALTER COLUMN "Arrival Delay in Minutes" TYPE int4
	USING "Arrival Delay in Minutes"::int4;


--4. cek Outlier numerikal
	WITH stats AS (
    SELECT 
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY "Age") AS age_q1,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY "Age") AS age_q3,
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY "Flight Distance") AS fd_q1,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY "Flight Distance") AS fd_q3,
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY "Departure Delay in Minutes") AS dd_q1,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY "Departure Delay in Minutes") AS dd_q3,
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY "Arrival Delay in Minutes") AS ad_q1,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY "Arrival Delay in Minutes") AS ad_q3
    FROM customer_satisfaction_and_sentiment_analysis
	)
	SELECT 
	    'Age' AS "Nama Kolom Outlier",
	    COUNT(CASE WHEN "Age" < (age_q1 - 1.5 * (age_q3 - age_q1)) 
	                 OR "Age" > (age_q3 + 1.5 * (age_q3 - age_q1)) THEN 1 END) AS "Jumlah Outlier"
	FROM customer_satisfaction_and_sentiment_analysis, stats
	

	
--5. outlier kategorikal 
	WITH total_data AS (
	    SELECT COUNT(*)::numeric AS total_rows 
	    FROM customer_satisfaction_and_sentiment_analysis
	),
	mode_per_column AS (
	    -- 1. Kategorikal Murni
	    (SELECT 'Gender' AS nama_kolom, "Gender"::text AS nilai_terbesar, COUNT(*) AS jumlah FROM customer_satisfaction_and_sentiment_analysis GROUP BY "Gender" ORDER BY COUNT(*) DESC LIMIT 1)
	    UNION ALL
	    (SELECT 'Customer Type', "Customer Type"::text, COUNT(*) FROM customer_satisfaction_and_sentiment_analysis GROUP BY "Customer Type" ORDER BY COUNT(*) DESC LIMIT 1)
	    UNION ALL
	    (SELECT 'Type of Travel', "Type of Travel"::text, COUNT(*) FROM customer_satisfaction_and_sentiment_analysis GROUP BY "Type of Travel" ORDER BY COUNT(*) DESC LIMIT 1)
	    UNION ALL
	    (SELECT 'Class', "Class"::text, COUNT(*) FROM customer_satisfaction_and_sentiment_analysis GROUP BY "Class" ORDER BY COUNT(*) DESC LIMIT 1)
	    UNION ALL
	    (SELECT 'satisfaction', "satisfaction"::text, COUNT(*) FROM customer_satisfaction_and_sentiment_analysis GROUP BY "satisfaction" ORDER BY COUNT(*) DESC LIMIT 1)
	
	    -- 2. Kategorikal Ordinal (Kolom Rating 0-5)
	    UNION ALL
	    (SELECT 'Inflight wifi service', "Inflight wifi service"::text, COUNT(*) FROM customer_satisfaction_and_sentiment_analysis GROUP BY "Inflight wifi service" ORDER BY COUNT(*) DESC LIMIT 1)
	    UNION ALL
	    (SELECT 'Departure/Arrival time convenient', "Departure/Arrival time convenient"::text, COUNT(*) FROM customer_satisfaction_and_sentiment_analysis GROUP BY "Departure/Arrival time convenient" ORDER BY COUNT(*) DESC LIMIT 1)
	    UNION ALL
	    (SELECT 'Ease of Online booking', "Ease of Online booking"::text, COUNT(*) FROM customer_satisfaction_and_sentiment_analysis GROUP BY "Ease of Online booking" ORDER BY COUNT(*) DESC LIMIT 1)
	    UNION ALL
	    (SELECT 'Gate location', "Gate location"::text, COUNT(*) FROM customer_satisfaction_and_sentiment_analysis GROUP BY "Gate location" ORDER BY COUNT(*) DESC LIMIT 1)
	    UNION ALL
	    (SELECT 'Food and drink', "Food and drink"::text, COUNT(*) FROM customer_satisfaction_and_sentiment_analysis GROUP BY "Food and drink" ORDER BY COUNT(*) DESC LIMIT 1)
	    UNION ALL
	    (SELECT 'Online boarding', "Online boarding"::text, COUNT(*) FROM customer_satisfaction_and_sentiment_analysis GROUP BY "Online boarding" ORDER BY COUNT(*) DESC LIMIT 1)
	    UNION ALL
	    (SELECT 'Seat comfort', "Seat comfort"::text, COUNT(*) FROM customer_satisfaction_and_sentiment_analysis GROUP BY "Seat comfort" ORDER BY COUNT(*) DESC LIMIT 1)
	    UNION ALL
	    (SELECT 'Inflight entertainment', "Inflight entertainment"::text, COUNT(*) FROM customer_satisfaction_and_sentiment_analysis GROUP BY "Inflight entertainment" ORDER BY COUNT(*) DESC LIMIT 1)
	    UNION ALL
	    (SELECT 'On-board service', "On-board service"::text, COUNT(*) FROM customer_satisfaction_and_sentiment_analysis GROUP BY "On-board service" ORDER BY COUNT(*) DESC LIMIT 1)
	    UNION ALL
	    (SELECT 'Leg room service', "Leg room service"::text, COUNT(*) FROM customer_satisfaction_and_sentiment_analysis GROUP BY "Leg room service" ORDER BY COUNT(*) DESC LIMIT 1)
	    UNION ALL
	    (SELECT 'Baggage handling', "Baggage handling"::text, COUNT(*) FROM customer_satisfaction_and_sentiment_analysis GROUP BY "Baggage handling" ORDER BY COUNT(*) DESC LIMIT 1)
	    UNION ALL
	    (SELECT 'Checkin service', "Checkin service"::text, COUNT(*) FROM customer_satisfaction_and_sentiment_analysis GROUP BY "Checkin service" ORDER BY COUNT(*) DESC LIMIT 1)
	    UNION ALL
	    (SELECT 'Inflight service', "Inflight service"::text, COUNT(*) FROM customer_satisfaction_and_sentiment_analysis GROUP BY "Inflight service" ORDER BY COUNT(*) DESC LIMIT 1)
	    UNION ALL
	    (SELECT 'Cleanliness', "Cleanliness"::text, COUNT(*) FROM customer_satisfaction_and_sentiment_analysis GROUP BY "Cleanliness" ORDER BY COUNT(*) DESC LIMIT 1)
	)
	SELECT 
	    m.nama_kolom AS "Nama Kolom",
	    m.nilai_terbesar AS "Nilai Kolom (Terbesar)",
	    m.jumlah AS "Jumlah",
	    TO_CHAR(ROUND((m.jumlah / t.total_rows) * 100, 2), 'FM990.00') || '%' AS "Persentase",
	    CASE 
	        WHEN (m.jumlah / t.total_rows) * 100 > 50 THEN 'Dominasi Kuat (> 50%)'
	        WHEN (m.jumlah / t.total_rows) * 100 >= 30 THEN 'Dominasi Signifikan (Lebih Besar)'
	        ELSE 'Distribusi Merata (Tidak Dominan)'
	    END AS "Status Skenario"
	FROM mode_per_column m, total_data t;