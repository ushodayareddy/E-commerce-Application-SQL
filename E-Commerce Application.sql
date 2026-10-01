

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
