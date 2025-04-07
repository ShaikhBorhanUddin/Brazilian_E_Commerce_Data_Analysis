# Q1: Display total sales revenue per month 
## Solution
```SQL
SELECT 
    DATE_TRUNC('month', order_purchase_timestamp) AS month,
    SUM(oi.price + oi.freight_value) AS total_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY month
ORDER BY month;
```
## Output:
|month              |total_revenue|
|-------------------|-------------|
|2016-09-01 00:00:00|354.75       |
|2016-10-01 00:00:00|56808.84     |
|2016-12-01 00:00:00|19.62        |
|2017-01-01 00:00:00|137188.49    |
|2017-02-01 00:00:00|286280.62    |
|2017-03-01 00:00:00|432048.59    |
|2017-04-01 00:00:00|412422.24    |
|2017-05-01 00:00:00|586190.95    |
|2017-06-01 00:00:00|502963.04    |
|2017-07-01 00:00:00|584971.62    |
|2017-08-01 00:00:00|668204.60    |
|2017-09-01 00:00:00|720398.91    |
|2017-10-01 00:00:00|769312.37    |
|2017-11-01 00:00:00|1179143.77   |
|2017-12-01 00:00:00|863547.23    |
|2018-01-01 00:00:00|1107301.89   |
|2018-02-01 00:00:00|986908.96    |
|2018-03-01 00:00:00|1155126.82   |
|2018-04-01 00:00:00|1159698.04   |
|2018-05-01 00:00:00|1149781.82   |
|2018-06-01 00:00:00|1022677.11   |
|2018-07-01 00:00:00|1058728.03   |
|2018-08-01 00:00:00|1003308.47   |
|2018-09-01 00:00:00|166.46       |
# Q2: Show top 5 most selling product categories
## Solution
```SQL
SELECT 
    pct.product_category_name_english,
    COUNT(oi.product_id) AS total_sales
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN product_category_name_translation pct ON p.product_category_name = pct.product_category_name
GROUP BY pct.product_category_name_english
ORDER BY total_sales DESC
LIMIT 5;
```
## Output
|product_category_name_english|total_sales|
|-----------------------------|-----------|
|bed_bath_table               |11115      |
|health_beauty                |9670       |
|sports_leisure               |8641       |
|furniture_decor              |8334       |
|computers_accessories        |7827       |
