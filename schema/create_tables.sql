-- 1. TEMPORARY UNIQUE IDENTIFIER FOR IMPORTING CSV DATA
ALTER TABLE automobiles ADD COLUMN temp_id SERIAL PRIMARY KEY;

# Using temp_id ensures exactly one car row per CSV row.

-- 2. CREATE  DATABASE SCHEMA


-- Table of manufacturers
create table manufacturers(
    manufacturer_id serial primary key,
    make varchar(50) unique
);

-- Table of cars
create table cars(
    car_id serial primary key,
    manufacturer_id int references manufacturers(manufacturer_id),
    body_style VARCHAR(20),
    drive_wheels VARCHAR(20),
    engine_location VARCHAR(20),
    num_of_doors VARCHAR(20),
    wheel_base FLOAT,
    length FLOAT,
    width FLOAT,
    height FLOAT,
    curb_weight INT
);

-- Table of engines
create table engines(
    engine_id serial primary key,
    car_id int references cars(car_id),
    engine_type varchar(20),
    num_of_cylinders varchar(20),
    engine_size int,
    fuel_system varchar(20),
    compression_ratio int,
    horsepower int

);

-- Table of fuel data
create table fuel(
    engine_id int references engines(engine_id),
    car_id int references cars(car_id),
    fuel_type varchar(20),
    city_mpg int,
    highwahy_mpg int
);

-- Table of prices
create table price(
    car_id int references cars(car_id),
    price float
);