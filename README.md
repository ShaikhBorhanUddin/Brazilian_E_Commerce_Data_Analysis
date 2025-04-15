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

- Kaggle: [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

## Database Setup

1. **Create Database**
   - Database Name: `Olist_Project`

2. **Tables Created**
   - `customers`
   - `geolocation`
   - `order_items`
   - `order_payments`
   - `order_reviews`
   - `orders`
   - `product_category_name_translation`
   - `products`
   - `sellers`

3. **Data Import**
   - Use `COPY` or import tool of your SQL client to upload data from CSVs into the corresponding tables.

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
## SQL Queries Included

### Data Checks
- Quick `SELECT *` from each table to verify data import.

### Analytical Questions and Solutions

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
## Insights Extracted

- Seasonal trends in sales revenue
- Product category performance
- Seller and customer behavior patterns
- Delivery performance across regions
- Customer satisfaction analysis via reviews

## Tableau Visualizations
Some visualizations derived from SQL queries are included here.
<div align="center"> <img src="Images/Sheet 3 (1).png" alt="Order Status Distribution" width="45%" /> <img src="Images/Sheet 9.png" alt="Sales by State" width="46%" /> <br><br> <img src="Images/Sheet 8a.png" alt="Delivery Time Analysis" width="45%" /> <img src="Images/Sheet 8b.png" alt="Payment Type Distribution" width="45%" /> </div>
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

