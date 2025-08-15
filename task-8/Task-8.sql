-- First, we need to create a database and a table to work with.
-- This part is for setting up your environment.
-- You can run these commands directly in MySQL Workbench.

-- Create a new database named 'Company_DB'
-- DROP DATABASE IF EXISTS Company_DB;
CREATE DATABASE Company_DB;

-- Use the newly created database
USE Company_DB;

-- Create a table named 'Employees'
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    hire_date DATE,
    salary DECIMAL(10, 2)
);

-- Now, let's create a stored procedure.
-- This procedure will insert a new employee into the Employees table.
-- It uses IN parameters to accept the employee's details.

DELIMITER //

CREATE PROCEDURE AddNewEmployee (
    IN p_first_name VARCHAR(50),
    IN p_last_name VARCHAR(50),
    IN p_hire_date DATE,
    IN p_salary DECIMAL(10, 2)
)
BEGIN
    INSERT INTO Employees (first_name, last_name, hire_date, salary)
    VALUES (p_first_name, p_last_name, p_hire_date, p_salary);
END //

DELIMITER ;

-- To use the stored procedure, you would run a command like this:
-- CALL AddNewEmployee('John', 'Doe', '2023-01-15', 60000.00);
-- SELECT * FROM Employees;

-- Next, we will create a function.
-- This function will calculate a bonus based on an employee's salary.
-- It returns a single DECIMAL value.

DELIMITER //

CREATE FUNCTION CalculateBonus (
    p_salary DECIMAL(10, 2)
)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE v_bonus DECIMAL(10, 2);

    -- Check if the salary is greater than 50000.
    IF p_salary > 50000.00 THEN
        SET v_bonus = p_salary * 0.10; -- 10% bonus
    ELSE
        SET v_bonus = p_salary * 0.05; -- 5% bonus
    END IF;

    -- Return the calculated bonus
    RETURN v_bonus;
END //

DELIMITER ;

-- To use the function, you can call it within a SELECT statement:
-- SELECT CalculateBonus(60000.00);
-- Or, you can apply it to all employees in the table:
-- SELECT
--     first_name,
--     last_name,
--     salary,
--     CalculateBonus(salary) AS bonus
-- FROM
--     Employees;


-- output
CALL AddNewEmployee('John', 'Doe', '2023-01-15', 60000.00);

SELECT * FROM Employees; 


SELECT first_name, last_name, salary, CalculateBonus(salary) AS bonus FROM Employees;
