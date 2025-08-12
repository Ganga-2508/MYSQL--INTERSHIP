-- Create a table for assembly plants
CREATE TABLE AssemblyPlants (
    plant_id INT PRIMARY KEY,
    plant_name VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL
);

-- Create a table for Jeep models
CREATE TABLE JeepModels (
    model_id INT PRIMARY KEY,
    model_name VARCHAR(50) NOT NULL,
    base_price DECIMAL(10, 2) NOT NULL,
    assembly_plant_id INT,
    FOREIGN KEY (assembly_plant_id) REFERENCES AssemblyPlants(plant_id)
);

-- Create a table for sales records
CREATE TABLE SalesRecords (
    sale_id INT PRIMARY KEY,
    model_id INT,
    sale_date DATE,
    sale_price DECIMAL(10, 2),
    FOREIGN KEY (model_id) REFERENCES JeepModels(model_id)
);

-- Insert sample data into AssemblyPlants
INSERT INTO AssemblyPlants (plant_id, plant_name, country) VALUES
(1, 'Toledo Complex', 'USA'),
(2, 'Belvedere Assembly', 'USA'),
(3, 'Melfi Plant', 'Italy'),
(4, 'Goiana Plant', 'Brazil');

-- Insert sample data into JeepModels
INSERT INTO JeepModels (model_id, model_name, base_price, assembly_plant_id) VALUES
(101, 'Wrangler', 30000.00, 1),
(102, 'Grand Cherokee', 40000.00, 1),
(103, 'Cherokee', 35000.00, 2),
(104, 'Renegade', 25000.00, 3),
(105, 'Compass', 28000.00, 4);

-- Insert sample data into SalesRecords
INSERT INTO SalesRecords (sale_id, model_id, sale_date, sale_price) VALUES
(1, 101, '2023-01-15', 31500.00),
(2, 102, '2023-01-20', 42000.00),
(3, 101, '2023-02-10', 30500.00),
(4, 103, '2023-02-18', 34500.00),
(5, 104, '2023-03-05', 26000.00),
(6, 105, '2023-03-12', 29000.00),
(7, 105, '2023-03-20', 29500.00);



SELECT
    model_name,
    base_price
FROM
    JeepModels
WHERE
    base_price > (SELECT AVG(base_price) FROM JeepModels);
    
    
    
    SELECT
    model_name
FROM
    JeepModels
WHERE
    model_id IN (SELECT DISTINCT model_id FROM SalesRecords);
    
    
    
    SELECT
    m.model_name,
    m.base_price,
    avg_sale.avg_sale_price
FROM
    JeepModels m
JOIN
    (SELECT model_id, AVG(sale_price) AS avg_sale_price FROM SalesRecords GROUP BY model_id) AS avg_sale
ON
    m.model_id = avg_sale.model_id
WHERE
    avg_sale.avg_sale_price > m.base_price;
    
    
    
    
    
    SELECT
    plant_name
FROM
    AssemblyPlants ap
WHERE
    EXISTS (SELECT 1 FROM JeepModels jm WHERE jm.assembly_plant_id = ap.plant_id AND jm.base_price > 35000);
    
    
    
    
    
    
    
    SELECT
    model_name,
    base_price,
    (SELECT country FROM AssemblyPlants ap WHERE ap.plant_id = jm.assembly_plant_id) AS country_of_origin
FROM
    JeepModels jm;
    
    
    