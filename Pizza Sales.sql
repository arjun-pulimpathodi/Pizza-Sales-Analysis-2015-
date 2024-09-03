CREATE DATABASE pizza_sales;
SELECT * FROM pizza_sales;
DESCRIBE pizza_sales;
SET SQL_SAFE_UPDATES = 0;
UPDATE pizza_sales
SET order_date = STR_TO_DATE(order_date, '%d-%m-%Y');
SET SQL_SAFE_UPDATES = 1;
ALTER TABLE pizza_sales
MODIFY COLUMN pizza_id INT,
MODIFY COLUMN order_id INT,
MODIFY COLUMN pizza_name_id VARCHAR(50),
MODIFY COLUMN quantity INT,
MODIFY COLUMN order_date DATE,
MODIFY COLUMN order_time TIME,
MODIFY COLUMN unit_price FLOAT,
MODIFY COLUMN total_price FLOAT,
MODIFY COLUMN pizza_size VARCHAR(50),
MODIFY COLUMN pizza_category VARCHAR(50),
MODIFY COLUMN pizza_ingredients VARCHAR(200),
MODIFY COLUMN pizza_name VARCHAR(50);

SELECT * FROM pizza_sales;

-- KPI's Requiremnet

-- 1. Total Revenue
SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales;

-- 2.  Average Order Value 
SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS Average_order_value FROM pizza_sales;

-- 3. Total Pizza Sold
SELECT SUM(quantity) AS Total_Pizza_Sold FROM pizza_sales;

-- 4. Total Order Placed
SELECT COUNT(DISTINCT order_id) AS Total_order_placed FROM pizza_sales;

-- 5. Average Pizzas per Order
SELECT SUM(quantity) / COUNT(DISTINCT order_id) AS Average_Pizzas_per_Order FROM pizza_sales;

-- CHART REQUIREMENT

-- 1. Daily Trend for Total Order
SELECT DAYNAME(order_date) AS Order_day, COUNT(DISTINCT order_id) AS Total_Order FROM pizza_sales
GROUP BY DAYNAME(order_date);

-- 2. Monthly Trend for Total Order
SELECT order_date FROM pizza_sales LIMIT 10;
SELECT 
  DATE_FORMAT(order_date, '%Y-%m') AS Month_Year, 
  COUNT(DISTINCT order_id) AS Total_Order
FROM pizza_sales
GROUP BY Month_Year
ORDER BY Total_Order DESC;

-- 3. Percentage of sales by pizza category
SELECT pizza_category, SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS Precentage_of_sale
FROM pizza_sales
GROUP BY pizza_category;

SELECT pizza_size, SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date)=1) AS Precentage_of_sale
FROM pizza_sales
WHERE MONTH(order_date)=1
GROUP BY pizza_size;

-- 4. Percentage of sales by pizza size
SELECT pizza_category, SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS Precentage_of_sale
FROM pizza_sales
GROUP BY pizza_category;

-- 5. Total pizza sold by pizza category
SELECT pizza_category, SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Pizzas_Sold DESC;

-- 6. Best 5 sellers
SELECT pizza_name, SUM(total_price) AS Total_revenue FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_revenue DESC LIMIT 5;

-- 7. Worst 5 sellers
SELECT pizza_name, SUM(total_price) AS Total_revenue FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_revenue ASC LIMIT 5;

-- 8. Best 5 sellers(wrt quantity)
SELECT pizza_name, SUM(quantity) AS Total_quantity FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_quantity DESC LIMIT 5;

-- 9. Worst 5 sellers(wrt quantity)
SELECT pizza_name, SUM(quantity) AS Total_quantity FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_quantity ASC LIMIT 5;

-- 10. Best 5 sellers(wrt orders)
SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_orders FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_orders DESC LIMIT 5;

-- 11. Worst 5 sellers(wrt orders)
SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_orders FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_orders ASC LIMIT 5;