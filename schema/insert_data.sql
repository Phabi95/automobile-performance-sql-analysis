- 3. POPULATE DATABASE FROM RAW AUTOMOBILES TABLE

-- Insert manufacturers
insert into manufacturers(make)
select distinct make
from automobiles;

-- Temporary column for mapping to automobiles
ALTER TABLE cars ADD COLUMN temp_id INT; 

-- Insert car data
INSERT INTO cars (
    manufacturer_id,
    body_style,
    drive_wheels,
    engine_location,
    num_of_doors,
    wheel_base,
    length,
    width,
    height,
    curb_weight,
    temp_id
)
SELECT 
    m.manufacturer_id,
    a.body_style,
    a.drive_wheels,
    a.engine_location,
    a.num_of_doors,
    a.wheel_base,
    a.length,
    a.width,
    a.height,
    a.curb_weight,
    a.temp_id
FROM automobiles a
JOIN manufacturers m ON a.make = m.make;

-- Insert engine data
INSERT INTO engines (
    car_id,
    engine_type,
    num_of_cylinders,
    engine_size,
    fuel_system,
    compression_ratio,
    horsepower
)
SELECT c.car_id, 
    a.engine_type,
    a.num_of_cylinders,
    a.engine_size,
    a.fuel_system, 
    a.compression_ratio, 
    a.horsepower
FROM automobiles a
JOIN cars c ON a.temp_id = c.temp_id;

-- Insert fuel data
INSERT INTO fuel (
    car_id,
    fuel_type,
    city_mpg,
    highwahy_mpg
)
SELECT c.car_id, 
    a.fuel_type,    
    a.city_mpg,
    a.highway_mpg
FROM automobiles a
JOIN cars c ON a.temp_id = c.temp_id;


-- Insert prices
INSERT INTO price (
    car_id,
    price
)
SELECT 
    c.car_id,
     a.price
FROM automobiles a
JOIN cars c ON a.temp_id = c.temp_id;
