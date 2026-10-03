

CREATE DATABASE Ecommerce;
USE Ecommerce;
CREATE TABLE customers (
	customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,
    phone_number VARCHAR(15) NOT NULL
);

select * from customers;

INSERT INTO customers (customer_name, city, state, email, phone_number) VALUES
('Ushodaya', 'Banglore', 'Karnataka', 'ushodayanamala9@gmail.com', '8919181773'),
('Daya', 'Mysore', 'Karnataka', 'dayareddy3@gmail.com', '0123456789'),
('Chinni', 'Chennai', 'TamilNadu', 'chinnireddy9@gmail.com', '1234567890'),
('Deepu', 'Hydrebad', 'Telangana', 'deepuch19@gmail,com', '1209876435'),
('Nikki', 'Tirupathi', 'Andhra Pradesh', 'nikkireddy@gmail.com', '3478962109'),
('Nikhil', 'Tirupathi', 'Andhra Pradesh', 'nikhil237@gmail.com', '29864901278'),
('Chinna', 'Tadipatri', 'Andhra Pradesh', 'chinnareddy@gmail.com', '9491139613'),
('Gnana', 'Tadipatri', 'Bihar', 'gnanareddy@gmail.com', '28374590218'),
('Chervi', 'Ananthapur', 'Andhra', 'chervireddy@gmail.com', '84926926800'),
('Nittu', 'Ananthapur', 'Andhra', 'nittureddy@gmail.com', '894642997589'),
('sai', 'Gudur', 'Andhra Pradesh', 'saipriya@gmail.com', '023654595100'),
('vihas', 'Nandhyal', 'Andhra Pradesh', 'vihasreddy@gmail.com', '02646926927'),
('Rishi', 'Dharmavaram', 'Kerala', 'rishi2818@gmail.com', '7093830092'),
('Akhil', 'Kadapa', 'Madhya Pradesh', 'akhil1828@gmail.com', '9014013171'),
('kavya', 'Mysore', 'Karnataka', 'kavyakarna@gmail.com', '010710370270');

SELECT * FROM customers;
SHOW TABLES;
DROP DATABASE products;
CREATE DATABASE products;
USE products;
CREATE TABLE products(
	product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL
);


INSERT INTO products (product_name, category, price, stock) VALUES
('Laptop', 'Electronics', 70000, 10),
('Mobile', 'Electronics', 20000, 3),
('T-shirst', 'Clothing', 1016, 20), 
('Jeans', 'Clothing', 2000, 18),
('Board Games', 'Toys&Games', 100, 10),
('cricket Bat', 'Sports', 2499, 12),
('Education', 'Books', 399, 50),
('Snacks', 'Grocery', 55, 80),
('Dairy', 'Grocery', 34, 100),
('Skincare', 'Beauty&PersonalCare', 599, 120),
('Appliances', 'Home&kitchen', 899, 20),
('Cookware', 'Home&kitchen', 799, 25),
('Fitness Equipment', 'Sports', 3999, 14),
('Puzzles', 'Toys&Games', 599, 20),
('Comics', 'Books', 399, 100);

SELECT * FROM products;

SELECT product_name , category FROM products
WHERE category = 'Electronics';

SELECT product_name, price 
FROM products
WHERE price BETWEEN 1000 AND 4000;

SELECT product_name, category 
FROM products
WHERE category IN ('Grocery', 'Books');


SELECT MAX(price) FROM products;

SELECT MIN(stock) FROM products;

SELECT SUM(price) FROM products;

SELECT product_name, price From products
ORDER BY price DESC;

SELECT product_name, stock 
FROM products
ORDER BY stock ASC;
    
SELECT AVG(price) FROM products;

DROP DATABASE orders;
CREATE DATABASE orders;
USE orders;
CREATE TABLE orders(
	order_id INT PRIMARY KEY ,
    customer_id INT ,
    order_date DATE ,
    order_status VARCHAR(30) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO orders (order_id, order_date, order_status) VALUES
(101, '2026-08-09', 'Delivered'),
(102, '2026-09-02', 'Shipping'),
(103, '2025-12-02', 'Cancelled'),
(104, '2024-11-24', 'Processing'),
(105, '2025-12-14', 'Delivered');

CREATE TABLE order_items (
	order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
    
INSERT INTO order_items (order_item_id, quantity) VALUES
(301, 200),
(302, 200),
(303, 150),
(304, 100),
(305, 215);


CREATE TABLE payment (
	payment_id INT PRIMARY KEY,
    order_id INT,
    payment_method VARCHAR(50),
    payment_amount DECIMAL(10,2),
    payment_status VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);
    
INSERT INTO payment (payment_id, payment_method, payment_amount, payment_status) VALUES
(201, 'Credit Card', 1000, 'Success'),
(202, 'UPI', 2999, 'Refund'),
(203, 'Debit Card', 3999, 'Failure'),
(204, 'Cash on Delivery', 499, 'Success'),
(205, 'Credit Card', 1100, 'Failure');

SHOW TABLES;


SELECT c.customer_id,o.order_id FROM customers C JOIN orders O ON c.customer_id = o.customer_id; 


#ORDER DETAILS WITH PRICE
SELECT o.order_id, c.customer_name, p.product_name, oi.quantity, p.price, o.order_date, o.order_status
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id;

#CALCULATE ITEM VALUES
#Iem value = quantity * price
SELECT oi.order_item_id, o.order_id, p.product_name, oi.quantity, p.price, oi.quantity * p.price AS item_value
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN products p ON oi.product_id = p.product_id;

#Calculate order value
SELECT o.order_id, SUM(oi.quantity * p.price) AS order_value
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id 
GROUP BY o.order_id; 

#Total product revenue
SELECT SUM(oi.quantity * p.price) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id;

#Revenue by product
SELECT p.product_id, p.product_name, SUM(oi.quantity * p.price) AS revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name ORDER BY revenue DESC;

#Quantity sold by product
SELECT p.product_id, p.product_name, SUM(oi.quantity) AS quantity_sold
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY quantity_sold DESC;

#Top selling product
SELECT p.product_id, p.product_name, SUM(oi.quantity) AS quantity_sold
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY quantity_sold DESC
LIMIT 1;

#Customer purchase details
SELECT c.customer_id, c.customer_name, o.order_id, o.order_date, p.product_name, oi.quantity, p.price, oi.quantity * p.price AS item_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
ORDER BY c.customer_id;  

#Customer who never ordered
SELECT c.customer_id, c.customer_name, c.city, c.state
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL; 


#BUSINESS REPORTS
#Total products
SELECT COUNT(*) AS total_products
FROM products; 

#Total orders
SELECT COUNT(*) AS total_orders
FROM orders;

#Total delivered orders
SELECT COUNT(*) AS total_delivered_orders
FROM orders
WHERE order_status = 'Delivered';

#Total canceled orders
SELECT COUNT(*) AS total_cancelled_orders
FROM orders
WHERE order_status = 'Cancelled';

#Total revenue by city
SELECT c.city, SUM(oi.quantity * p.price) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY c.city
ORDER by total_revenue DESC;

#Top 5 products
SELECT p.product_id, p.product_name, SUM(oi.quantity) AS quantity_sold
FROM products p
JOIN order_items oi ON oi.product_id = p.product_id 
GROUP BY p.product_id, p.product_name
ORDER BY quantity_sold DESC
LIMIT 5;

#Complete order report
SELECT c.customer_id, o.order_id, o.order_date, o.order_status, c.customer_name, p.product_name, p.category, oi.quantity, p.price, oi.quantity * p.price AS item_vale
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
LEFT JOIN payment pay ON o.order_id = pay.order_id
ORDER BY o.order_id;

