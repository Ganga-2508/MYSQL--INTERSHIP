-- Create a new database
CREATE DATABASE car;

-- Use the database
USE car;

-- Create cars table
CREATE TABLE cars (
    car_id INT PRIMARY KEY AUTO_INCREMENT,
    brand VARCHAR(50),
    model VARCHAR(50),
    year INT,
    price DECIMAL(10, 2),
    fuel_type VARCHAR(20)
);

-- Insert sample data
INSERT INTO cars (brand, model, year, price, fuel_type) VALUES
('Toyota', 'Corolla', 2020, 18000, 'Petrol'),
('Toyota', 'Camry', 2021, 25000, 'Hybrid'),
('Honda', 'Civic', 2019, 17000, 'Petrol'),
('Honda', 'Accord', 2020, 24000, 'Petrol'),
('Ford', 'Focus', 2018, 15000, 'Diesel'),
('Ford', 'Fusion', 2019, 20000, 'Hybrid'),
('BMW', '3 Series', 2021, 35000, 'Petrol'),
('BMW', '5 Series', 2020, 50000, 'Diesel'),
('Audi', 'A4', 2019, 33000, 'Petrol'),
('Audi', 'A6', 2021, 55000, 'Diesel'),
('Tesla', 'Model 3', 2022, 45000, 'Electric'),
('Tesla', 'Model S', 2022, 80000, 'Electric'),
('Hyundai', 'Elantra', 2020, 16000, 'Petrol'),
('Hyundai', 'Sonata', 2021, 22000, 'Hybrid'),
('Kia', 'Optima', 2019, 19000, 'Diesel');

-- Answer outputs

-- 1. Total price of all cars by brand
SELECT brand, SUM(price) AS total_price
FROM cars
GROUP BY brand;

-- 2. Average car price by brand
SELECT brand, AVG(price) AS avg_price
FROM cars
GROUP BY brand;

-- 3. Number of car models per fuel type
SELECT fuel_type, COUNT(*) AS total_models
FROM cars
GROUP BY fuel_type;

-- 4. Brands with average price above 30,000
SELECT brand, AVG(price) AS avg_price
FROM cars
GROUP BY brand
HAVING AVG(price) > 30000;

-- 5. Total price of cars by brand and fuel type
SELECT brand, fuel_type, SUM(price) AS total_price
FROM cars
GROUP BY brand, fuel_type;

-- 6. Average price by brand and fuel type
SELECT brand, fuel_type, ROUND(AVG(price), 2) AS avg_price
FROM cars
GROUP BY brand, fuel_type;

-- 7. Count distinct brands
SELECT COUNT(DISTINCT brand) AS distinct_brands
FROM cars;

-- 8. Highest priced car per brand
SELECT brand, MAX(price) AS highest_price
FROM cars
GROUP BY brand;

-- 9. Lowest priced car per fuel type
SELECT fuel_type, MIN(price) AS lowest_price
FROM cars
GROUP BY fuel_type;

-- 10. Fuel types with more than 3 models
SELECT fuel_type, COUNT(*) AS model_count
FROM cars
GROUP BY fuel_type
HAVING COUNT(*) > 3;
