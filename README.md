# E-Commerce-Data-analysis
 SQL Project
Overview
A SQL project built on a simulated E-Commerce dataset using PostgreSQL. Covers database design, data cleaning, and analysis using joins, subqueries, and window functions.
Tables
customers — customer_id, first_name, last_name, gender, date_of_birth, city
orders — order_id, customer_id, order_date, total_amount, discount_amount, final_amount, payment_method, payment_status, order_status, delivery_date
What's Covered
Customer filtering by city, age, and date range
Aggregations — count per city, top 5 cities, HAVING clause
Subqueries — youngest customer, same-city customers
Window function — RANK() by age
Joins — INNER JOIN, LEFT JOIN, finding customers with no orders
Data cleaning — removing NULLs across both tables
