-- Subquery and Common Table Expression

--1.	Mengurutkan account_id dari terkecil
SELECT 
	*
FROM users
ORDER BY account_id asc

--2.	Mengurutkan account_id berdasarkan umur dari termuda
SELECT 
	min(age),
	max (age) 
FROM users
ORDER BY account_id asc

--3.	memfilter orders from gold users (using CTE)
with gold_users as(
	SELECT 
		*
	FROM users
	where tier = 'gold')

SELECT * FROM gold_users --untuk memanggil kolom gold_users


--4.	menampilkan order yang dilakukan gold_users (inner join tabel order dan user)
with gold_users as(
	SELECT 
		*
	FROM users
	where tier = 'gold')

SELECT orders.*
FROM orders
inner join gold_users on orders.account_id = gold_users.account_id 


--5.	menampilkan aggregat order yang dilakukan gold_users 
-- (gbv = gross booking value or gmv = gross merchandise value)
with gold_users as(
	SELECT 
		*
	FROM users
	where tier = 'gold')

SELECT 
	sum(gbv) as total_gbv_from_gold_users,
	count(distinct.order_id) as total_orders_from_gold_users 
FROM orders
inner join gold_users on orders.account_id = gold_users.account_id 


--6.	menampilkan aggregat order yang dilakukan gold_users menggunakan subquery 'where'
-- (gbv = gross booking value or gmv = gross merchandise value)
with gold_users as(
	SELECT 
		*
	FROM users
	where tier = 'gold')

SELECT 
	sum(gbv) as total_gbv_from_gold_users,
	count(distinct.order_id) as total_orders_from_gold_users 
FROM orders
where orders.account_id in 
	(SELECT 
			account_id 
	FROM users
	where tier = 'gold'
	group by 1) --jaga2 siapa tau ada duplikat


--7.	menampilkan aggregat order yang dilakukan gold_users menggunakan subquery 'where'
-- memanggil tipe order.type = 1 
-- (gbv = gross booking value or gmv = gross merchandise value)
with gold_users as(
	SELECT 
		*
	FROM users
	where tier = 'gold')

SELECT 
	sum(gbv) as total_gbv_from_gold_users,
	count(distinct.order_id) as total_orders_from_gold_users 
FROM orders
where orders.account_id in 
	(SELECT 
		account_id 
	FROM users
	where tier = 'gold' and order.type = 1 -- correlated subquery karena memanggil kolom yang ada
	group by 1) --jaga2 siapa tau ada duplikat | di luar nested subquery


--8.	orders from diamond users aged >=45 and female
-- CTE 1: filter diamond_users
with diamond_users as(
	SELECT 
		*
	FROM users
	where tier = 'diamond'),
--CTE 2: filter age >= 45
	aged_45_users as (
	SELECT
		*
	FROM users
	where age >= 45),
--CTE 3: female users
	female_users as (
	SELECT
		*
	FROM users
	where gender = 'F')
-- inner join ketiga kolom tsb 
SELECT 
	sum(gbv) as total_gbv_from_diamond_users,
	count(distinct.order_id) as total_orders_from_diamond_users 
FROM orders
inner join diamond_users on orders.account_id = diamond_users.account_id 
inner join aged_45_users c on orders.account_id = c.account_id 
inner join female_users d on orders.account_id = d.account_id 


--9.	memanggil row semua data orders pada kasus no.8
with diamond_users as(
	SELECT 
		*
	FROM users
	where tier = 'diamond'),

	aged_45_users as (
	SELECT
		*
	FROM users
	where age >= 45),

	female_users as (
	SELECT
		*
	FROM users
	where gender = 'F')

SELECT 
	orders.*
FROM orders
inner join diamond_users on orders.account_id = diamond_users.account_id 
inner join aged_45_users c on orders.account_id = c.account_id 
inner join female_users d on orders.account_id = d.account_id 

--10.	kasus no.8 menggunakan nested subquery
SELECT 
	sum(gbv) as total_gbv_from_diamond_users,
	count(distinct.order_id) as total_orders_from_diamond_users 
FROM orders
where orders.account_id in 
	(SELECT 
		account_id 
	FROM users
	where tier = 'diamond'
	group by 1)
and orders.account_id in 
	(SELECT 
		account_id 
	FROM users
	where age >= 45
	group by 1)
and orders.account_id in 
	(SELECT 
		account_id 
	FROM users
	where gender = 'F'
	group by 1)
