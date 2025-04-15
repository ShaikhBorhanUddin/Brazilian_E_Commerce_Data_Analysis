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
This project explores the Brazilian E-Commerce Public Dataset by Olist using PostgreSQL.  
The goal is to build a relational database and run analytical queries to extract insights about sales, customers, sellers, and logistics.

## Dataset Source

Kaggle: [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

## Database Setup

1. **Create Database**
   - Database Name: `Olist_Project`

2. **Tables Created**

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
The following analytical questions are addressed in this project. Relevant visualizations (where applicable) in tableau are also provided.
1. **Total sales revenue per month**
2. **Top 5 most selling product categories**
3. **Average delivery time by state**
4. **Top 10 sellers by revenue**
5. **Most preferred payment methods**
6. **Customer repeat purchase rate**
7. **Average review score per seller**
8. **Average delivery time and % of delayed deliveries by state**
9. **Monthly active sellers**
10. **Top customers by total spend**
11. **Top 5 products with most reviews and average ratings**
12. **Orders with the lowest ratings and longest delivery time**

For solutions (SQL codes), outputs and visualization, see [`Solutions_and_Visualizations.md`](https://github.com/ShaikhBorhanUddin/Brazilian_E_Commerce_Project/blob/main/Solutions_and_Visualization.md)

These analytical questions play a crucial role in driving business intelligence by uncovering actionable insights across various operational and strategic areas. Tracking total sales revenue per month helps identify seasonal trends and forecast demand, while analyzing the top 5 most selling product categories supports inventory planning and marketing focus. Understanding the average delivery time by state, along with the percentage of delayed deliveries, enables businesses to optimize logistics and enhance customer satisfaction. Identifying the top 10 sellers by revenue reveals high-performing partners who can be prioritized for support or incentives. Insights into preferred payment methods help streamline the checkout experience and offer targeted promotions. Evaluating customer repeat purchase rates measures loyalty and long-term engagement, whereas average review scores per seller reflect service quality and reliability. Monthly active sellers indicate the platform’s vibrancy and can guide seller retention strategies. Recognizing top customers by total spend allows businesses to tailor loyalty programs and personalized services. Examining the most reviewed and highest-rated products helps in refining promotional efforts, while identifying orders with the lowest ratings and longest delivery times uncovers operational bottlenecks that need immediate attention. Altogether, these metrics form a comprehensive foundation for data-driven decision-making and long-term business growth.

## Sample Queries
```sql
SELECT 
    DATE_TRUNC('month', order_purchase_timestamp) AS month,
    SUM(oi.price + oi.freight_value) AS total_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY month
ORDER BY month;
```
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

## Tableau Visualizations
Some visualizations derived from SQL queries like average delivery time, days, active sellers count and delays are included here.

<div align="center" style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 20px;">
  <img src="Images/Sheet 3 (1).png" alt="Order Status Distribution" width="49%" />
  <img src="Images/Sheet 9.png" alt="Sales by State" width="49%" />
  <img src="Images/Sheet 8a.png" alt="Delivery Time Analysis" width="49%" />
  <img src="Images/Sheet 8b.png" alt="Payment Type Distribution" width="49%" />
</div>

## How to Use

1. Clone the repository.
2. Import the SQL file into your PostgreSQL environment.
3. Load the dataset CSVs into the respective tables.
4. Run the queries to explore insights!

## Tools & Technologies

- PostgreSQL
- SQL
- Kaggle
- Microsoft Excel
- Tableau

## License

This project is licensed for educational and learning purposes.

---

### Author

Shaikh Borhan Uddin 

Project Date: April 2025

