--project_Name -- Online Shop 2024--

-- creating customers table --

DROP TABLE IF EXISTS  customers;

create table customers 
	( 
	  customer_id INT primary key,		-- FK
      first_name varchar(20),	
	  last_name	varchar(20),
	  address	varchar(50),
	  email	varchar(50),
	  phone_number varchar(15)
	);

alter table customers
alter column customer_id TYPE  varchar;

-- creating order_items table --

DROP TABLE IF EXISTS  order_items;

create table order_items 
	( 	
	  order_item_id	INT primary key,
	  order_id	    varchar(15), 	-- FK
	  product_id	varchar(20),	-- FK
	  quantity		INT,
	  price_at_purchase	 FLOAT
	 
	);

alter table order_items
alter column order_id  TYPE  INT;

-- creating orders table --

DROP TABLE IF EXISTS  orders;

create table orders
	( 
	
	  order_id  	INT primary key,	-- FK	
	  order_date	DATE,		
	  customer_id	varchar,	-- FK
	  total_price	INT
	 
	);

alter table orders
alter column total_price  TYPE  FLOAT;

alter table orders
alter column order_id   TYPE  varchar(15);

-- creating orders table --

DROP TABLE IF EXISTS  payment;

create table payment
	( 
	  payment_id	INT primary key,	-- Fk
	  order_id		INT,				-- FK		
	  payment_method	varchar(15),				
	  amount	Float,					
	  transaction_status varchar(15)	   	
	
	);

-- creating products table --	

DROP TABLE IF EXISTS  products;

create table products
	( 
	  product_id	INT primary key,	-- FK
	  product_name	varchar(20),	-- FK
	  category		varchar(25),	
	  price			float,			
	  supplier_id	varchar(10)
	
	);

alter table products
alter column product_name type varchar(40)

alter table products
alter column product_id type varchar(20)

-- creating reviews table --	

DROP TABLE IF EXISTS  reviews;

create table reviews
	( 
		
		review_id	INT primary key,
		product_id	varchar(20),		
		customer_id	varchar(20),
		rating	INT,
		review_text	varchar(70),
		review_date	DATE

	);


-- creating shipments table --	

DROP TABLE IF EXISTS  shipments;

create table shipments
	( 		
	  shipment_id	INT primary key,
	  order_id		INT,				
	  shipment_date	DATE,		
	  carrier		varchar(15),
	  tracking_number	varchar(15),
	  delivery_date		DATE,
	  shipment_status	varchar(15)
	
	);

-- creating suppliers table --	

DROP TABLE IF EXISTS  suppliers;

create table suppliers
	( 
	
	 supplier_id	INT primary key,  
	 supplier_name	varchar(60),
	 contact_name	varchar(40),		
	 address		varchar(70),	
	 phone_number	varchar(20),		
	 email			varchar(50)

	);


-- Foreign Key --

-- Add foreign key for 'order_id' in 'order_items'

ALTER TABLE order_items
ADD CONSTRAINT fk_order
FOREIGN KEY (order_id) REFERENCES orders(order_id);

-- Add foreign key for 'product_id' in 'order_items'

ALTER TABLE order_items
ADD CONSTRAINT fk_product
FOREIGN KEY (product_id) REFERENCES products(product_id);


-- Add foreign key for 'customers' in 'orders'

ALTER TABLE orders
ADD CONSTRAINT fk_customers
FOREIGN KEY (customer_id) REFERENCES customers(customer_id);

-- Add foreign key for 'payment' in 'products'

alter table products
Add constraint payment
foreign key (product_id) REFERENCES payment(product_id);

-- Add foreign key for 'rder_items_product' in 'order_items'

ALTER TABLE order_items
ADD CONSTRAINT fk_order_items_product
FOREIGN KEY (product_id) REFERENCES products(product_id);

-- Add foreign key for 'products' in 'reviews'

ALTER TABLE reviews
ADD CONSTRAINT fk_reviews_product
FOREIGN KEY (product_id) REFERENCES products(product_id);

-- Add foreign key for 'customers' in 'reviews'

ALTER TABLE reviews
ADD CONSTRAINT fk_reviews_customer
FOREIGN KEY (customer_id) REFERENCES customers(customer_id);

-- Add foreign key for 'suppliers' in 'products'

ALTER TABLE products
ADD CONSTRAINT fk_products_supplier
FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id);

ALTER TABLE products
ALTER COLUMN supplier_id TYPE INTEGER USING supplier_id::INTEGER;

-- Add foreign key for 'fk_shipments_order' in 'shipments'

ALTER TABLE shipments
ADD CONSTRAINT fk_shipments_order
FOREIGN KEY (order_id) REFERENCES orders(order_id);


ALTER TABLE shipments
ALTER COLUMN order_id TYPE VARCHAR(15) USING order_id::VARCHAR;


ALTER TABLE payment
ADD CONSTRAINT fk_payment_order
FOREIGN KEY (order_id) REFERENCES orders(order_id);

ALTER TABLE payment
ALTER COLUMN order_id TYPE VARCHAR(15) USING order_id::VARCHAR;








