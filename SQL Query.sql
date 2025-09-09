CREATE DATABASE P1_retail_db;
USE P1_retail_db;
CREATE TABLE retail_sales(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(15),
    quantity FLOAT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);
--- retail_sales
USE retail_db;
SHOW TABLES;
SELECT * FROM retail_sales ;
select 
count(*)
from retail_sales ;
SELECT * 
FROM retail_sales
WHERE transactions_id IS NULL;
SELECT * 
FROM retail_sales
WHERE gender IS NULL
OR
category IS NULL
or
price_per_unit IS NULL
or
total_sale IS NULL;
--- How many sales we have ?
SELECT COUNT(*) AS total_sales
FROM retail_sales;
--- How many coustomer we have?
SELECT   distinct category  
FROM retail_sales;

--- Data Analysis & Business Key Problems & Answers 
--- Q.1 write a SQL query to retrive all columns for sales made on '2022-11-05'
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';

--- Q.2 Write a SQL query to retrive all transactions where the category is 'clothing' and the quantity sold is more than 4 in the month of Nov-2022.

SELECT 
  category,
    SUM(quantity) AS total_quantity
FROM retail_sales
WHERE category = 'clothing'
  AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
AND 
quantity >= 4;
 
 --- Q.3 write a SQL query to calculate the total sales(total_sale) for each category.
SELECT 
category,
sum(total_sale) as net_sale
 FROM retail_sales
 GROUP BY 1;
 
 --- Q.4 write a SQL query to find the average age of customers who purchased ithems from the 'Beauty' category.
 SELECT 
 AVG(age) as avg_age
  FROM retail_sales
 WHERE category = 'Beauty';
 
 --- Q.5 Write a SQL query to find all trasactions where the total_sale is greater thta 1000
 SELECT *
FROM retail_sales
WHERE total_sale > 1000;

--- Q.6 Write a SQL query to find the total number of transaction ( transaction_id) made by each gender in each category
SELECT 
category,
gender,
count(*) as total_trans
FROM retail_sales
 GROUP BY 
 category,
gender
ORDER BY 1;

--- Q.7 write a sql query to calculate the average sale for each month. find out best selling month in each year.
SELECT 
    year,
    month,
    avg_sale,
    RANK() OVER (PARTITION BY year ORDER BY avg_sale DESC) AS sale_rank
FROM (
    SELECT 
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(total_sale) AS avg_sale
    FROM retail_sales
    GROUP BY EXTRACT(YEAR FROM sale_date), EXTRACT(MONTH FROM sale_date)
) AS sub;

--- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales
SELECT 
 customer_id,
 SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

--- Q.9 Write a SQL query to find the number of unique customers who purchased ithems from each category
SELECT 
category,
COUNT( distinct customer_id) as count_unique_cs
FROM retail_sales
GROUP BY category ;

--- Q.10 Write a SQL query to create each shift and number of orders(example moring< 12, Afternoon Between 12 &17, Evening >17)
SELECT 
    *,
    CASE  
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift
FROM retail_sales;


--- END OF PROJECT 