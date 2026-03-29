-- ///// ****** E-Commerce Data ****** ///// ---

--Create table
create table customers (
                customer_id serial primary key,
                first_name varchar (50),
                last_name varchar (50),
                gender varchar (50),
                date_of_birth date,
                city varchar (50)    );

--show table of custmers
select * from customers;

--drop table
drop table customers;

--Retrieve all customers from mumbai
select * from customers where city = 'Mumbai';

--Show total customers per city
select city, count(*) as total_customers
from customers where city is not null
group by city
order by total_customers desc;

--Retrieve all customers born after 1995
select * from customers where date_of_birth > '1995-01-01';

--Find youngest customers
select * from customers
where date_of_birth =(select max(date_of_birth) from customers
where date_of_birth is not null );

--Count total number of customers
select count (*) as total_customers
from customers;

--List all unique cities in desc order
select distinct city from customers
order by city asc;

--Rank customers by age  ( without null)
select first_name , last_name , date_of_birth ,
rank() over (order by date_of_birth asc) as age_rank
from customers where date_of_birth is not null;

--show top 5 cities with most customers
select city, count(*) as total_customers
from customers group by city order by total_customers desc limit 5;

--Find cities with more than 5 customers
select city, count(*) as total_customers
from customers group by city having count (*) >5;

--Find customers who live in the same city as Arjun
select first_name , last_name , date_of_birth, city from customers
where city = (select city from customers where first_name = 'Arjun');

--Find customers born between 1990 to 2000
select * from customers where date_of_birth
between '1990-01-01' and '2000-01-01';

-- Order table import for joins
CREATE TABLE orders (
    order_id        SERIAL PRIMARY KEY,
    customer_id     INT,
    order_date      DATE,
    total_amount    NUMERIC(10,2),
    discount_amount NUMERIC(10,2),
    final_amount    NUMERIC(10,2),
    payment_method  VARCHAR(30),
    payment_status  VARCHAR(20),
    order_status    VARCHAR(20),
    delivery_date   DATE  );

select * from orders;

--Show all customers who placed orders
SELECT c.first_name, c.last_name,
        o.order_date, o.final_amount
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id;

-- Show all customers with delivered orders
SELECT c.first_name, c.last_name, c.city,
        o.order_date, o.final_amount
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.order_status = 'Delivered';

-- Find customers who never placed any order
SELECT c.first_name, c.last_name, c.city
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- clear all null value from both tables 

SELECT DISTINCT ON (o.order_id)
    c.customer_id,
    c.first_name,
    c.last_name,
    c.gender,
    c.date_of_birth,
    c.city,
    o.order_id,
    o.order_date,
    o.total_amount,
    o.discount_amount,
    o.final_amount,
    o.payment_method,
    o.payment_status,
    o.order_status,
    o.delivery_date
FROM customers c
INNER JOIN orders o 
    ON c.customer_id = o.customer_id
WHERE c.customer_id IS NOT NULL
  AND c.first_name IS NOT NULL
  AND c.last_name IS NOT NULL
  AND c.gender IS NOT NULL
  AND c.date_of_birth IS NOT NULL
  AND c.city IS NOT NULL
  AND o.order_id IS NOT NULL
  AND o.order_date IS NOT NULL
  AND o.total_amount IS NOT NULL
  AND o.discount_amount IS NOT NULL
  AND o.final_amount IS NOT NULL
  AND o.payment_method IS NOT NULL
  AND o.payment_status IS NOT NULL
  AND o.order_status IS NOT NULL
  AND o.delivery_date IS NOT NULL
ORDER BY o.order_id;
