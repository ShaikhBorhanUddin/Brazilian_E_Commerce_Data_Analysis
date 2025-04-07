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
# Q3: What is the average delivery time by state?
## Solution
```SQL
SELECT 
    c.customer_state,
    AVG(DATE_PART('day', o.order_delivered_customer_date - o.order_purchase_timestamp)) AS avg_delivery_days
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_state
ORDER BY avg_delivery_days;
```
## Output
|customer_state|avg_delivery_days   |
|--------------|--------------------|
|SP            |8.298061489072724   |
|PR            |11.52671135486492   |
|MG            |11.543813298106562  |
|DF            |12.509134615384616  |
|SC            |14.479560191711306  |
|RS            |14.819236526946108  |
|RJ            |14.84918643244556   |
|GO            |15.15074092999489   |
|MS            |15.191155492154065  |
|ES            |15.331829573934836  |
|TO            |17.226277372262775  |
|MT            |17.59367945823928   |
|PE            |17.965473948524796  |
|RN            |18.824894514767934  |
|BA            |18.86640049140049   |
|RO            |18.91358024691358   |
|PI            |18.993697478991596  |
|PB            |19.95357833655706   |
|AC            |20.6375             |
|CE            |20.817826426896012  |
|SE            |21.029850746268657  |
|MA            |21.11715481171548   |
|PA            |23.316067653276956  |
|AL            |24.04030226700252   |
|AM            |25.986206896551725  |
|AP            |26.73134328358209   |
|RR            |28.975609756097562  |
# Q4: Display top 10 sellers by revenue
## Solution
```SQL
SELECT 
    s.seller_id,
    SUM(oi.price + oi.freight_value) AS total_revenue
FROM order_items oi
JOIN sellers s ON oi.seller_id = s.seller_id
GROUP BY s.seller_id
ORDER BY total_revenue DESC
LIMIT 10;
```
## Output
|seller_id                         |total_revenue|
|----------------------------------|-------------|
|4869f7a5dfa277a7dca6462dcf3b52b2  |249640.70    |
|7c67e1448b00f6e969d365cea6b010ab  |239536.44    |
|53243585a1d6dc2643021fd1853d8905  |235856.68    |
|4a3ca9315b744ce9f8e9374361493884  |235539.96    |
|fa1c13f2614d7b5c4749cbc52fecda94  |204084.73    |
|da8622b14eb17ae2831f4ac5b9dab84a  |185192.32    |
|7e93a43ef30c4f03f38b393420bc753a  |182754.05    |
|1025f0e2d44d7041d6cf58b6550e0bfa  |172860.69    |
|7a67c85e85bb2ce8582c35f2203ad736  |162648.38    |
|955fee9216a65b617aa5c0531780ce60  |160602.68    |
# Q5: Display most preferred payment methods
## Solution
```SQL
SELECT 
    payment_type,
    COUNT(*) AS total_transactions,
    SUM(payment_value) AS total_value
FROM order_payments
GROUP BY payment_type
ORDER BY total_value DESC;
```
## Output
|payment_type|total_transactions|total_value|
|------------|------------------|-----------|
|credit_card |76795             |12542084.19|
|boleto      |19784             |2869361.27 |
|voucher     |5775              |379436.87  |
|debit_card  |1529              |217989.79  |
|not_defined |3                 |0.00       |
