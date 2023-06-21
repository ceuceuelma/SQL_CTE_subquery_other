-- Union & Union All, Intersect, Command Except, Case Statement

--1.	UNION, jumlah kolom harus sama
	-- SELECT 
	-- 	*
	-- FROM users
	-- where age = 30
	-- UNION ALL-- gabisa di-run karna jumlah kolomnya beda
	-- SELECT*
	-- FROM orders
SELECT 
	*
FROM users
where age = 30
UNION ALL 
SELECT 
	*
FROM users --jumlah row users.age = 30 akan ditambah dengan * users

SELECT 
	*
FROM users
where age = 30
UNION DISTINCT 
SELECT 
	*
FROM users --jumlah row users tetap, karena users.age = 30 sudah ada di dalam tabel users


--2.	EXCEPT, jumlah kolom harus sama
SELECT 
	*
FROM orders
EXCEPT DISTINCT
SELECT 
	*
FROM orders
where gbv > 100

-- Same with:
SELECT 
	*
FROM orders
where gbv <= 100

--	menampilkan user yang diatas 30 tetapi meng-exclude yang gbv >100
SELECT 
	account_id 
FROM users
where age > 30
group by 1
EXCEPT DISTINCT
SELECT 
	account_id 
FROM orders
where gbv > 100
group by 1


--3.	INTERSECT, jumlah kolom harus sama
-- menampilkan IRISAN user2 yang berbelanja tipe 5 dan berumur antara 18 hingga 25 
SELECT 
	account_id 
FROM users
where type = 5
group by 1
INTERSECT DISTINCT
SELECT 
	account_id 
FROM users
where age between 18 and 25
group by 1

-- 4. CASE STATEMENT, melabel suatu kolom menjadi kolom baru
-- melabeli kolom tipe
SELECT 
	*,
	case 
		when type = 1 then 'marketplace'
		when type = 2 then 'paket_data'
		when type = 3 then 'food_delivery'
		when type = 4 then 'vouchers'
		when type = 5 then 'tickets'
		when type = 7 then 'concert'
		when type = 8 then 'transportations' --atau else'transportations'
	end as order_type
FROM orders

-- melabeli kolom tipe dan transform
SELECT 
	*,
	case 
		when type = 1 then 'marketplace'
		when type = 2 then 'paket_data'
		when type = 3 then 'food_delivery'
		when type = 4 then 'vouchers'
		when type = 5 then 'tickets'
		when type = 7 then 'concert'
		when type = 8 then 'transportations' --atau else'transportations'
	end as order_type
	case 
		when platform = 1 then 'android'
		when platform = 2 then 'apple'
		when platform = 3 then 'pc'
		else 'blackberry'
	end as platform_type
FROM orders

-- label user berdasarkan tier dan umur
SELECT 
	*,
	case
		when tier = 'bronze' and age < 30 then 'baby_users'
		when tier = 'bronze' and age >= 30 then 'newbie_users'
		when tier = 'silver' and age < 30 then 'rising_star'
		when tier = 'silver' and age >= 30 then 'rock_star'
		when tier = 'gold' and age < 30 then 'wonderkid'
		when tier = 'gold' and age >= 30 then 'superstar'
		when tier = 'diamond' then 'world_class'
	end as user_label
FROM users

-- menampilkan user 'wonderkid'
with user_final as (
SELECT 
	*,
	case
		when tier = 'bronze' and age < 30 then 'baby_users'
		when tier = 'bronze' and age >= 30 then 'newbie_users'
		when tier = 'silver' and age < 30 then 'rising_star'
		when tier = 'silver' and age >= 30 then 'rock_star'
		when tier = 'gold' and age < 30 then 'wonderkid'
		when tier = 'gold' and age >= 30 then 'superstar'
		when tier = 'diamond' then 'world_class'
	end as user_label
FROM users)

SELECT
	*
FROM user_final
where user_label = 'wonderkid'