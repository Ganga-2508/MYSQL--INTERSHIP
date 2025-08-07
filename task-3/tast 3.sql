CREATE DATABASE IF NOT EXISTS Companykk;
USE Companykk;

CREATE TABLE Employees (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(30),
    salary INT,
    joining_date DATE
);

INSERT INTO Employees (id, name, department, salary, joining_date) VALUES
(1, 'Alice', 'IT', 60000, '2021-04-12'),
(2, 'Bob', 'HR', 45000, '2020-09-23'),
(3, 'Charlie', 'Finance', 50000, '2022-01-15'),
(4, 'David', 'IT', 70000, '2021-07-19'),
(5, 'Eva', 'Marketing', 55000, '2023-03-10'),
(6, 'Frank', 'Finance', 48000, '2020-05-20'),
(7, 'Grace', 'IT', 62000, '2022-08-30');


-- output answers


SELECT name, department FROM Employees;

SELECT * FROM Employees;

SELECT * FROM Employees
WHERE department = 'IT';

 -- WHERE with AND
SELECT * FROM Employees
WHERE department = 'Finance' AND salary > 48000;

-- 5. WHERE with OR
SELECT * FROM Employees
WHERE department = 'HR' OR department = 'Marketing';

-- 6. LIKE: Name contains letter 'a'
SELECT * FROM Employees
WHERE name LIKE '%a%';

-- 7. BETWEEN: Salary between 50000 and 65000
SELECT * FROM Employees
WHERE salary BETWEEN 50000 AND 65000;

-- 8. ORDER BY: Sort by salary ascending
SELECT * FROM Employees
ORDER BY salary;

-- 9. ORDER BY: Sort by salary descending
SELECT * FROM Employees
ORDER BY salary DESC;

-- 10. LIMIT: Show only 3 records
SELECT * FROM Employees
LIMIT 3;

-- 11. Aliasing
SELECT name AS Employee_Name, department AS Dept FROM Employees;

-- 12. DISTINCT departments
SELECT DISTINCT department FROM Employees;

-- 13. Using IN
SELECT * FROM Employees
WHERE department IN ('IT', 'Finance');
