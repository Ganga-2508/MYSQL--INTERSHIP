-- Create database (MySQL syntax; skip this line in SQLite)
CREATE DATABASE alpha;
USE alpha;

-- Create Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50) NOT NULL,
    City VARCHAR(50)
);

-- Create Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    CustomerID INT,
    Amount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Insert Customers
INSERT INTO Customers (CustomerID, CustomerName, City) VALUES
(1, 'John Doe', 'New York'),
(2, 'Jane Smith', 'Los Angeles'),
(3, 'Michael Brown', 'Chicago'),
(4, 'Emily Davis', 'Houston'),
(5, 'David Wilson', 'Phoenix');

-- Insert Orders
INSERT INTO Orders (OrderID, OrderDate, CustomerID, Amount) VALUES
(101, '2025-08-01', 1, 250.00),
(102, '2025-08-03', 1, 175.50),
(103, '2025-08-05', 2, 300.00),
(104, '2025-08-06', 3, 450.75),
(105, '2025-08-10', NULL, 500.00); -- No matching customer

-- Example Joins
-- INNER JOIN
SELECT c.CustomerName, o.OrderID, o.Amount
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID;

-- LEFT JOIN
SELECT c.CustomerName, o.OrderID, o.Amount
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID;

-- RIGHT JOIN (MySQL only)
SELECT c.CustomerName, o.OrderID, o.Amount
FROM Customers c
RIGHT JOIN Orders o ON c.CustomerID = o.CustomerID;

-- FULL OUTER JOIN (via UNION)
SELECT c.CustomerName, o.OrderID, o.Amount
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
UNION
SELECT c.CustomerName, o.OrderID, o.Amount
FROM Customers c
RIGHT JOIN Orders o ON c.CustomerID = o.CustomerID;
