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
## Tableau Visualization
![Dashboard](https://github.com/ShaikhBorhanUddin/Brazilian_E_Commerce_Project/blob/main/Images/Sheet101.png?raw=true)
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
## Tableau Visualization
![Dashboard](https://github.com/ShaikhBorhanUddin/Brazilian_E_Commerce_Project/blob/main/Images/Sheet%202205.png?raw=true)
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
## Tableau Visualization
![Dashboard](https://github.com/ShaikhBorhanUddin/Brazilian_E_Commerce_Project/blob/main/Images/Sheet%203%20(1).png?raw=true)
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
## Tableau Visualization
![Dashboard](https://github.com/ShaikhBorhanUddin/Brazilian_E_Commerce_Project/blob/main/Images/Sheet%202.png?raw=true)
###
![Dashboard](https://github.com/ShaikhBorhanUddin/Brazilian_E_Commerce_Project/blob/main/Images/Sheet%202%20(1).png?raw=true)
# Q6: Show customer repeat purchase rate
## Solution
```SQL
SELECT
    COUNT(DISTINCT customer_id) AS total_customers,
    COUNT(DISTINCT CASE WHEN customer_order_count > 1 THEN customer_id END) AS repeat_customers,
    ROUND(100.0 * COUNT(DISTINCT CASE WHEN customer_order_count > 1 THEN customer_id END) / COUNT(DISTINCT customer_id), 2) AS repeat_purchase_rate_percentage
FROM (
    SELECT customer_id, COUNT(order_id) AS customer_order_count
    FROM orders
    GROUP BY customer_id
) subquery;
```
## Output
|total_customers|repeat_customers|repeat_purchase_rate_percentage|
|---------------|----------------|-------------------------------|
|99441          |0               |0.00                           |
# Q7: Display lowest 10 average review scores per seller
## Solution
```SQL
SELECT 
    oi.seller_id,
    ROUND(AVG(orw.review_score), 2) AS average_review_score
FROM order_items oi
JOIN order_reviews orw ON oi.order_id = orw.order_id
GROUP BY oi.seller_id
ORDER BY average_review_score ASC
LIMIT 10;
```
## Output
|seller_id                         |average_review_score|
|----------------------------------|--------------------|
|cecd97bc34ed8330bd4cd15713eda670  |1.00                |
|d1a5cc844736958c11b8efab9a2b4c87  |1.00                |
|cf281cf8b7affbdfe751b29cc85580e1  |1.00                |
|60ad151920c4f6f3ebbe8cfdf6166779  |1.00                |
|c200c73f9d7e5a08ca439d6a0803da7c  |1.00                |
|f9eda05b67bef472deaddbba84aca289  |1.00                |
|9591fc341b1bfb7ef561e2968ec6e011  |1.00                |
|34aefe746cd81b7f3b23253ea28bef39  |1.00                |
|9c3a1c416c765687bc79a04113269929  |1.00                |
|da2782c804606d2a5d8e1760dbb3e7ec  |1.00                |
# Q8: What is the average delivery time and the percentage of delayed deliveries across different states?
## Solution
```SQL
SELECT 
    c.customer_state,
    ROUND(AVG(EXTRACT(DAY FROM o.order_delivered_customer_date - o.order_purchase_timestamp)), 2) AS avg_delivery_days,
    ROUND(100.0 * SUM(
        CASE 
            WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 1
            ELSE 0
        END
    ) / COUNT(*), 2) AS delayed_delivery_percentage
FROM 
    orders o
JOIN 
    customers c ON o.customer_id = c.customer_id
WHERE 
    o.order_delivered_customer_date IS NOT NULL
GROUP BY 
    c.customer_state
ORDER BY 
    delayed_delivery_percentage DESC;
```
## Output
|customer_state|avg_delivery_days|delayed_delivery_percentage|
|--------------|-----------------|---------------------------|
|AL            |24.04            |23.93                      |
|MA            |21.12            |19.67                      |
|PI            |18.99            |15.97                      |
|CE            |20.82            |15.32                      |
|SE            |21.03            |15.22                      |
|BA            |18.87            |14.04                      |
|RJ            |14.85            |13.47                      |
|TO            |17.23            |12.77                      |
|PA            |23.32            |12.37                      |
|ES            |15.33            |12.23                      |
|RR            |28.98            |12.20                      |
|MS            |15.19            |11.55                      |
|PB            |19.95            |11.03                      |
|PE            |17.97            |10.80                      |
|RN            |18.82            |10.76                      |
|SC            |14.48            |9.75                       |
|GO            |15.15            |8.18                       |
|RS            |14.82            |7.15                       |
|DF            |12.51            |7.07                       |
|MT            |17.59            |6.77                       |
|SP            |8.30             |5.89                       |
|MG            |11.54            |5.62                       |
|PR            |11.53            |5.00                       |
|AP            |26.73            |4.48                       |
|AM            |25.99            |4.14                       |
|AC            |20.64            |3.75                       |
|RO            |18.91            |2.88                       |
## Tableau Visualization
![Dashboard](https://github.com/ShaikhBorhanUddin/Brazilian_E_Commerce_Project/blob/main/Images/Sheet%208a.png?raw=true)
###
![Dashboard](https://github.com/ShaikhBorhanUddin/Brazilian_E_Commerce_Project/blob/main/Images/Sheet%208b.png?raw=true)
# Q9: Track monthly active sellers
## Solution
```SQL
SELECT 
    DATE_TRUNC('month', o.order_purchase_timestamp) AS month,
    COUNT(DISTINCT oi.seller_id) AS active_sellers
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY month
ORDER BY month;
```
## Output
|month              |active_sellers|
|-------------------|--------------|
|2016-09-01 00:00:00|3             |
|2016-10-01 00:00:00|143           |
|2016-12-01 00:00:00|1             |
|2017-01-01 00:00:00|227           |
|2017-02-01 00:00:00|427           |
|2017-03-01 00:00:00|499           |
|2017-04-01 00:00:00|506           |
|2017-05-01 00:00:00|583           |
|2017-06-01 00:00:00|539           |
|2017-07-01 00:00:00|606           |
|2017-08-01 00:00:00|708           |
|2017-09-01 00:00:00|731           |
|2017-10-01 00:00:00|776           |
|2017-11-01 00:00:00|965           |
|2017-12-01 00:00:00|861           |
|2018-01-01 00:00:00|970           |
|2018-02-01 00:00:00|947           |
|2018-03-01 00:00:00|996           |
|2018-04-01 00:00:00|1123          |
|2018-05-01 00:00:00|1115          |
|2018-06-01 00:00:00|1175          |
|2018-07-01 00:00:00|1261          |
|2018-08-01 00:00:00|1278          |
|2018-09-01 00:00:00|1             |
## Tableau Visualization
![Dashboard](https://github.com/ShaikhBorhanUddin/Brazilian_E_Commerce_Project/blob/main/Images/Sheet%209.png?raw=true)
# Q10: Identify top customers who spent the most
## Solution
```SQL
SELECT 
    c.customer_unique_id,
    ROUND(SUM(oi.price + oi.freight_value), 2) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_unique_id
ORDER BY total_spent DESC
LIMIT 10;
```
## Output
|customer_unique_id                |total_spent|
|----------------------------------|-----------|
|0a0a92112bd4c708ca5fde585afaa872  |13664.08   |
|da122df9eeddfedc1dc1f5349a1a690c  |7571.63    |
|763c8b1c9c68a0229c42c9fc6f662b93  |7274.88    |
|dc4802a71eae9be1dd28f5d788ceb526  |6929.31    |
|459bef486812aa25204be022145caa62  |6922.21    |
|ff4159b92c40ebe40454e3e6a7c35ed6  |6726.66    |
|4007669dec559734d6f53e029e360987  |6081.54    |
|5d0a2980b292d049061542014e8960bf  |4809.44    |
|eebb5dda148d3893cdaf5b5ca3040ccb  |4764.34    |
|48e1ac109decbb87765a3eade6854098  |4681.78    |
## Tableau Visualization
![Dashboard](https://github.com/ShaikhBorhanUddin/Brazilian_E_Commerce_Project/blob/main/Images/Sheet%2010.png?raw=true)
# Q11: Top 5 Products with the Most Reviews and Their Average Rating
## Solution
```SQL
SELECT 
    p.product_id,
    p.product_category_name,
    COUNT(r.review_id) AS total_reviews,
    ROUND(AVG(r.review_score), 2) AS average_rating
FROM 
    order_reviews r
JOIN 
    order_items i ON r.order_id = i.order_id
JOIN 
    products p ON i.product_id = p.product_id
GROUP BY 
    p.product_id, p.product_category_name
ORDER BY 
    total_reviews DESC
LIMIT 5;
```
## Output
|product_id                        |product_category_name|total_reviews|average_rating|
|----------------------------------|---------------------|-------------|--------------|
|aca2eb7d00ea1a7b8ebd4e68314663af  |moveis_decoracao     |524          |4.02          |
|422879e10f46682990de24d770e7f83d  |ferramentas_jardim   |484          |3.95          |
|99a4788cb24856965c36a24e339b6058  |cama_mesa_banho      |480          |3.90          |
|389d119b48cf3043d311335e499d9c6b  |ferramentas_jardim   |389          |4.11          |
|368c6c730842d78016ad823897a372db  |ferramentas_jardim   |388          |3.92          |
## Tableau Visualization
![Dashboard](https://github.com/ShaikhBorhanUddin/Brazilian_E_Commerce_Project/blob/main/Images/1122.png?raw=true)
# Q12: Identify Orders with the Lowest Ratings and Longest Delivery Time
## Solution
```SQL
SELECT 
    o.order_id,
    r.review_score,
    EXTRACT(DAY FROM o.order_delivered_customer_date - o.order_purchase_timestamp) AS delivery_days
FROM 
    orders o
JOIN 
    order_reviews r ON o.order_id = r.order_id
WHERE 
    r.review_score = 1
ORDER BY 
    delivery_days DESC
LIMIT 10;
```
## Output
|order_id                          |review_score|delivery_days|
|----------------------------------|------------|-------------|
|95e42e6aaf6264cd3e77c06b32dc3003  |1           |NULL         |
|5869074071e0f56e9085dc3742c97b2a  |1           |NULL         |
|1b9ecfe83cdc259250e1a8aca174f0ad  |1           |NULL         |
|b68d69564a79dea4776afa33d1d2fcab  |1           |NULL         |
|ee64d42b8cf066f35eac1cf57de1aa85  |1           |NULL         |
|3b4ad687e7e5190db827e1ae5a8989dd  |1           |NULL         |
|8e24261a7e58791d10cb1bf9da94df5c  |1           |NULL         |
|d3c8851a6651eeff2f73b0e011ac45d0  |1           |NULL         |
|36530871a5e80138db53bcfd8a104d90  |1           |NULL         |
|38b7efdf33dd5561f4f5d4f6e07b0414  |1           |NULL         |
```SQL
SELECT
  CASE
    WHEN review_score >= 0 AND review_score < 1 THEN '0-1 Stars'
    WHEN review_score >= 1 AND review_score < 2 THEN '1-2 Stars'
    WHEN review_score >= 2 AND review_score < 3 THEN '2-3 Stars'
    WHEN review_score >= 3 AND review_score < 4 THEN '3-4 Stars'
    WHEN review_score >= 4 AND review_score < 5 THEN '4-5 Stars'
	WHEN review_score = 5 THEN '5 Stars'
    ELSE 'Unknown'
  END AS review_score_bin,
  COUNT(*) AS review_count
FROM order_reviews
GROUP BY review_score_bin
ORDER BY review_score_bin;
```
## Output
|review_score_bin|review_count|
|----------------|------------|
|1-2 Stars       |11282       |
|2-3 Stars       |3114        |
|3-4 Stars       |8097        |
|4-5 Stars       |19007       |
|5 Stars         |56910       |
## Tableau Visualization
![Dashboard](https://github.com/ShaikhBorhanUddin/Brazilian_E_Commerce_Project/blob/main/Images/Sheet%201%20(1).png?raw=true)
