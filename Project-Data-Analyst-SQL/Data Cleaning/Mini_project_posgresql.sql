/*  									==================================================
											   MINI PROJECT DATA ANALYSIS WITH SQL
										================================================== 
 	Dataset yang digunakan merupakan hasil import dari website kaggle.com bernama Brazilian E-Commerce Public Dataset by Olist yang berekstensi .csv
	jumlah dataset yang digunakan adalah 4 yaitu : olist_customers_dataset, olist_products_dataset, olist_orders_dataset, dan olist_order_items_dataset

	
 
==================================================
SECTION A: DATA EXPLORATION
==================================================
1. Penjelasan & Fungsi Tabel:
   - olist_customers_dataset 
   		Tabel ini memperkenalkan siapa pembelinya dan dari kota mana mereka berasal di seluruh penjuru Brasil. 
   	  Informasi domisili ini menjadi panggung utama untuk melihat seberapa jauh jangkauan pengiriman e-commerce Olist.
   
   - olist_products_dataset  
   		Tabel ini menggambarkan karakter fisik barang yang dipesan, mulai dari kategori, berat, hingga dimensi ukurannya. 
   	 Spesifikasi inilah yang nantinya menentukan seberapa rumit dan mahal proses pengiriman barang tersebut.
   
   - olist_orders_dataset    
   		Tabel ini mencatat jejak waktu perjalanan pesanan sejak tombol beli ditekan hingga paket tiba di tangan pelanggan. 
   	 Dari rantai waktu inilah kita bisa mengukur seberapa cepat atau lambat performa kurir pengiriman.
   
   - olist_order_items_dataset 
   		Tabel ini membedah rincian nilai uang dari setiap barang yang ada di dalam keranjang belanjaan pelanggan. 
   	 Di sinilah kita melihat hubungan langsung antara harga produk, beban ongkos kirim, dan total pendapatan yang dihasilkan.
*/

--2. melihat ketika semua tabel digabungkan

	SELECT 
	    ood.order_id,
	    ood.order_status,
	    ocd.customer_state,
	    ocd.customer_city,
	    ooid.order_item_id,
	    ooid.product_id,
	    opd.product_category_name,
	    opd.product_weight_g,
	    ooid.price,
	    ooid.freight_value
	FROM olist_orders_dataset ood
	JOIN olist_customers_dataset ocd ON ood.customer_id = ocd.customer_id
	JOIN olist_order_items_dataset ooid ON ood.order_id = ooid.order_id
	JOIN olist_products_dataset opd ON ooid.product_id = opd.product_id
	LIMIT 100;
--3. Pemeriksaan jumlah data setiap tabel

	SELECT 'olist_customers_dataset' AS nama_tabel, COUNT(*) AS total_baris FROM olist_customers_dataset
	UNION ALL
	SELECT 'olist_products_dataset' AS nama_tabel, COUNT(*) AS total_baris FROM olist_products_dataset
	UNION ALL
	SELECT 'olist_orders_dataset' AS nama_tabel, COUNT(*) AS total_baris FROM olist_orders_dataset
	UNION ALL
	SELECT 'olist_order_items_dataset' AS nama_tabel, COUNT(*) AS total_baris FROM olist_order_items_dataset;

/*	Hasil Pengamatan
 	jumlah baris pada tabel order_items_dataset lebih banyak daripada tabel olist_orders_dataset dan 
 	pada tabel olist_customers_dataset memiliki jumlah baris yang sama dengan jumlah orders perlu dilakukan pengamatan lanjut 
 	
 */

-- 3. cek duplikasi pada setiap tabel

	SELECT 
	    (SELECT COUNT(order_id) - COUNT(DISTINCT order_id) FROM olist_orders_dataset) AS dup_orders,
	    (SELECT COUNT(customer_id) - COUNT(DISTINCT customer_id) FROM olist_customers_dataset) AS dup_customers,
	    (SELECT COUNT(product_id) - COUNT(DISTINCT product_id) FROM olist_products_dataset) AS dup_products,
	    (
	        SELECT COUNT(*) 
	        FROM (
	            SELECT order_id, order_item_id
	            FROM olist_order_items_dataset
	            GROUP BY order_id, order_item_id
	            HAVING COUNT(*) > 1
	        ) sub
	    ) AS dup_order_items;

/*	Hasil Pengamatan
 	Terdapat duplikasi pada product_id perlu dilakukan pengecekan lebih lanjut 	
 */

-- 4. cek data duplikasi pada tabel olist_products_dataset

	SELECT * 
	FROM olist_products_dataset 
	WHERE product_id IN (
	    SELECT product_id 
	    FROM olist_products_dataset 
	    GROUP BY product_id 
	    HAVING COUNT(*) > 1
	)
	ORDER BY product_id;

/* HASIL PENGAMATAN
 cek lebih lanjut dengan menggabungkan 4 tabel untuk product_ID '1e9e8ef04dbcff4541ed26657ea517e5'
*/

-- 5. Cek ID produk yg duplikasi dengan menghubungkan semua tabel
	SELECT 
	    opd.product_id,
	    opd.product_category_name,
	    ooid.order_id,
	    ooid.order_item_id,
	    ooid.price,
	    ooid.freight_value,
	    ood.order_status,
	    ood.order_purchase_timestamp,
	    ocd.customer_id,
	    ocd.customer_unique_id, 
	    ocd.customer_city,
	    ocd.customer_state
	FROM 
		olist_products_dataset opd
	JOIN 
		olist_order_items_dataset ooid ON ooid.product_id = opd.product_id
	JOIN 
		olist_orders_dataset ood ON ood.order_id = ooid.order_id
	JOIN 
		olist_customers_dataset ocd ON ocd.customer_id = ood.customer_id
	WHERE 
		opd.product_id = '1e9e8ef04dbcff4541ed26657ea517e5';

/* HASIL PENGAMATAN
 terdapat duplikasi pada produk bernama perfumaria akan dilakukan penghapusan salah satunya karena nilainya sama semua pada ke-4 tabel
*/

-- 6. Cek kolom kosong pada setiap tabel

	-- Cek Kolom Kosong pada olist_orders_dataset

	SELECT 
	    'order_id' AS column_name,
	    COUNT(*) FILTER (WHERE order_id IS NULL OR TRIM(order_id::text) IN ('', 'NULL')) AS missing_count
	FROM olist_orders_dataset
	UNION ALL
	SELECT 
	    'customer_id',
	    COUNT(*) FILTER (WHERE customer_id IS NULL OR TRIM(customer_id::text) IN ('', 'NULL'))
	FROM olist_orders_dataset
	UNION ALL
	SELECT 
	    'order_status',
	    COUNT(*) FILTER (WHERE order_status IS NULL OR TRIM(order_status::text) IN ('', 'NULL'))
	FROM olist_orders_dataset
	UNION ALL
	SELECT 
	    'order_purchase_timestamp',
	    COUNT(*) FILTER (WHERE order_purchase_timestamp IS NULL OR TRIM(order_purchase_timestamp::text) IN ('', 'NULL'))
	FROM olist_orders_dataset
	UNION ALL
	SELECT 
	    'order_approved_at',
	    COUNT(*) FILTER (WHERE order_approved_at IS NULL OR TRIM(order_approved_at::text) IN ('', 'NULL'))
	FROM olist_orders_dataset
	UNION ALL
	SELECT 
	    'order_delivered_carrier_date',
	    COUNT(*) FILTER (WHERE order_delivered_carrier_date IS NULL OR TRIM(order_delivered_carrier_date::text) IN ('', 'NULL'))
	FROM olist_orders_dataset
	UNION ALL
	SELECT 
	    'order_delivered_customer_date',
	    COUNT(*) FILTER (WHERE order_delivered_customer_date IS NULL OR TRIM(order_delivered_customer_date::text) IN ('', 'NULL'))
	FROM olist_orders_dataset
	UNION ALL
	SELECT 
	    'order_estimated_delivery_date',
	    COUNT(*) FILTER (WHERE order_estimated_delivery_date IS NULL OR TRIM(order_estimated_delivery_date::text) IN ('', 'NULL'))
	FROM olist_orders_dataset;
	
	-- Cek Kolom Kosong pada olist_customers_dataset
	SELECT 
	    'customer_id' AS column_name,
	    COUNT(*) FILTER (WHERE customer_id IS NULL OR TRIM(customer_id::text) IN ('', 'NULL')) AS missing_count
	FROM olist_customers_dataset
	UNION ALL
	SELECT 
	    'customer_unique_id',
	    COUNT(*) FILTER (WHERE customer_unique_id IS NULL OR TRIM(customer_unique_id::text) IN ('', 'NULL'))
	FROM olist_customers_dataset
	UNION ALL
	SELECT 
	    'customer_zip_code_prefix',
	    COUNT(*) FILTER (WHERE customer_zip_code_prefix IS NULL OR TRIM(customer_zip_code_prefix::text) IN ('', 'NULL'))
	FROM olist_customers_dataset
	UNION ALL
	SELECT 
	    'customer_city',
	    COUNT(*) FILTER (WHERE customer_city IS NULL OR TRIM(customer_city::text) IN ('', 'NULL'))
	FROM olist_customers_dataset
	UNION ALL
	SELECT 
	    'customer_state',
	    COUNT(*) FILTER (WHERE customer_state IS NULL OR TRIM(customer_state::text) IN ('', 'NULL'))
	FROM olist_customers_dataset;
	
	-- Cek Kolom Kosong pada olist_order_items_dataset
	
	SELECT 
	    'order_id' AS column_name,
	    COUNT(*) FILTER (WHERE order_id IS NULL OR TRIM(order_id::text) IN ('', 'NULL')) AS missing_count
	FROM olist_order_items_dataset
	UNION ALL
	SELECT 
	    'order_item_id',
	    COUNT(*) FILTER (WHERE order_item_id IS NULL OR TRIM(order_item_id::text) IN ('', 'NULL'))
	FROM olist_order_items_dataset
	UNION ALL
	SELECT 
	    'product_id',
	    COUNT(*) FILTER (WHERE product_id IS NULL OR TRIM(product_id::text) IN ('', 'NULL'))
	FROM olist_order_items_dataset
	UNION ALL
	SELECT 
	    'seller_id',
	    COUNT(*) FILTER (WHERE seller_id IS NULL OR TRIM(seller_id::text) IN ('', 'NULL'))
	FROM olist_order_items_dataset
	UNION ALL
	SELECT 
	    'shipping_limit_date',
	    COUNT(*) FILTER (WHERE shipping_limit_date IS NULL OR TRIM(shipping_limit_date::text) IN ('', 'NULL'))
	FROM olist_order_items_dataset
	UNION ALL
	SELECT 
	    'price',
	    COUNT(*) FILTER (WHERE price IS NULL OR TRIM(price::text) IN ('', 'NULL'))
	FROM olist_order_items_dataset
	UNION ALL
	SELECT 
	    'freight_value',
	    COUNT(*) FILTER (WHERE freight_value IS NULL OR TRIM(freight_value::text) IN ('', 'NULL'))
	FROM olist_order_items_dataset;
	
	-- Cek Kolom Kosong pada olist_products_dataset
	SELECT 
	    'product_id' AS column_name,
	    COUNT(*) FILTER (WHERE product_id IS NULL OR TRIM(product_id::text) IN ('', 'NULL')) AS missing_count
	FROM olist_products_dataset
	UNION ALL
	SELECT 
	    'product_category_name',
	    COUNT(*) FILTER (WHERE product_category_name IS NULL OR TRIM(product_category_name::text) IN ('', 'NULL'))
	FROM olist_products_dataset
	UNION ALL
	SELECT 
	    'product_name_lenght',
	    COUNT(*) FILTER (WHERE product_name_lenght IS NULL OR TRIM(product_name_lenght::text) IN ('', 'NULL'))
	FROM olist_products_dataset
	UNION ALL
	SELECT 
	    'product_description_lenght',
	    COUNT(*) FILTER (WHERE product_description_lenght IS NULL OR TRIM(product_description_lenght::text) IN ('', 'NULL'))
	FROM olist_products_dataset
	UNION ALL
	SELECT 
	    'product_photos_qty',
	    COUNT(*) FILTER (WHERE product_photos_qty IS NULL OR TRIM(product_photos_qty::text) IN ('', 'NULL'))
	FROM olist_products_dataset
	UNION ALL
	SELECT 
	    'product_weight_g',
	    COUNT(*) FILTER (WHERE product_weight_g IS NULL OR TRIM(product_weight_g::text) IN ('', 'NULL'))
	FROM olist_products_dataset
	UNION ALL
	SELECT 
	    'product_length_cm',
	    COUNT(*) FILTER (WHERE product_length_cm IS NULL OR TRIM(product_length_cm::text) IN ('', 'NULL'))
	FROM olist_products_dataset
	UNION ALL
	SELECT 
	    'product_height_cm',
	    COUNT(*) FILTER (WHERE product_height_cm IS NULL OR TRIM(product_height_cm::text) IN ('', 'NULL'))
	FROM olist_products_dataset
	UNION ALL
	SELECT 
	    'product_width_cm',
	    COUNT(*) FILTER (WHERE product_width_cm IS NULL OR TRIM(product_width_cm::text) IN ('', 'NULL'))
	FROM olist_products_dataset;

/* HASIL PENGAMATAN
 terdapat nilai kolom yang kosong pada tabel olist_orders_dataset antara lain kolom order_approved_at sebanyak 160 baris, 
 kolom order_delivered_carrier_date sebanyak 1783 baris, order_delivered_customer_date sebanyak 2965 baris sisanya tidak ada data yang kosong dan sudah terisi 
 lalu banyak data kosong pada tabel olist_products_dataset
*/

-- 7. cek konsistensi tipe data
	SELECT 
	    table_name, 
	    column_name, 
	    data_type 
	FROM information_schema.columns 
	WHERE table_name IN (
	    'olist_orders_dataset', 
	    'olist_customers_dataset', 
	    'olist_order_items_dataset', 
	    'olist_products_dataset'
	)
	ORDER BY table_name, ordinal_position;

/* HASIL PENGAMATAN
   semua kolom yang berakhiran namanya dengan date bertipe data varchar harus diubah tipe datanya menjadi tanggal
*/

/*		HASIL PENGAMATAN DATA EKSPLORASI
 	Terdapat duplikasi pada tabel olist_products_dataset diperlukan penghapusan salah satu, kemudian terdapat nilai kolom yang kosong pada tabel olist_orders_dataset antara lain 
 	kolom order_approved_at sebanyak 160 baris, kolom order_delivered_carrier_date sebanyak 1783 baris, order_delivered_customer_date sebanyak 2965 baris 
 	sisanya tidak ada data yang kosong dan sudah terisi. Terakhir,semua kolom yang berakhiran namanya dengan date bertipe data varchar harus diubah tipe datanya menjadi tanggal
 
 */

-- 	==================================================
--	 			SECTION B: DATA CLEANING
--	==================================================

-- 1.Menghapus duplikasi
	-- menghapus duplikasi pada tabel olist_products_dataset
	DELETE FROM olist_products_dataset
	WHERE product_id = '1e9e8ef04dbcff4541ed26657ea517e5'
	  AND ctid NOT IN (
	      SELECT MIN(ctid)
	      FROM olist_products_dataset
	      WHERE product_id = '1e9e8ef04dbcff4541ed26657ea517e5'
	  );
	-- cek apakah sudah terhapus dengan baik
		SELECT * 
	FROM olist_products_dataset 
	WHERE product_id = '1e9e8ef04dbcff4541ed26657ea517e5';

/* HASIL PENGAMATAN
   data kolom produt_id sudah tidak lagi yang duplikasi
*/
-- 1.Imputasi pada tabel product

	-- a. Imputasi Kategori Produk Kosong menjadi 'unknown'
	UPDATE olist_products_dataset
	SET product_category_name = 'unknown'
	WHERE product_category_name IS NULL 
	   OR TRIM(product_category_name::text) IN ('', 'NULL');

	-- b. Imputasi Metrik Teks (Length/Photos) dengan Nilai 0
	UPDATE olist_products_dataset
	SET 
	    product_name_lenght = 0,
	    product_description_lenght = 0,
	    product_photos_qty = 0
	WHERE product_category_name = 'unknown';

	-- c. Imputasi 2 Baris Dimensi Fisik dengan Nilai Median Keseluruhan
	UPDATE olist_products_dataset
	SET 
	    product_weight_g = (
	        SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY product_weight_g) 
	        FROM olist_products_dataset WHERE product_weight_g IS NOT NULL
	    ),
	    product_length_cm = (
	        SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY product_length_cm) 
	        FROM olist_products_dataset WHERE product_length_cm IS NOT NULL
	    ),
	    product_height_cm = (
	        SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY product_height_cm) 
	        FROM olist_products_dataset WHERE product_height_cm IS NOT NULL
	    ),
	    product_width_cm = (
	        SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY product_width_cm) 
	        FROM olist_products_dataset WHERE product_width_cm IS NOT NULL
	    )
	WHERE product_weight_g IS NULL OR product_length_cm IS NULL;
	
	-- d. keputusan kolom kosong pada order_approved_at, order_delivered_carrier_date,order_delivered_customer_date
	/*
	 	tidak akan di imputasi karena menandakan barang di cancel atau pesanan dibatalkan atau barang hilang
	 */

-- 2. mengubah tipe data
	--membuat tipe data yang kosong benar-benar kosong
	UPDATE olist_orders_dataset
	SET 
	    order_purchase_timestamp = NULLIF(TRIM(order_purchase_timestamp), ''),
	    order_approved_at = NULLIF(TRIM(order_approved_at), ''),
	    order_delivered_carrier_date = NULLIF(TRIM(order_delivered_carrier_date), ''),
	    order_delivered_customer_date = NULLIF(TRIM(order_delivered_customer_date), ''),
	    order_estimated_delivery_date = NULLIF(TRIM(order_estimated_delivery_date), '');
	-- mengubah tipe data
	ALTER TABLE olist_orders_dataset 
	  ALTER COLUMN order_purchase_timestamp TYPE TIMESTAMP USING order_purchase_timestamp::timestamp,
	  ALTER COLUMN order_approved_at TYPE TIMESTAMP USING order_approved_at::timestamp,
	  ALTER COLUMN order_delivered_carrier_date TYPE TIMESTAMP USING order_delivered_carrier_date::timestamp,
	  ALTER COLUMN order_delivered_customer_date TYPE TIMESTAMP USING order_delivered_customer_date::timestamp,
	  ALTER COLUMN order_estimated_delivery_date TYPE TIMESTAMP USING order_estimated_delivery_date::timestamp;

	-- Konversi 1 kolom tanggal pada olist_order_items_dataset
	ALTER TABLE olist_order_items_dataset 
	  ALTER COLUMN shipping_limit_date TYPE TIMESTAMP USING shipping_limit_date::timestamp;

-- 	3. Membuat Primary key dan Foreign key setiap tabel

	-- a. Primary Key untuk tabel Customers
	ALTER TABLE olist_customers_dataset 
	ADD PRIMARY KEY (customer_id);

	-- b. Primary Key untuk tabel Products
	ALTER TABLE olist_products_dataset 
	ADD PRIMARY KEY (product_id);
	
	-- c. Primary Key untuk tabel Orders
	ALTER TABLE olist_orders_dataset 
	ADD PRIMARY KEY (order_id);
	
	-- d. Primary Key Kombinasi (Composite PK) untuk tabel Order Items
	ALTER TABLE olist_order_items_dataset 
	ADD PRIMARY KEY (order_id, order_item_id);
	
	-- e. Relasi: olist_orders_dataset -> olist_customers_dataset
	ALTER TABLE olist_orders_dataset
	  ADD CONSTRAINT fk_orders_customers 
	  FOREIGN KEY (customer_id) 
	  REFERENCES olist_customers_dataset(customer_id);
	
	-- f. Relasi: olist_order_items_dataset -> olist_orders_dataset
	ALTER TABLE olist_order_items_dataset
	  ADD CONSTRAINT fk_order_items_orders 
	  FOREIGN KEY (order_id) 
	  REFERENCES olist_orders_dataset(order_id);
	
	-- g. Relasi: olist_order_items_dataset -> olist_products_dataset
	ALTER TABLE olist_order_items_dataset
	  ADD CONSTRAINT fk_order_items_products 
	  FOREIGN KEY (product_id) 
	  REFERENCES olist_products_dataset(product_id);
	
--	4. Cek Outlier
	create or replace view outlier as
	WITH 
	-- 1. Stats Price
	stats_price AS (
	    SELECT 
	        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY price) AS q1,
	        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY price) AS q3
	    FROM olist_order_items_dataset
	),
	bounds_price AS (
	    SELECT (q1 - 1.5 * (q3 - q1)) AS lower_bound, (q3 + 1.5 * (q3 - q1)) AS upper_bound
	    FROM stats_price
	),
	
	-- 2. Stats Freight
	stats_freight AS (
	    SELECT 
	        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY freight_value) AS q1,
	        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY freight_value) AS q3
	    FROM olist_order_items_dataset
	),
	bounds_freight AS (
	    SELECT (q1 - 1.5 * (q3 - q1)) AS lower_bound, (q3 + 1.5 * (q3 - q1)) AS upper_bound
	    FROM stats_freight
	),
	
	-- 3. Stats Weight
	stats_weight AS (
	    SELECT 
	        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY product_weight_g) AS q1,
	        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY product_weight_g) AS q3
	    FROM olist_products_dataset
	    WHERE product_weight_g IS NOT NULL
	),
	bounds_weight AS (
	    SELECT (q1 - 1.5 * (q3 - q1)) AS lower_bound, (q3 + 1.5 * (q3 - q1)) AS upper_bound
	    FROM stats_weight
	),
	
	-- 4. Stats Volume
	volume_data AS (
	    SELECT (product_length_cm * product_height_cm * product_width_cm) AS volume_cm3
	    FROM olist_products_dataset
	    WHERE product_length_cm IS NOT NULL 
	      AND product_height_cm IS NOT NULL 
	      AND product_width_cm IS NOT NULL
	),
	stats_volume AS (
	    SELECT 
	        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY volume_cm3) AS q1,
	        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY volume_cm3) AS q3
	    FROM volume_data
	),
	bounds_volume AS (
	    SELECT (q1 - 1.5 * (q3 - q1)) AS lower_bound, (q3 + 1.5 * (q3 - q1)) AS upper_bound
	    FROM stats_volume
	)
	
	-- MAIN QUERY (UNION ALL)
	SELECT 
	    'price' AS nama_kolom_outlier,
	    COUNT(*) AS jumlah_outlier
	FROM olist_order_items_dataset d, bounds_price b
	WHERE d.price < b.lower_bound OR d.price > b.upper_bound
	
	UNION ALL
	
	SELECT 
	    'freight_value' AS nama_kolom_outlier,
	    COUNT(*) AS jumlah_outlier
	FROM olist_order_items_dataset d, bounds_freight b
	WHERE d.freight_value < b.lower_bound OR d.freight_value > b.upper_bound
	
	UNION ALL
	
	SELECT 
	    'product_weight_g' AS nama_kolom_outlier,
	    COUNT(*) AS jumlah_outlier
	FROM olist_products_dataset d, bounds_weight b
	WHERE d.product_weight_g < b.lower_bound OR d.product_weight_g > b.upper_bound
	
	UNION ALL
	
	SELECT 
	    'product_volume_cm3' AS nama_kolom_outlier,
	    COUNT(*) AS jumlah_outlier
	FROM volume_data d, bounds_volume b
	WHERE d.volume_cm3 < b.lower_bound OR d.volume_cm3 > b.upper_bound;

-- 	==================================================
--	 			SECTION C: DATA ANALYSIS
--	==================================================
	
-- 1. Mengetahui ringkasan ongkos kirim pada transaksi terkirim (delivered)
	create or replace view ringkasan_ongkir as
	SELECT 
	    COUNT(DISTINCT ood.order_id) AS total_orders_delivered,
	    COUNT(ooid.order_item_id) AS total_items_delivered,
	    ROUND(MIN(ooid.freight_value)::numeric, 2) AS min_freight,
	    ROUND(MAX(ooid.freight_value)::numeric, 2) AS max_freight,
	    ROUND(AVG(ooid.freight_value)::numeric, 2) AS avg_freight,
	    ROUND(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY ooid.freight_value)::numeric, 2) AS median_freight,
	    ROUND(SUM(ooid.freight_value)::numeric, 2) AS total_freight_value
	FROM olist_order_items_dataset ooid
	JOIN olist_orders_dataset ood ON ooid.order_id = ood.order_id
	WHERE ood.order_status = 'delivered';

-- 2. Melihat outlier ongkir yang sudah terkirim
	CREATE OR REPLACE VIEW outlier_ongkir_terkirim AS
		WITH stats AS (
	    SELECT 
	        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY freight_value) AS q1,
	        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY freight_value) AS q3
	    FROM olist_order_items_dataset
	),
	bounds AS (
	    SELECT 
	        (q3 + 1.5 * (q3 - q1)) AS upper_bound
	    FROM stats
	),
	tagged_orders AS (
	    SELECT 
	        ooid.order_item_id,
	        ooid.freight_value,
	        CASE 
	            WHEN ooid.freight_value > b.upper_bound THEN 'Outlier (Ekstrem)'
	            ELSE 'Reguler (Normal)'
	        END AS kategori_ongkir
	    FROM olist_order_items_dataset ooid
	    JOIN olist_orders_dataset ood ON ooid.order_id = ood.order_id
	    CROSS JOIN bounds b
	    WHERE ood.order_status = 'delivered'
	)
	SELECT 
	    kategori_ongkir,
	    COUNT(*) AS total_items,
	    ROUND((COUNT(*) * 100.0 / SUM(COUNT(*)) OVER()), 2) AS pct_total_items,
	    ROUND(AVG(freight_value)::numeric, 2) AS avg_freight,
	    ROUND(SUM(freight_value)::numeric, 2) AS total_freight_value,
	    ROUND((SUM(freight_value) * 100.0 / SUM(SUM(freight_value)) OVER())::numeric, 2) AS pct_total_freight_cost
	FROM tagged_orders
	GROUP BY kategori_ongkir
	ORDER BY total_freight_value DESC;

-- 3. Melihat 5 kota teratas dengan persentase outllier terbesar

	CREATE OR REPLACE VIEW outlier_ongkir_wilayah AS
	WITH stats AS (
	    SELECT 
	        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY freight_value) AS q1,
	        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY freight_value) AS q3
	    FROM olist_order_items_dataset
	),
	bounds AS (
	    SELECT (q3 + 1.5 * (q3 - q1)) AS upper_bound
	    FROM stats
	),
	base_data AS (
	    SELECT 
	        ocd.customer_state,
	        ooid.freight_value,
	        CASE 
	            WHEN ooid.freight_value > b.upper_bound THEN 1 
	            ELSE 0 
	        END AS is_outlier
	    FROM olist_order_items_dataset ooid
	    JOIN olist_orders_dataset ood ON ooid.order_id = ood.order_id
	    JOIN olist_customers_dataset ocd ON ood.customer_id = ocd.customer_id
	    CROSS JOIN bounds b
	    WHERE ood.order_status = 'delivered'
	),
	aggregated_data AS (
	    SELECT 
	        customer_state,
	        COUNT(*) AS total_items,
	        SUM(is_outlier) AS jumlah_outlier,
	        AVG(freight_value) AS avg_freight,
	        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY freight_value) AS median_freight
	    FROM base_data
	    GROUP BY customer_state
	)
	SELECT 
	    customer_state,
	    total_items,
	    jumlah_outlier,
	    ROUND((jumlah_outlier * 100.0 / total_items)::numeric, 2) AS pct_outlier_rate,
	    ROUND(avg_freight::numeric, 2) AS avg_freight,
	    ROUND(median_freight::numeric, 2) AS median_freight
	FROM aggregated_data
	ORDER BY pct_outlier_rate desc
	limit 5;
	
-- 4. Melihat jenis kategori yang di rondonia dengan ongkir terbsear
	CREATE OR REPLACE VIEW outlier_ongkir_ro AS
	WITH stats AS (
	    SELECT 
	        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY freight_value) AS q1,
	        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY freight_value) AS q3
	    FROM olist_order_items_dataset
	),
	bounds AS (
	    SELECT (q3 + 1.5 * (q3 - q1)) AS upper_bound
	    FROM stats
	),
	base_kategori_ro AS (
	    SELECT 
	        opd.product_category_name,
	        ooid.freight_value,
	        opd.product_weight_g
	    FROM olist_order_items_dataset ooid
	    JOIN olist_orders_dataset ood ON ooid.order_id = ood.order_id
	    JOIN olist_customers_dataset ocd ON ood.customer_id = ocd.customer_id
	    JOIN olist_products_dataset opd ON ooid.product_id = opd.product_id
	    CROSS JOIN bounds b
	    WHERE ood.order_status = 'delivered'
	      AND ocd.customer_state = 'RO' -- Mengerucut khusus RO
	      AND ooid.freight_value > b.upper_bound
	)
	SELECT 
	    COALESCE(product_category_name, 'tidak_didefinisikan') AS kategori_produk,
	    COUNT(*) AS jumlah_outlier,
	    ROUND(AVG(freight_value)::numeric, 2) AS avg_freight_outlier,
	    ROUND(AVG(product_weight_g)::numeric, 0) AS avg_berat_gram
	FROM base_kategori_ro
	GROUP BY product_category_name
	ORDER BY jumlah_outlier desc
	limit 5;

/*		HASIL ANALISA
 * Dari 96.478 pesanan (110.197 barang), total perputaran ongkir mencapai 2.198.350 Reais. 
 * Rata-rata ongkir nasional adalah 19,95 Reais, sementara nilai mediannya 16,26 Reais. 
 * Ongkir tertinggi melonjak hingga 409,68 Reais (lebih dari 20x lipat rata-rata).
 * Di negara bagian Rondônia (RO), dari total 273 barang, sebanyak 167 barang (61,17%) masuk kategori outlier ongkir mahal. 
 * Nilai MEDIAN ongkir di RO membengkak jadi 34,82 Reais (2x lipat dari median nasional yang cuma 16,26 Reais).
 * Top kategori pemicu outlier di RO adalah esporte_lazer (15 transaksi, avg ongkir 44,20 Reais) dan 
 * telefonia (11 transaksi, avg ongkir 41,86 Reais). Padahal rata-rata berat barangnya sangat ringan, 
 * contohnya kategori telefonia hanya 273 gram.
 * 
 * 
 * 
 * 		BUSINESS INSIGHT
 * Rata-rata yang lebih tinggi dari nilai tengah membuktikan adanya transaksi-transaksi ekstrem (outlier) 
 * yang menarik biaya pengiriman ke atas secara signifikan. RO adalah wilayah dengan ketimpangan ongkir paling parah. 
 * Mayoritas transaksi (di atas 60%) di wilayah ini dibebani biaya pengiriman di luar batas wajar nasional.
 * Tingginya ongkir ke RO bukan disebabkan oleh beban/ukuran barang, 
 * melainkan murni masalah jarak dan aksesibilitas pengiriman ke lokasi pembeli. 
 * Barang seringan HP (273 gram) tetap kena ongkir mahal 41,86 Reais.
 * 
 * 		RECOMENDATION
 * 1. Evaluasi Pengiriman Kolektif (Bulk Shipping) via Kargo Mitra
 *  Tim Bisnis disarankan untuk mengevaluasi opsi kerja sama konsinyasi atau bulk shipping dengan mitra kargo di wilayah Utara
 *  untuk top seller (khususnya kategori telefonia), dengan tujuan memotong biaya ongkir eceran jarak jauh tanpa menambah beban
 *  aset fisik milik Olist.
 *  
 * 2. Negosiasi Tarif Khusus (Flat-Rate) Paket Ringan 
 *  Tim Logistik disarankan untuk menjajaki negosiasi skema tarif khusus dengan kurir mitra untuk paket berbobot di bawah 1 kg
 *  ke wilayah Utara (RO, PB, MA), dengan tujuan menekan biaya pengiriman barang ringan seperti telefonia (273 gram) 
 *  yang saat ini rata-rata ongkirnya masih membengkak hingga 41,86 Reais.
 *  
 * 
 * 3. Prioritas Akuisisi Penjual Lokal (Merchant Onboarding)
 *  Tim Merchant Acquisition disarankan memprioritaskan perekrutan seller baru di wilayah RO dan sekitarnya 
 *  untuk kategori esporte_lazer dan telefonia, dengan tujuan memendekkan jarak distribusi sehingga tarif pengiriman ke pembeli 
 *  lokal otomatis turun ke harga standar.   
 *  
*/