create database Olist_Project;

CREATE TABLE customers (
    customer_id VARCHAR PRIMARY KEY,
    customer_unique_id VARCHAR,
    customer_zip_code_prefix INT,
    customer_city VARCHAR,
    customer_state VARCHAR
);

CREATE TABLE orders (
    order_id VARCHAR PRIMARY KEY,
    customer_id VARCHAR,
    order_status VARCHAR,
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_id VARCHAR,
    order_item_id INT,
    product_id VARCHAR,
    seller_id VARCHAR,
    shipping_limit_date TIMESTAMP,
    price NUMERIC,
    freight_value NUMERIC,
    PRIMARY KEY (order_id, order_item_id)
);

CREATE TABLE order_payments (
    order_id VARCHAR,
    payment_sequential INT,
    payment_type VARCHAR,
    payment_installments INT,
    payment_value NUMERIC
);

CREATE TABLE order_reviews (
    review_id VARCHAR PRIMARY KEY,
    order_id VARCHAR,
    review_score INT,
    review_comment_title VARCHAR,
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP
);

CREATE TABLE products (
    product_id VARCHAR PRIMARY KEY,
    product_category_name VARCHAR,
    product_name_length INT,
    product_description_length INT,
    product_photos_qty INT,
    product_weight_g NUMERIC,
    product_length_cm NUMERIC,
    product_height_cm NUMERIC,
    product_width_cm NUMERIC
);

CREATE TABLE sellers (
    seller_id VARCHAR PRIMARY KEY,
    seller_zip_code_prefix INT,
    seller_city VARCHAR,
    seller_state VARCHAR
);

CREATE TABLE product_category_name_translation (
    product_category_name VARCHAR PRIMARY KEY,
    product_category_name_english VARCHAR
);

CREATE TABLE geolocation (
    geolocation_zip_code_prefix INT,
    geolocation_lat NUMERIC,
    geolocation_lng NUMERIC,
    geolocation_city VARCHAR,
    geolocation_state VARCHAR
);

select * from customers;

select * from geolocation;

select * from order_items;

select * from order_payments;

select * from order_reviews;

select * from orders;

select * from product_category_name_translation;

select * from products;

select * from sellers;

------------------------------------------------------------------------

-- Q1: Display total sales revenue per month

SELECT 
    DATE_TRUNC('month', order_purchase_timestamp) AS month,
    SUM(oi.price + oi.freight_value) AS total_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY month
ORDER BY month;

--Q2: Show top 5 most selling product categories

SELECT 
    pct.product_category_name_english,
    COUNT(oi.product_id) AS total_sales
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN product_category_name_translation pct ON p.product_category_name = pct.product_category_name
GROUP BY pct.product_category_name_english
ORDER BY total_sales DESC
LIMIT 5;

--Q3: What is the average delivery time by state?

SELECT 
    c.customer_state,
    AVG(DATE_PART('day', o.order_delivered_customer_date - o.order_purchase_timestamp)) AS avg_delivery_days
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_state
ORDER BY avg_delivery_days;

--Q4: Display top 10 sellers by revenue

SELECT 
    s.seller_id,
    SUM(oi.price + oi.freight_value) AS total_revenue
FROM order_items oi
JOIN sellers s ON oi.seller_id = s.seller_id
GROUP BY s.seller_id
ORDER BY total_revenue DESC
LIMIT 10;

--Q5: Display most preferred payment methods

SELECT 
    payment_type,
    COUNT(*) AS total_transactions,
    SUM(payment_value) AS total_value
FROM order_payments
GROUP BY payment_type
ORDER BY total_value DESC;

--Q6: Show customer repeat purchase rate

SELECT
    COUNT(DISTINCT customer_id) AS total_customers,
    COUNT(DISTINCT CASE WHEN customer_order_count > 1 THEN customer_id END) AS repeat_customers,
    ROUND(100.0 * COUNT(DISTINCT CASE WHEN customer_order_count > 1 THEN customer_id END) / COUNT(DISTINCT customer_id), 2) AS repeat_purchase_rate_percentage
FROM (
    SELECT customer_id, COUNT(order_id) AS customer_order_count
    FROM orders
    GROUP BY customer_id
) subquery;

--Q7: Display average review score per seller

SELECT 
    oi.seller_id,
    ROUND(AVG(orw.review_score), 2) AS average_review_score
FROM order_items oi
JOIN order_reviews orw ON oi.order_id = orw.order_id
GROUP BY oi.seller_id
ORDER BY average_review_score DESC;

--Q8: What is the average delivery time and the percentage of delayed deliveries across different states?

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

--Q9: Track monthly active sellers

SELECT 
    DATE_TRUNC('month', o.order_purchase_timestamp) AS month,
    COUNT(DISTINCT oi.seller_id) AS active_sellers
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY month
ORDER BY month;

--Q10: Identify top customers who spent the most

SELECT 
    c.customer_unique_id,
    ROUND(SUM(oi.price + oi.freight_value), 2) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_unique_id
ORDER BY total_spent DESC
LIMIT 10;

--Q11: Top 5 Products with the Most Reviews and Their Average Rating

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

--Q12: Identify Orders with the Lowest Ratings and Longest Delivery Time

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
