-- =============================================
-- Retail Sale and Inventory Analysis
-- SQL Queries for Data Cleaning & Analysis
-- =============================================

USE retail_project;

-- =============================================
-- 1. CREATE TABLE
-- =============================================

CREATE TABLE superstore (
    row_id        INT,
    order_id      VARCHAR(20),
    order_date    DATE,
    ship_date     DATE,
    ship_mode     VARCHAR(30),
    customer_id   VARCHAR(20),
    customer_name VARCHAR(50),
    segment       VARCHAR(20),
    country       VARCHAR(30),
    city          VARCHAR(30),
    state         VARCHAR(30),
    postal_code   VARCHAR(10),
    region        VARCHAR(20),
    product_id    VARCHAR(20),
    category      VARCHAR(30),
    sub_category  VARCHAR(30),
    product_name  VARCHAR(200),
    sales         DECIMAL(10,2),
    quantity      INT,
    discount      DECIMAL(5,2),
    profit        DECIMAL(10,2)
);

-- =============================================
-- 2. DATA PREVIEW
-- =============================================

-- View first 5 records
SELECT * FROM superstore LIMIT 5;

-- Total number of records
SELECT COUNT(*) AS total_records FROM superstore;

-- View specific columns
SELECT customer_name, city, sales
FROM superstore LIMIT 10;

-- =============================================
-- 3. DATA CLEANING
-- =============================================

-- Check NULL values
SELECT * FROM superstore
WHERE sales IS NULL;

-- Check Duplicate records
SELECT order_id, customer_name, COUNT(*) AS total
FROM superstore
GROUP BY order_id, customer_name
HAVING COUNT(*) > 1;

-- View Unique records
SELECT DISTINCT order_id, customer_name, sales
FROM superstore;

-- Fill NULL values with 0
UPDATE superstore
SET sales = COALESCE(sales, 0),
    profit = COALESCE(profit, 0),
    quantity = COALESCE(quantity, 0)
WHERE sales IS NULL
   OR profit IS NULL
   OR quantity IS NULL;

-- =============================================
-- 4. SALES ANALYSIS
-- =============================================

-- Filter by Technology Category
SELECT customer_name, category, sales
FROM superstore
WHERE category = 'Technology';

-- Filter Sales greater than 1000
SELECT customer_name, sales
FROM superstore
WHERE sales > 1000;

-- Total Sales by Category
SELECT category, ROUND(SUM(sales), 2) AS total_sales
FROM superstore
GROUP BY category
ORDER BY total_sales DESC;

-- Average Sales by Region
SELECT region, ROUND(AVG(sales), 2) AS avg_sales
FROM superstore
GROUP BY region
ORDER BY avg_sales DESC;

-- Top 5 Customers by Sales
SELECT customer_name, ROUND(SUM(sales), 2) AS total_sales
FROM superstore
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 5;

-- Bottom 5 Customers by Sales
SELECT customer_name, ROUND(SUM(sales), 2) AS total_sales
FROM superstore
GROUP BY customer_name
ORDER BY total_sales ASC
LIMIT 5;

-- =============================================
-- 5. PROFIT ANALYSIS
-- =============================================

-- Total Profit by Category
SELECT category, ROUND(SUM(profit), 2) AS total_profit
FROM superstore
GROUP BY category
ORDER BY total_profit DESC;

-- Loss Making Orders
SELECT order_id, customer_name, sales, profit
FROM superstore
WHERE profit < 0
ORDER BY profit ASC
LIMIT 10;

-- Most Profitable Customers
SELECT customer_name, ROUND(SUM(profit), 2) AS total_profit
FROM superstore
GROUP BY customer_name
ORDER BY total_profit DESC
LIMIT 5;

-- Profit by Region
SELECT region, ROUND(SUM(profit), 2) AS total_profit
FROM superstore
GROUP BY region
ORDER BY total_profit DESC;

-- =============================================
-- 6. REGION & STATE ANALYSIS
-- =============================================

-- Sales by Region
SELECT region, ROUND(SUM(sales), 2) AS total_sales
FROM superstore
GROUP BY region
ORDER BY total_sales DESC;

-- Top 5 States by Sales
SELECT state, ROUND(SUM(sales), 2) AS total_sales
FROM superstore
GROUP BY state
ORDER BY total_sales DESC
LIMIT 5;

-- =============================================
-- 7. PRODUCT ANALYSIS
-- =============================================

-- Sales by Sub Category
SELECT sub_category, ROUND(SUM(sales), 2) AS total_sales
FROM superstore
GROUP BY sub_category
ORDER BY total_sales DESC;

-- Top 10 Products by Sales
SELECT product_name, ROUND(SUM(sales), 2) AS total_sales
FROM superstore
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;

-- =============================================
-- 8. ORDER ANALYSIS
-- =============================================

-- Orders by Ship Mode
SELECT ship_mode, COUNT(*) AS total_orders
FROM superstore
GROUP BY ship_mode
ORDER BY total_orders DESC;

-- Orders by Segment
SELECT segment, COUNT(*) AS total_orders,
ROUND(SUM(sales), 2) AS total_sales
FROM superstore
GROUP BY segment
ORDER BY total_sales DESC;

-- =============================================
-- 9. DISCOUNT ANALYSIS
-- =============================================

-- Average Discount by Category
SELECT category, ROUND(AVG(discount), 2) AS avg_discount
FROM superstore
GROUP BY category
ORDER BY avg_discount DESC;

-- High Discount Orders (Discount > 0.5)
SELECT order_id, customer_name, discount, sales, profit
FROM superstore
WHERE discount > 0.5
ORDER BY discount DESC;
