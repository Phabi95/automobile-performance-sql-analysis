# Automobile SQL Analytics Project

These projects demonstrate my proficiency in SQL and my capacity to analyze complex data. They showcase my skills in data investigation, aggregation, advanced queries, and analytics.

## Dataset Overview

The dataset automobiles.csv contains:

Car attributes: body style, drive wheels, engine location, dimensions, curb weight

Engine specifications: type, cylinders, size, horsepower, compression ratio

Fuel data: type, city MPG, highway MPG

Prices

### The database schema consists of the following tables:

manufacturers – manufacturer details

cars – car attributes

engines – engine details

fuel – fuel efficiency

price – car prices

 ## Project Description

This project involved performing extensive analysis on an automobile dataset to uncover insights into:

Pricing trends

Car specifications

Fuel efficiency

Manufacturer-level comparisons

Outlier detection using Z-scores

I utilized SQL to explore the data and answer key business questions to derive actionable insights for business strategy and decision-making.

 Tasks Performed

Imported CSV data into a PostgreSQL database

Designed a normalized schema with proper foreign key relationships

Populated tables for manufacturers, cars, engines, fuel, and prices

Performed general data exploration and validation checks

### Wrote SQL queries to:

Count cars per manufacturer

Compute average horsepower, price, and MPG metrics

Identify top 5 most expensive cars

Detect outliers using Z-score analysis on horsepower

Compare cars by fuel efficiency, body style, drive wheels, and compression ratio

Used advanced SQL techniques including:

JOINs for relational queries

GROUP BY and HAVING for aggregates

CTEs for complex transformations

WINDOW functions (ROW_NUMBER(), AVG() OVER, STDDEV() OVER)

Organized and presented findings in a clear format

 ## Skills Demonstrated

Relational database design and normalization

SQL data import and transformation

Analytical queries using aggregates, subqueries, and window functions

Outlier detection and ranking

Data-driven decision-making insights

 ## Usage

Install a SQL database (PostgreSQL or MySQL recommended)

Import .sql files in order:

psql -d your_database -f schema/create_tables.sql
psql -d your_database -f schema/insert_data.sql

Run analytical queries:

psql -d your_database -f queries/automobile_analysis_queries.sql
psql -d your_database -f queries/zscore_outlier_detection.sql