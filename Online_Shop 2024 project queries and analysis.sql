-- Project of online shopping trends ---

-- we will chcek null values for each column , (CRUD) create , read , update , delete . 

select * from customers
	where 		
	customer_id is null
	OR
	first_name is null 
	OR
	last_name is null
	OR
	address is null
	OR
	email is null
	OR
	phone_number is null;
			
select * from order_items
	where 		
	order_item_id is null
	OR
	order_id is null 
	OR
	product_id is null
	OR
	quantity is null
	OR
	price_at_purchase is null;


select * from orders	
	where 		
	order_id is null
	OR
	order_date is null 
	OR
	customer_id is null
	OR
	total_price is null;
	


select * from payment
	where 		
	payment_id is null
	OR
	order_id is null 
	OR
	payment_method is null
	OR
	amount is null
	OR
	transaction_status is null;



select * from products
	where				
	product_id is null
	OR
	product_name is null
	OR
	category  is null
	OR
	price is null
	OR
	supplier_id is null;

	
select * from reviews
where				
	review_id is null
	OR
	product_id is null
	OR
	customer_id  is null
	OR
	rating is null
	OR
	review_text is null
	OR
	review_date is null;


select * from shipments
where				
	shipment_id is null
	OR
	order_id is null
	OR
	shipment_date  is null
	OR
	carrier is null
	OR
	tracking_number is null
	OR
	delivery_date	is null
	OR
	shipment_status is null;
	
	
select * from suppliers
where				
	supplier_id is null
	OR
	supplier_name is null
	OR
	contact_name  is null
	OR
	address is null
	OR
	phone_number	is null
	OR
	email is null;

-- Delete Null values--

delete  from suppliers
where				
	supplier_id is null
	OR
	supplier_name is null
	OR
	contact_name  is null
	OR
	address is null
	OR
	phone_number	is null
	OR
	email is null;

select * from suppliers

-- Data Exploration / data cleaning--

select distinct(product_name) from products


select first_name,
	last_name,
	category,
	price 
	from customers as C1
	join products as P1
	on C1.customer_id = P1.product_id
	where category  = 'Electronics' 
	group by 1,	2,3,4;
	
-- Total_Sale Calculation -- 

select
	product_name,
	sum(total_price)as Total_sale
from orders as o1
join products as p1
on o1.customer_id = p1.product_id
group by product_name;

-- Total credit amount-- 

select sum(amount) as Total_credit_amount
from payment 

--Total cost spend on products--

select distinct(product_name),
	   round(sum(price_at_purchase) as total_cost
from order_items as o
join products as p
on o.product_id = p.product_id
group by product_name;


-- delivery status of products -- 

select 
	  product_name,
	  carrier, 
	  shipment_status
from shipments as s
join products as p
on s.order_id = p.product_id 
group by 1,2,3;

-- products and their ratings and reviews.


select 
	  distinct(p.product_name),  
	  rating,
	  review_text
from products as p
join reviews as r
on p.product_id = r.product_id
group by 1,2,3
order by p.product_name
limit 10;


SELECT
    p.product_name,
    AVG(r.rating) AS avg_rate
FROM products AS p
JOIN reviews AS r
ON p.product_id = r.product_id
GROUP BY p.product_name;

-- products and their customers and their suppliers details.


select			
	  distinct(p.product_name),
	  c.first_name as customer_first_name,
	  c.last_name as customer_last_name,
	  s.supplier_name,
	  s.contact_name as supplier_contact_name,
	  s.address as supplier_address,
	  s.phone_number as supplier_Phone_No,
	  s.email as supplier_email
from suppliers as s
join products as p 
on s.supplier_id = p.supplier_id
join customers as c 
on p.product_id = c.customer_id;

-- count of carrier product deliverd / shipment pending status and thier currier provider with tracking_numbers. 

select 
	  distinct(count(carrier)) as count_carrier,
	  p.product_name,
	  s.shipment_date,
	  s.shipment_status,
	  carrier as carrier_provider,
	  s.tracking_number
from products as p
join shipments as s 
on p.product_id = s.order_id
group by 2,3,4,5,6;


-- Top 10 customers and their spending-- 

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(o.total_price) AS total_spent
FROM customers c
JOIN orders o 
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC
LIMIT 10;

-- Top rated products--

SELECT
    p.product_name,
    AVG(r.rating) AS avg_rating
FROM products p
JOIN reviews r ON p.product_id = r.product_id
GROUP BY p.product_name
ORDER BY avg_rating DESC;

-- Monthly revenue -- 

SELECT
    DATE_TRUNC('month', o.order_date) AS month,
    SUM(o.total_price) AS total_revenue
FROM orders o
GROUP BY month
ORDER BY month;

-- popular payment methods -- 

SELECT
    payment_method,
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_amount
FROM payment
GROUP BY payment_method
ORDER BY total_transactions DESC;

-- Average rating by product category -- 

SELECT
    p.category,
    AVG(r.rating) AS avg_rating
FROM products p
JOIN reviews r ON p.product_id = r.product_id
GROUP BY p.category
ORDER BY avg_rating DESC;














