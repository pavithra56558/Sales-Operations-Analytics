-- 1. Create and select the database
CREATE DATABASE IF NOT EXISTS sales_analytics_db;
USE sales_analytics_db;

-- 2. Create the customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    signup_date DATETIME,
    state VARCHAR(10),
    acquisition_channel VARCHAR(50)
);

-- 3. Create the products table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(150),
    category_new VARCHAR(50),
    list_price DECIMAL(10,2),
    unit_cost DECIMAL(10,2)
);

-- 4. Create the orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    status VARCHAR(20),
    payment_method VARCHAR(50),
    discount_code VARCHAR(50),
    shipping_fee DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 5. Create the order_item table
CREATE TABLE order_item (
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price_new DECIMAL(10,2),
    discount_amount DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
DROP TABLE orders;
ALTER TABLE orders 
MODIFY order_date DATE;
SELECT * FROM orders;
DESCRIBE orders;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    signup_date VARCHAR(50),  -- Changed DATETIME to VARCHAR to accept '21/10/2025'
    state VARCHAR(10),
    acquisition_channel VARCHAR(50)
);
-- 1. Turn off foreign key safety checks
SET FOREIGN_KEY_CHECKS = 0;

-- 2. Drop the customers table
DROP TABLE IF EXISTS customers;

-- 3. Re-create customers table with signup_date as VARCHAR
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    signup_date VARCHAR(50),
    state VARCHAR(10),
    acquisition_channel VARCHAR(50)
);

-- 4. Turn foreign key safety checks back on
SET FOREIGN_KEY_CHECKS = 1;
UPDATE customers 
SET signup_date = STR_TO_DATE(signup_date, '%d/%m/%Y');

ALTER TABLE customers 
MODIFY COLUMN signup_date DATETIME;
-- Disable Foreign Key checks temporarily
SET FOREIGN_KEY_CHECKS = 0;

-- Drop orders table if it exists
DROP TABLE IF EXISTS orders;

-- Create orders table with order_date as VARCHAR
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date VARCHAR(50),  -- Set to VARCHAR for smooth CSV import
    status VARCHAR(20),
    payment_method VARCHAR(50),
    discount_code VARCHAR(50),
    shipping_fee DECIMAL(10,2)
);

-- Re-enable Foreign Key checks
SET FOREIGN_KEY_CHECKS = 1;
-- Convert string 'DD/MM/YYYY HH:MM:SS' or 'DD/MM/YYYY HH:MM' to MySQL DATE format
UPDATE orders 
SET order_date = STR_TO_DATE(order_date, '%d/%m/%Y %H:%i:%s');

-- Modify column data type to DATETIME
ALTER TABLE orders 
MODIFY COLUMN order_date DATETIME;
UPDATE orders 
SET order_date = STR_TO_DATE(order_date, '%d/%m/%Y %H:%i:%s')
WHERE order_id > 0;

ALTER TABLE orders 
MODIFY COLUMN order_date DATETIME;
ALTER TABLE orders
ADD CONSTRAINT fk_orders_customers
FOREIGN KEY (customer_id) REFERENCES customers(customer_id);
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    signup_date VARCHAR(50),  -- Allows text like '01/06/2025' without crashing
    state VARCHAR(10),
    acquisition_channel VARCHAR(50)
);

SET FOREIGN_KEY_CHECKS = 1;
-- vv
SET SQL_SAFE_UPDATES = 0;

-- Convert string date to MySQL date format
UPDATE customers 
SET signup_date = STR_TO_DATE(signup_date, '%d/%m/%Y');

-- Change column data type back to DATETIME
ALTER TABLE customers 
MODIFY COLUMN signup_date DATETIME;

SET SQL_SAFE_UPDATES = 1;
-- bb
SET FOREIGN_KEY_CHECKS = 0;

-- 1. Create products table
DROP TABLE IF EXISTS products;
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(150),
    category_new VARCHAR(50),
    list_price DECIMAL(10,2),
    unit_cost DECIMAL(10,2)
);

-- 2. Create orders table with VARCHAR date to prevent import errors
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date VARCHAR(50),
    status VARCHAR(20),
    payment_method VARCHAR(50),
    discount_code VARCHAR(50),
    shipping_fee DECIMAL(10,2)
);

-- 3. Create order_item table
DROP TABLE IF EXISTS order_item;
CREATE TABLE order_item (
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price_new DECIMAL(10,2),
    discount_amount DECIMAL(10,2)
);

SET FOREIGN_KEY_CHECKS = 1;
-- h
SET SQL_SAFE_UPDATES = 0;

-- 1. Convert order_date string to DATETIME
UPDATE orders 
SET order_date = STR_TO_DATE(order_date, '%d/%m/%Y %H:%i:%s');

ALTER TABLE orders 
MODIFY COLUMN order_date DATETIME;

SET SQL_SAFE_UPDATES = 1;

-- 2. Add Foreign Key constraints across tables
ALTER TABLE orders
ADD CONSTRAINT fk_orders_customers
FOREIGN KEY (customer_id) REFERENCES customers(customer_id);

ALTER TABLE order_item
ADD CONSTRAINT fk_orderitem_orders
FOREIGN KEY (order_id) REFERENCES orders(order_id);

ALTER TABLE order_item
ADD CONSTRAINT fk_orderitem_products
FOREIGN KEY (product_id) REFERENCES products(product_id);
-- i
SELECT 'customers' AS table_name, COUNT(*) AS total_rows FROM customers
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_item', COUNT(*) FROM order_item;
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM  order_item;
USE sales_analytics_db;
SELECT COUNT(*) AS TOTAL,
COUNT(customer_id) AS CUS,
COUNT(signup_date) AS DAT,
COUNT(acquisition_channel) AS CHAL
FROM customers;
SELECT 
    COUNT(*) AS total_rows,
    COUNT(customer_id) AS valid_ids,
    COUNT(signup_date) AS valid_dates,
    COUNT(acquisition_channel) AS valid_channels
FROM customers;
SELECT 
    COUNT(*) AS total_rows,
    COUNT(order_id) AS valid_orders,
    COUNT(customer_id) AS valid_customers,
    COUNT(order_date) AS valid_dates,
    COUNT(status) AS valid_statuses,
    COUNT(discount_code) AS orders_with_discount
FROM orders;
SELECT discount_code, COUNT(*) AS occurrences
FROM orders
GROUP BY discount_code;
SELECT discount_code
FROM orders
WHERE discount_code IS NULL;
SELECT coalesce(discount_code , "NO DISCOUNT") AS FINAL
FROM orders;
UPDATE orders
SET discount_code = "NO DISCOUNT"
WHERE discount_code IS NULL;
UPDATE orders 
SET discount_code = 'No Discount' 
WHERE discount_code IS NULL;
UPDATE orders
SET discount_code=(SELECT AVG(discount_code) AS AVV FROM orders WHERE discount_code IS NOT NULL)
WHERE discount_code IS NULL;
SELECT discount_code, COUNT(*) AS occurrences
FROM orders
GROUP BY discount_code;
SET SQL_SAFE_UPDATES = 0;
UPDATE orders
SET discount_code = NULL
WHERE TRIM(discount_code) = '';
SET SQL_SAFE_UPDATES = 1;
SELECT discount_code FROM orders;
SELECT COUNT(*) ,
COUNT(discount_code) AS DIS
FROM orders;
SELECT discount_code , COUNT(*) AS Total
FROM orders
GROUP BY 1;
SELECT coalesce(discount_code , "NO DISCOUNT") AS OCCURENCES
FROM  orders;
SELECT discount_code FROM orders;
UPDATE orders
SET discount_code= "NO DISCOUNT"
WHERE discount_code IS NULL;
SET SQL_SAFE_UPDATES=0;
SET SQL_SAFE_UPDATES=1;
SELECT discount_code FROM orders;
SELECT 
    customer_id 
FROM customers
WHERE customer_id>1;
SELECT customer_id , COUNT(*) AS Total_Customer
FROM customers
GROUP BY 1
HAVING Total_Customer>1;
SELECT 
    order_id, 
    COUNT(*) AS total_occurrences
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;
DELETE FROM orders
WHERE order_id IN(
SELECT order_id 
FROM(
SELECT order_id,
ROW_NUMBER() OVER(partition by order_id ORDER BY order_date)AS row_num
FROM orders
 ) duplicate
 WHERE row_num>1);
 UPDATE customers
 SET acquisition_channel=TRIM(LOWER(acquisition_channel));
 SELECT 
    acquisition_channel, 
    COUNT(*) AS total_customers
FROM customers
GROUP BY acquisition_channel
ORDER BY total_customers DESC;
SELECT * 
FROM order_item
WHERE quantity <= 0 
   OR unit_price_new <= 0;

-- Which marketing channel brings in the best customers?
SELECT c.acquisition_channel,
COUNT(DISTINCT c.customer_id) AS total_customers,
COUNT(DISTINCT o.order_id) AS total_orders,
SUM(oi.quantity * oi.unit_price_new - oi.discount_amount)AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id=o.customer_id
JOIN order_item oi ON o.order_id=oi.order_id
WHERE o.status = 'completed'
GROUP BY 1
ORDER BY total_revenue DESC;
SELECT DISTINCT discount_code
FROM orders;
SELECT 
CASE
WHEN o.discount_code ='NO DISCOUNT' THEN 'NO DISCOUNT'
ELSE 'Discount Used' 
END AS promotion_type,
COUNT( DISTINCT o.order_id) AS total_orders,
ROUND(SUM(oi.quantity * oi.unit_price_new - oi.discount_amount),0) AS total_revenue,
ROUND(AVG(oi.quantity * oi.unit_price_new - oi.discount_amount),0) AS avg_order_value
FROM orders o
JOIN order_item oi ON o.order_id = oi.order_id
WHERE o.status = 'completed'
GROUP BY 1
ORDER BY 1 DESC;
-- Profit Margin by Product Category
SELECT p.category_new,
 SUM(oi.quantity *oi.unit_price_new - oi.discount_amount) AS total_revenue,
ROUND(SUM(oi.quantity * p.unit_cost), 2) AS total_cost,
ROUND(SUM(oi.quantity * (oi.unit_price_new - oi.discount_amount) - (oi.quantity * p.unit_cost)), 2) AS total_profit,
ROUND((SUM(oi.quantity * (oi.unit_price_new - oi.discount_amount) - (oi.quantity * p.unit_cost)) / SUM(oi.quantity * (oi.unit_price_new - oi.discount_amount))) * 100, 2) AS profit_margin_percent
FROM order_item oi
JOIN products p
ON oi.product_id = p.product_id
JOIN orders o 
    ON oi.order_id = o.order_id
WHERE o.status = 'completed'
GROUP BY 1
ORDER BY total_profit DESC;
SELECT * FROM products;
SELECT * FROM order_item;
SELECT 
    p1.product_name AS product_A,
    p2.product_name AS product_B,
    COUNT(*) AS times_bought_together
FROM order_item oi1
JOIN order_item oi2 
    ON oi1.order_id = oi2.order_id 
   AND oi1.product_id < oi2.product_id
JOIN products p1 
    ON oi1.product_id = p1.product_id
JOIN products p2 
    ON oi2.product_id = p2.product_id
JOIN orders o 
    ON oi1.order_id = o.order_id
WHERE o.status = 'completed'
GROUP BY product_A, product_B
ORDER BY times_bought_together DESC
LIMIT 5;
SELECT 
    o.status,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.quantity * oi.unit_price_new - oi.discount_amount), 2) AS total_value,
    ROUND(
        (SUM(oi.quantity * oi.unit_price_new - oi.discount_amount) / 
        (SELECT SUM(oi2.quantity * oi2.unit_price_new - oi2.discount_amount) FROM order_item oi2)) * 100, 
        2
    ) AS percent_of_total_revenue
FROM orders o
JOIN order_item oi 
    ON o.order_id = oi.order_id
GROUP BY o.status
ORDER BY total_value DESC;
SELECT o.status,
COUNT( o.order_id) AS total_orders,
ROUND(SUM(oi.quantity * oi.unit_price_new - oi.discount_amount), 2) AS total_value,
    ROUND(
        (SUM(oi.quantity * oi.unit_price_new - oi.discount_amount) / 
        (SELECT SUM(oi2.quantity * oi2.unit_price_new - oi2.discount_amount) FROM order_item oi2)) * 100, 
        2
    ) AS percent_of_total_revenue
    FROM orders o
    JOIN order_item oi ON o.order_id = oi.order_id
    GROUP BY 1
    ORDER BY total_value DESC;
SELECT DISTINCT shipping_fee FROM orders;
SELECT CASE 
WHEN o.shipping_fee = 0 THEN 'Free Shipping'
ELSE 'Paid Shipping'
END AS shipping_type,
COUNT(DISTINCT o.order_id) AS total_orders,
ROUND(SUM(oi.quantity * oi.unit_price_new - oi.discount_amount),0) AS total_revenue,
ROUND(
        SUM(oi.quantity * oi.unit_price_new - oi.discount_amount) / COUNT(DISTINCT o.order_id), 
        2
    ) AS avg_order_value
    FROM orders o
    JOIN order_item oi
    ON o.order_id = oi.order_id
    WHERE o.status = 'completed'
    GROUP BY 1;
    
    SELECT 
    ROUND(AVG(DATEDIFF(first_order_date, signup_date)), 1) AS avg_days_to_first_purchase,
    MIN(DATEDIFF(first_order_date, signup_date)) AS min_days,
    MAX(DATEDIFF(first_order_date, signup_date)) AS max_days
FROM (
    SELECT 
        c.customer_id,
        c.signup_date,
        MIN(o.order_date) AS first_order_date
    FROM customers c
    JOIN orders o 
        ON c.customer_id = o.customer_id
    WHERE o.status = 'completed'
    GROUP BY c.customer_id, c.signup_date
) customer_first_orders;
-- Query 7: Time-to-First-Purchase
SELECT
AVG(datediff(first_order_date , signup_date))AS avg_days_to_first_purchase,
MIN(datediff(first_order_date , signup_date))AS min_days,
MAX(datediff(first_order_date , signup_date)) AS max_days
FROM (
SELECT c.customer_id,
        c.signup_date,
        MIN(o.order_date) AS first_order_date
        FROM customers c
        JOIN orders o 
        ON c.customer_id = o.customer_id
    WHERE o.status = 'completed'
    GROUP BY c.customer_id, c.signup_date
) customer_first_orders;

SELECT 
    order_count_bucket,
    COUNT(customer_id) AS total_customers,
    ROUND((COUNT(customer_id) / (SELECT COUNT(DISTINCT customer_id) FROM customers)) * 100, 2) AS percent_of_total_customers
FROM (
    SELECT 
        c.customer_id,
        COUNT(o.order_id) AS order_count,
        CASE 
            WHEN COUNT(o.order_id) = 0 THEN '0 Orders (No Purchase)'
            WHEN COUNT(o.order_id) = 1 THEN '1 Order (One-time)'
            WHEN COUNT(o.order_id) = 2 THEN '2 Orders'
            WHEN COUNT(o.order_id) = 3 THEN '3 Orders'
            ELSE '4+ Orders (Loyal)'
        END AS order_count_bucket
    FROM customers c
    LEFT JOIN orders o 
        ON c.customer_id = o.customer_id AND o.status = 'completed'
    GROUP BY c.customer_id
) customer_order_counts
GROUP BY order_count_bucket
ORDER BY total_customers DESC;