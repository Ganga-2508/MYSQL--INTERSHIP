-- Step 1: Create a new database
CREATE DATABASE CompanyDB;

-- Step 2: Use the new database
USE CompanyDB;

-- Step 3: Create a table named Employees
CREATE TABLE Employees (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department VARCHAR(50) DEFAULT 'General',
    email VARCHAR(100) UNIQUE,
    salary DECIMAL(10,2),
    joining_date DATE
);

-- Step 4: Insert data into Employees

-- Complete row
INSERT INTO Employees (id, name, department, email, salary, joining_date)
VALUES (1, 'Alice Johnson', 'HR', 'alice@example.com', 55000.00, '2022-01-15');

-- Missing department (uses default)
INSERT INTO Employees (id, name, email, salary, joining_date)
VALUES (2, 'Bob Smith', 'bob@example.com', 60000.00, '2021-12-01');

-- Missing email (insert NULL)
INSERT INTO Employees (id, name, department, salary, joining_date)
VALUES (3, 'Charlie Davis', 'IT', 70000.00, '2023-03-10');

-- Missing department and salary
INSERT INTO Employees (id, name, email, joining_date)
VALUES (4, 'Diana Moore', 'diana@example.com', '2024-04-25');

-- Step 5: Update values using WHERE clause

-- Update salary for Bob Smith (id = 2)
UPDATE Employees
SET salary = 62000.00
WHERE id = 2;

-- Update all rows where department = 'General'
UPDATE Employees
SET department = 'Finance'
WHERE department = 'General';

-- Step 6: Delete values using WHERE clause

-- Delete employee with id = 4
DELETE FROM Employees
WHERE id = 4;

-- Delete employees who joined before 2022
DELETE FROM Employees
WHERE joining_date < '2022-01-01';

-- Step 7: View remaining data
SELECT * FROM Employees;
