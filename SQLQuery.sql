SELECT * FROM orders;

SELECT 
COLUMN_NAME,DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='orders';

-- change the data types from varchar(max) and bigint to varchar and int
-- drop table orders and create table orders with required data type and import data from VS Code

DROP TABLE IF EXISTS orders
CREATE TABLE orders(
[order_id] int primary key,
[order_date] date,
[ship_mode] varchar(20),
[segment] varchar(20),
[country] varchar(20),
[city] varchar(20),
[state] varchar(20),
[postal_code] varchar(20),
[region] varchar(20),
[category] varchar(20),
[sub_category] varchar(20),
[product_id] varchar(20),
[cost_price] int,
[list_price] int,
[quantity] int,
[discount_percent] int,
[discount] decimal(7,2),
[sale_price] decimal(7,2),
[profit] decimal(7,2))

-- find the top 10 revenue generating products

SELECT TOP 10 product_id,SUM(sale_price) as sales
FROM orders
GROUP BY product_id
ORDER BY sales DESC;

-- find the top 5 highest selling products in each region

WITH CTE AS (
SELECT region, product_id,SUM(sale_price) as sales
FROM orders
GROUP BY region,product_id)
SELECT * FROM
(
SELECT *,ROW_NUMBER() OVER(PARTITION BY region ORDER BY sales DESC) AS rank
FROM CTE) A
WHERE A.rank<=5;

-- find month over month growth comparison for 2022 to 2023 sales 

WITH cte AS(
SELECT YEAR(order_date) as year,MONTH(order_date) as month,SUM(sale_price) as sales
FROM orders
GROUP BY YEAR(order_date),MONTH(order_date))
SELECT month,
SUM(CASE WHEN year=2022 THEN sales ELSE 0 END) as sale_2022,
SUM(CASE WHEN year=2023 THEN sales ELSE 0 END) as sale_2023
from cte
GROUP BY month
ORDER BY month;

-- for each category which month had highest sales

WITH CTE AS(
SELECT category,FORMAT(order_date,'yyyy_MM') as order_year_month,SUM(sale_price) as total_sales
FROM orders
GROUP BY category,FORMAT(order_date,'yyyy_MM')
)
SELECT * FROM
(SELECT *,ROW_NUMBER() OVER(PARTITION BY category ORDER BY total_sales DESC) AS rank
FROM CTE) A
WHERE A.rank=1

-- which subcategory has the highest growth from 2022 to 2023

WITH CTE AS
(
SELECT sub_category,
SUM(CASE WHEN YEAR(order_date)=2022 THEN profit ELSE 0 END) as sales_2022,
SUM(CASE WHEN YEAR(order_date)=2023 THEN profit ELSE 0 END) as sales_2023
FROM orders
GROUP BY sub_category
)
SELECT TOP 1
sub_category,sales_2022,sales_2023,((sales_2023-sales_2022)/sales_2022)*100 as growth_percentage
FROM CTE
ORDER BY growth_percentage DESC