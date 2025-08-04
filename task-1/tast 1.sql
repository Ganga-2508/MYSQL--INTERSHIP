-- -----------------------------------------------------
-- DATABASE SETUP: E-Commerce Platform Schema
-- -----------------------------------------------------

-- Drop existing DB if needed
DROP DATABASE IF EXISTS ecommerce_db;
CREATE DATABASE ecommerce_db;
USE ecommerce_db;

-- Customers
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    address TEXT
);

-- Products
CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT DEFAULT 0
);

-- Orders
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- OrderItems
CREATE TABLE OrderItems (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Payments
CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT UNIQUE,
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10,2),
    method VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- -----------------------------------------------------
-- INSERT SAMPLE DATA
-- -----------------------------------------------------

-- Customers
INSERT INTO Customers (name, email, phone, address) VALUES
('Alice Sharma', 'alice@gmail.com', '9876543210', 'Mumbai, India'),
('Ravi Kumar', 'ravi.kumar@example.com', '9123456789', 'Delhi, India'),
('Sara Dsouza', 'sara.d@example.com', '9988776655', 'Bangalore, India');

-- Products
INSERT INTO Products (name, description, price, stock_quantity) VALUES
('Wireless Mouse', 'Ergonomic wireless mouse', 699.00, 50),
('Keyboard', 'Mechanical keyboard with backlight', 1999.00, 30),
('USB-C Charger', '65W fast charger', 1499.00, 20),
('Laptop Stand', 'Aluminium foldable stand', 1299.00, 15);

-- Orders
INSERT INTO Orders (customer_id, order_date, status) VALUES
(1, '2025-08-01 10:00:00', 'Shipped'),
(2, '2025-08-02 12:30:00', 'Pending'),
(3, '2025-08-03 09:15:00', 'Delivered');

-- OrderItems
INSERT INTO OrderItems (order_id, product_id, quantity, price) VALUES
(1, 1, 2, 699.00),
(1, 4, 1, 1299.00),
(2, 2, 1, 1999.00),
(3, 3, 1, 1499.00);

-- Payments
INSERT INTO Payments (order_id, payment_date, amount, method) VALUES
(1, '2025-08-01 10:10:00', 2697.00, 'UPI'),
(3, '2025-08-03 09:20:00', 1499.00, 'Credit Card');

-- -----------------------------------------------------
-- VERIFY DATA
-- -----------------------------------------------------
SELECT * FROM Customers;
SELECT * FROM Products;
SELECT * FROM Orders;
SELECT * FROM OrderItems;
SELECT * FROM Payments;
