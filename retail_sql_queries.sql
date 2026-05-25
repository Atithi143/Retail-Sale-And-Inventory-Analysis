USE retail_project;


SELECT * FROM superstore LIMIT 5;


SELECT customer_name, city, sales 
FROM superstore LIMIT 10;

SELECT customer_name, category, sales
FROM superstore
WHERE category = 'Technology';

SELECT customer_name, sales
FROM superstore
WHERE sales > 1000;

SELECT * FROM superstore WHERE sales IS NULL;


SELECT order_id, customer_name, COUNT(*) as total
FROM superstore
GROUP BY order_id, customer_name
HAVING COUNT(*) > 1;


SELECT DISTINCT order_id, customer_name, sales
FROM superstore;


SELECT category, ROUND(SUM(sales), 2) as total_sales
FROM superstore
GROUP BY category
ORDER BY total_sales DESC;


SELECT region, ROUND(AVG(sales), 2) as avg_sales
FROM superstore
GROUP BY region;


SELECT customer_name, sales
FROM superstore
ORDER BY sales DESC
LIMIT 5;