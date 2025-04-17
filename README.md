# Brazilian E-Commerce Public Dataset (Olist) SQL Project
<!-- Project Badges -->
![SQL](https://img.shields.io/badge/SQL-PostgreSQL%20%7C%20MySQL%20%7C%20SQLite-blue?logo=postgresql&logoColor=white)
![Made with](https://img.shields.io/badge/Made%20with-SQL-blue?logo=database)
![License](https://img.shields.io/github/license/ShaikhBorhanUddin/Inventory_Management_Project)
![Repo Size](https://img.shields.io/github/repo-size/ShaikhBorhanUddin/Inventory_Management_Project)
![Stars](https://img.shields.io/github/stars/ShaikhBorhanUddin/Inventory_Management_Project?style=social)
![Forks](https://img.shields.io/github/forks/ShaikhBorhanUddin/Inventory_Management_Project?style=social)
![Last Commit](https://img.shields.io/github/last-commit/ShaikhBorhanUddin/Inventory_Management_Project)
![Issues](https://img.shields.io/github/issues/ShaikhBorhanUddin/Inventory_Management_Project)
![PostgreSQL](https://img.shields.io/badge/Database-PostgreSQL-336791?logo=postgresql&logoColor=white)
![Tableau](https://img.shields.io/badge/Tableau-Data%20Visualization-E97627?logo=Tableau&logoColor=white)
![Git](https://img.shields.io/badge/Version%20Control-Git-orange?logo=git&logoColor=white)
![GitHub](https://img.shields.io/badge/Host-GitHub-black?logo=github)
![Project Status](https://img.shields.io/badge/Project-Completed-brightgreen?style=flat-square)
![Dashboard](https://github.com/ShaikhBorhanUddin/Brazilian_E_Commerce_Project/blob/main/Images/olist.png?raw=true)
This project leverages the Brazilian E-Commerce Public Dataset by Olist to perform business intelligence analysis using PostgreSQL. The objective is to design a structured relational database and execute data-driven queries that uncover strategic insights related to sales performance, customer behavior, seller dynamics, and logistics efficiency, ultimately supporting informed business decision-making and operational optimization.

## Dataset Source

Kaggle: [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

This dataset is a valuable contribution from Olist, the leading department store in Brazilian marketplaces. Olist empowers small businesses throughout Brazil by providing easy access to a wide range of sales channels under one convenient contract. By selling products through the Olist Store, merchants can efficiently reach customers and seamlessly ship their orders with the help of Olist's trusted logistics partners. Discover more about what Olist offers at www.olist.com.

Upon purchasing a product from the Olist Store, sellers are promptly notified to fulfill the order, ensuring a swift and efficient process. Once the product is delivered or the estimated delivery date has passed, customers receive an email inviting them to complete a satisfaction survey. This valuable feedback allows them to rate their shopping experience and share their thoughts, helping Olist and its sellers to continually improve.

## Database Setup

1. **Create Database**

   Database Name: `Olist_Project`

3. **Tables Created**

   `customers` `geolocation` `order_items` `order_payments` `order_reviews` `orders`
   `product_category_name_translation` `products` `sellers`

4. **Data Import**

   Use `COPY` or import tool of your SQL client to upload data from CSVs into the corresponding tables.

##  Database Schema

The project consists of 9 main tables:

| Table Name                          | Description                                    |
|-------------------------------------|------------------------------------------------|
| `customers`                         | Customer IDs, unique IDs, city, state          |
| `orders`                            | Order statuses, timestamps, customer IDs       |
| `order_items`                       | Product, seller, price, freight per order item |
| `order_payments`                    | Payment methods, installments, payment value   |
| `order_reviews`                     | Customer ratings and review details            |
| `products`                          | Product details, dimensions, category          |
| `sellers`                           | Seller IDs, location, zip code                 |
| `product_category_name_translation` | Product category translations (Portuguese → English) |
| `geolocation`                       | Geolocation details by zip code                |

## SQL Queries
The following analytical questions are addressed in this project. Relevant visualizations (where applicable) in Tableau are also provided.

**`Total sales revenue per month`** **`Top 5 most selling product categories`** **`Average delivery time by state`** **`Top 10 sellers by revenue`** **`Most preferred payment methods`**
**`Customer repeat purchase rate`** **`Average review score per seller`** **`Average delivery time and % of delayed deliveries by state`** **`Monthly active sellers`**
**`Top customers by total spend`** **`Top 5 products with most reviews and average ratings`** **`Orders with the lowest ratings and longest delivery time`**

For solutions (SQL codes), outputs and visualization, see [`Solutions_and_Visualizations.md`](https://github.com/ShaikhBorhanUddin/Brazilian_E_Commerce_Project/blob/main/Solutions_and_Visualization.md)

These analytical questions play a crucial role in driving business intelligence by uncovering actionable insights across various operational and strategic areas. Tracking total sales revenue per month helps identify seasonal trends and forecast demand, while analyzing the top 5 most selling product categories supports inventory planning and marketing focus. Understanding the average delivery time by state, along with the percentage of delayed deliveries, enables businesses to optimize logistics and enhance customer satisfaction. Identifying the top 10 sellers by revenue reveals high-performing partners who can be prioritized for support or incentives. Insights into preferred payment methods help streamline the checkout experience and offer targeted promotions. Evaluating customer repeat purchase rates measures loyalty and long-term engagement, whereas average review scores per seller reflect service quality and reliability. Monthly active sellers indicate the platform’s vibrancy and can guide seller retention strategies. Recognizing top customers by total spend allows businesses to tailor loyalty programs and personalized services. Examining the most reviewed and highest-rated products helps in refining promotional efforts, while identifying orders with the lowest ratings and longest delivery times uncovers operational bottlenecks that need immediate attention. Altogether, these metrics form a comprehensive foundation for data-driven decision-making and long-term business growth.

## Sample Queries

Some sql queries used in this project with explanations are included in this section.
```sql
SELECT 
    DATE_TRUNC('month', order_purchase_timestamp) AS month,
    SUM(oi.price + oi.freight_value) AS total_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY month
ORDER BY month;
```
**Explanation:**
This query calculates monthly total revenue by summing product prices and freight values from customer orders. It uses DATE_TRUNC('month', order_purchase_timestamp) to extract the month from each order's timestamp and labels it as month. The SUM(oi.price + oi.freight_value) expression adds the product price and freight cost to compute the total revenue for each order item. The orders table (aliased as o) is joined with the order_items table (aliased as oi) using the order_id to combine order-level and item-level data. The results are grouped by month using GROUP BY month to aggregate the revenue for each month and then sorted chronologically with ORDER BY month.
```sql
SELECT 
    c.customer_state,
    AVG(DATE_PART('day', o.order_delivered_customer_date - o.order_purchase_timestamp)) AS avg_delivery_days
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_state
ORDER BY avg_delivery_days;
```
**Explanation:**
This query calculates the average delivery time (in days) for each customer state. It selects customer_state from the customers table and computes the average number of days between the order purchase date and the delivery date using DATE_PART('day', o.order_delivered_customer_date - o.order_purchase_timestamp). Only orders with a non-null order_delivered_customer_date are considered, ensuring that only completed deliveries are included. The orders table (aliased as o) is joined with the customers table (aliased as c) on customer_id to associate each order with its customer’s state. Results are grouped by customer_state to calculate the average delivery days per state and sorted in ascending order by avg_delivery_days to show which states receive deliveries fastest.
```sql
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
**Explanation:**
This query retrieves the top 10 customers based on total spending, combining product prices and freight costs. It selects each customer's customer_unique_id and calculates the total amount spent using SUM(oi.price + oi.freight_value), rounded to two decimal places with ROUND(..., 2). The customers table is joined with orders using customer_id, and orders is further joined with order_items using order_id to access item-level prices and shipping costs. The results are grouped by customer_unique_id to get spending totals per customer, ordered in descending order of total_spent, and limited to the top 10 highest spenders.
## Tableau Visualizations
To derive deeper insights from the Brazilian E-Commerce Public Dataset, several Tableau visualizations were created from sql queries. These visualizations help identify business trends, customer behaviors, and operational efficiencies that are crucial for data-driven decision-making. Below is a breakdown of some visualizations and their significance.

<img src="Images/Sheet 3 (1).png" alt="Order Status Distribution" width="60%" />

This bar chart above displays the average number of days it takes for orders to be delivered in each state. Efficient delivery is a key factor in customer satisfaction. States with significantly higher delivery times can signal challenges in logistics, infrastructure, or supplier distribution. This visualization is useful for identifying areas where delivery optimization or partnership with local carriers may be needed.

<img src="Images/Sheet 9.png" alt="Sales by State" width="60%" />

This line chart tracks the number of unique sellers who made at least one sale in each month. It serves as an indicator of marketplace engagement from the seller side. A growing number of active sellers may suggest a healthy platform attracting more vendors, while a drop might hint at increased competition, seasonal inactivity, or dissatisfaction among sellers. This metric is useful for gauging the platform’s supply-side dynamics and ensuring a diverse and competitive catalog of products.

<img src="Images/Sheet 8a.png" alt="Delivery Time Analysis" width="60%" />

This bar chart represents the average number of days it takes to deliver an order in each Brazilian state. The calculation is based on the difference between the order purchase timestamp and the delivery date. States with longer delivery times may indicate challenges in logistics, shipping infrastructure, or geographical factors. By identifying states with higher-than-average delivery times, businesses can focus on optimizing their supply chain and improving customer satisfaction in those regions. This visualization also helps assess the efficiency of the platform's overall delivery system.

## How to Use

   Begin by cloning this repository to your local machine using:
```bash
git clone https://github.com/ShaikhBorhanUddin/Brazilian_E_Commerce_Data_Analysis.git
```

   Create a new PostgreSQL database and import the provided SQL schema to initialize the necessary tables. Populate the database by importing the corresponding CSV files into their respective tables. This can be done using PostgreSQL’s COPY command or your preferred database management tool. Navigate to the sql_queries directory to run pre-written SQL scripts or craft your own to uncover valuable business insights from the data.

## Tools & Technologies

`PostgreSQL` `Kaggle` `Microsoft Excel` `Tableau`

In this project, PostgreSQL was used for querying and managing the dataset. It served as the primary database management system, enabling efficient data manipulation, aggregation, and analysis through SQL queries. PostgreSQL's robust support for relational data and complex queries was crucial for processing the large dataset. Excel was utilized for initial data exploration and cleaning. It provided an easy-to-use interface for quickly reviewing the dataset, handling missing values, and performing basic transformations. Excel's versatility also made it convenient for manually inspecting data and creating preliminary analyses before importing it into PostgreSQL. Tableau played a key role in visualizing the data. With its powerful features for creating interactive dashboards and reports, Tableau enabled the creation of insightful visualizations, such as sales trends, revenue distribution, and delivery times by region. These visualizations helped in uncovering meaningful patterns and making the data more accessible to stakeholders. Finally, the dataset used in the project was sourced from Kaggle. Kaggle provided a high-quality, publicly available dataset that served as the foundation for the analysis. It included a comprehensive set of records that helped in exploring various aspects of Brazilian e-commerce, such as order details, product information, and customer demographics.
## License

This project is licensed for educational and learning purposes. It is free to use, modify, and distribute, provided that the original author(s) are credited.

---

### Author

Shaikh Borhan Uddin 

Project Date: April 2025

