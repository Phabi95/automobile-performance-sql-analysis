-- 4.1 List all manufacturers

select * from manufacturers

-- 4.2 Count how many cars each manufacturer produces

select 
    make as manufacturer,
    count(car_id) as cars
from manufacturers join cars
    using(manufacturer_id)
group by 1
order by 2 desc

-- 4.3 List all cars with a specific body style   

select make as manufacturer,
     body_style, 
    drive_wheels 
from manufacturers
join  cars
    using (manufacturer_id)
where body_style = 'sedan';

-- 4.4 Average horsepower per manufacturer

select 
    m.make ,
    Round(avg(e.horsepower),1) as avg_hp 
from manufacturers m
join cars c on (m.manufacturer_id = c.manufacturer_id)
join engines e on (c.car_id = e.car_id)
group by 1
order by 2 desc

-- 4.5 Average price per body style

select
    body_style , 
    round(AVG(price)) from cars  
join  price using (car_id)
group by 1
order by 2 desc

-- 4.6 Count cars with more than 6 cylinders

SELECT 
    COUNT(*) AS high_cylinder_cars
FROM engines
WHERE num_of_cylinders >  'six';

-- 4.7 Top 5 most expensive cars

select 
    car_id as car  ,
    make, 
    price from price
join cars  using(car_id)
join manufacturers using (manufacturer_id)
order by price desc
limit 5;

-- 4.8 Manufacturers with average city MPG above 25

SELECT 
    m.make, 
    round(AVG(f.city_mpg),2) AS avg_city_mpg
FROM manufacturers m
JOIN cars c ON m.manufacturer_id = c.manufacturer_id
JOIN fuel f ON c.car_id = f.car_id
GROUP BY m.make
HAVING AVG(f.city_mpg) > 25;

-- 4.9 Compare average horsepower for different drive wheels

select c.drive_wheels,avg(e.horsepower) as avg_hp 
from cars c join engines e using(car_id)
group by 1 

-- 4.10 Car(s) with highest compression ratio per manufacturer

select 
    c.car_id as car_number
,   m.make as manufacturer,
    e.compression_ratio
from cars c join manufacturers m on c.manufacturer_id=m.manufacturer_id
join engines e on c.car_id = e.car_id
where e.compression_ratio = (
    select max(e2.compression_ratio)
    from cars c2 
    join engines e2 on c2.car_id = e2.car_id
    where c2.manufacturer_id=m.manufacturer_id
) 
order by 2

-- 4.11 Cars cheaper than the average price for their manufacturer

select 
    c.car_id as cars ,
    m.make , p.price as price 
from cars c join price p on c.car_id = p.car_id
join manufacturers m on m.manufacturer_id = c.manufacturer_id
where p.price < (
    select avg(p2.price) as price 
    from cars c2 join price p2 on c2.car_id = p2.car_id
    where c2.manufacturer_id = c.manufacturer_id
)

-- 4.12 Highest horsepower car(s) per manufacturer and price comparison

with max_hp as (
    select c.manufacturer_id , max(e.horsepower)  as hpower
    from cars c join engines e on c.car_id = e.car_id
    group by 1
),
avg_price as (
    select c.manufacturer_id , avg(p.price) as pr 
    from cars c join price p on c.car_id = p.car_id
    group by 1
)
select 
        c1.car_id ,
        m1.make , 
        e1.horsepower ,
        p1.price ,
        round (p1.price - ap.pr) as price_diff_from_avg
from cars c1 join manufacturers m1 
on m1.manufacturer_id = c1.manufacturer_id
join price p1 on p1.car_id=c1.car_id
join engines e1 on p1.car_id = e1.car_id
join max_hp mh on c1.manufacturer_id = mh.manufacturer_id
join avg_price ap on ap.manufacturer_id = c1.manufacturer_id
and e1.horsepower = mh.hpower
order by m1.make ,p1.price desc

-- 4.13 Top 3 most fuel-efficient cars per manufacturer

with ranked_cars as (
    select 
        m.make ,
        c.car_id , 
        e.horsepower,         
        f.city_mpg, p.price,
        row_number  () over(PARTITION by m.manufacturer_id order by f.city_mpg desc) as mpg_rank 
    from cars c 
    join manufacturers m on m.manufacturer_id = c.manufacturer_id
    join engines e on c.car_id = e.car_id
    join price p on c.car_id = p.car_id
    join fuel f on c.car_id = f.car_id
)
select *
from ranked_cars
where mpg_rank <=3
order by make, mpg_rank, city_mpg desc;

-- 4.14 Number of unique body styles per manufacturer

select
     make ,
    count(distinct body_style) 
from manufacturers join cars using(manufacturer_id)
group by make
order by count(*) desc

-- 4.15 Manufacturers with average highway MPG > 35

select 
    m.make , 
    avg(f.highwahy_mpg) as avg_mpg
from manufacturers m 
join cars c on m.manufacturer_id=c.manufacturer_id
join fuel f on c.car_id=f.car_id
group by 1 
having avg(f.highwahy_mpg) > 35
order by 2 desc