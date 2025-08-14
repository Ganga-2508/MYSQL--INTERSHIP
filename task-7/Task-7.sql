-- 1️⃣ Create Database
CREATE DATABASE laptop;
USE laptop;

-- 2️⃣ Create Departments Table
CREATE TABLE departments (
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name VARCHAR(50) NOT NULL
);

-- 3️⃣ Create Employees Table
CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(50) NOT NULL,
    dept_id INT,
    salary DECIMAL(10,2),
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- 4️⃣ Insert Sample Data into Departments
INSERT INTO departments (dept_name) VALUES
('HR'), 
('Finance'), 
('IT'), 
('Marketing');

-- 5️⃣ Insert Sample Data into Employees
INSERT INTO employees (emp_name, dept_id, salary) VALUES
('John Doe', 1, 45000.00),
('Jane Smith', 2, 65000.00),
('Alice Johnson', 3, 55000.00),
('Bob Brown', 4, 72000.00),
('Charlie Davis', 3, 48000.00);

-- ✅ Base tables ready

/* ================================
   6️⃣ Creating Views
   ================================ */

-- View 1: Employees with Department Names
CREATE VIEW Employee_Department_View AS
SELECT e.emp_id, e.emp_name, d.dept_name, e.salary
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id;

-- View 2: High Salary Employees (> 50000)
CREATE VIEW High_Salary_View AS
SELECT emp_id, emp_name, salary
FROM employees
WHERE salary > 50000;

-- View 3: Updatable View with CHECK OPTION
CREATE VIEW Low_Salary_View AS
SELECT emp_id, emp_name, salary
FROM employees
WHERE salary < 60000
WITH CHECK OPTION;

-- ================================
-- 7️⃣ Sample Queries Using Views
-- ================================

-- View 1 Output
SELECT * FROM Employee_Department_View;

-- View 2 Output
SELECT * FROM High_Salary_View;

-- Update Using View with CHECK OPTION
UPDATE Low_Salary_View
SET salary = 55000
WHERE emp_id = 1; -- Allowed

UPDATE Low_Salary_View
SET salary = 61000
WHERE emp_id = 3; -- ❌ Will fail (violates CHECK OPTION)

-- ================================
-- 8️⃣ Drop a View
-- ================================
-- DROP VIEW High_Salary_View;
