CREATE TABLE superstore (
    ship_mode VARCHAR(50),
    segment VARCHAR(50),
    country VARCHAR(100),
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code INT,
    region VARCHAR(50),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    sales NUMERIC,
    quantity INT,
    discount NUMERIC,
    profit NUMERIC
);

select * from superstore;

select count(*) from superstore;

#regional

SELECT
    region,
    ROUND(SUM(sales),2) AS total_sales,
    RANK() OVER(
        ORDER BY SUM(sales) DESC
    ) AS sales_rank FROM superstore GROUP BY region;
	
#ranking

SELECT
    region,
    ROUND(SUM(sales),2) AS total_sales,
    RANK() OVER(
        ORDER BY SUM(sales) DESC
    ) AS sales_rank
FROM superstore
GROUP BY region;

SELECT
    category,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit,
    ROUND(
        SUM(profit)
        /
        SUM(sales)
        * 100,
        2
    ) AS profit_margin
FROM superstore GROUP BY category ORDER BY total_profit DESC;


SELECT state,ROUND(SUM(profit),2) AS total_profit FROM superstore GROUP BY state ORDER BY total_profit DESC LIMIT 5;

SELECT
    category,
    ROUND(SUM(profit),2) AS total_profit,
    DENSE_RANK() OVER( ORDER BY SUM(profit) DESC ) AS profit_rank FROM superstore GROUP BY category;



WITH category_profit AS
(
    SELECT
        category,
        SUM(profit) AS total_profit
    FROM superstore
    GROUP BY category
)
SELECT *
FROM category_profit
WHERE total_profit >
(
    SELECT AVG(total_profit)
    FROM category_profit
);



SELECT
    COUNT(*) AS total_orders,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit,
    SUM(quantity) AS total_quantity,
    ROUND(
        SUM(profit)/SUM(sales)*100,
        2
    ) AS profit_margin
FROM superstore;