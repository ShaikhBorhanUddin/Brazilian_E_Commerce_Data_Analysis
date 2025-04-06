# Brazilian E-Commerce Public Dataset (Olist) SQL Project

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

## Schema Overview

- **Customers**: Customer details including city and state.
- **Geolocation**: Geolocation mapping by zip code.
- **Orders**: Order statuses and timestamps.
- **Order Items**: Details of items in each order.
- **Order Payments**: Payment details per order.
- **Order Reviews**: Customer reviews and scores.
- **Products**: Product details including category and measurements.
- **Sellers**: Seller details including location.
- **Product Category Name Translation**: Translations of product categories from Portuguese to English.

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

## Insights Extracted

- Seasonal trends in sales revenue
- Product category performance
- Seller and customer behavior patterns
- Delivery performance across regions
- Customer satisfaction analysis via reviews

## How to Use

1. Clone the repository.
2. Import the SQL file into your PostgreSQL environment.
3. Load the dataset CSVs into the respective tables.
4. Run the queries to explore insights!

## Tools & Technologies

- PostgreSQL
- SQL
- Kaggle Dataset
- DBeaver / PgAdmin (optional for visual interface)

## License

This project is licensed for educational and learning purposes.

---

### Author

Shaikh Borhan Uddin 

Project Date: April 2025

