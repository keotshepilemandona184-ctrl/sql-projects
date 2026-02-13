northwind.sql
/* =========================================================
   SQL PROJECT — NORTHWIND ANALYSIS
   Author: Keotshepile Mandona
   ========================================================= */


/* 1️⃣ Customers per country */
SELECT COUNT(*) AS total_customers, country
FROM customers
GROUP BY country
ORDER BY COUNT(*) DESC
LIMIT 5;


/* 2️⃣ Countries with more than 5 customers */
SELECT count(*) as "total number of customers per country", 
country from customers group by country order by count(*)
desc ;


/* 3️⃣ Total orders per customer */
SELECT count(order_id) "number of orders" , company_name FROM Customers
left join orders on orders.customer_id = customers.customer_id
group by company_name
order by "number of orders" asc;


/* 4️⃣ Customers with more than 10 orders */
SELECT count(order_id) as "number_of_orders", contact_name, orders.customer_id
from customers 
join orders on customers.customer_id = orders.customer_id
group by contact_name,orders.customer_id
having count(order_id) >10
order by number_of_orders desc;


/* 5️⃣ Orders handled per employee */
select count(order_id),  last_name, first_name, employees.employee_id
from employees
left join orders on employees.employee_id= orders.employee_id
group by last_name, first_name,employees.employee_id
order by count(order_id) asc;


/* 6️⃣ Total revenue per order */
select order_id,sum(unit_price*quantity- quantity*unit_price*discount) as "total revenue per order id " from order_details
group by order_id;


/* 7️⃣ Total revenue per customer */
select customers.customer_id,contact_name, sum(unit_price*quantity-unit_price*quantity*discount) as "total_sales_per_customer"
from customers 
left join orders on orders.customer_id=customers.customer_id
left join order_details on orders.order_id=order_details.order_id
group by customers.customer_id, contact_name
order  by total_sales_per_customer desc;


/* 8️⃣ Top 5 best-selling products */
select sum(order_details.unit_price*quantity- order_details.discount*order_details.unit_price*quantity) as "sale_per_product",product_name,products.product_id 
from products 
join order_details on order_details.product_id = products.product_id
group by product_name,products.product_id 
order by sale_per_product desc
limit 5;


/* 9️⃣ Orders with freight category + total order value */
select orders.order_id,company_name,freight,
SUM(unit_price * quantity * (1 - discount)) as "total_revenue",
case when freight <20 then 'small'
when freight between 20 and 50 then 'medium'
else 'large'
end as "category"
from orders
join order_details on orders.order_id=order_details.order_id
join customers on orders.customer_id=customers.customer_id
group by orders.order_id,company_name;




/* 🔟 Customer revenue segmentation (>1000 only) */
select customers.customer_id,company_name,count(company_name) as "numberofnames",
sum(unit_price*quantity-unit_price*quantity*discount) as "revenue", case when 
sum(unit_price*quantity-unit_price*quantity*discount) <500 then 'small'
when sum(unit_price*quantity-unit_price*quantity*discount) between 500 and 1000 then 'medium'
else 'high'
end as "rev"
from customers 
left join orders on customers.customer_id=orders.customer_id
join order_details on order_details.order_id = orders.order_id
group by customers.customer_id,company_name
having sum(unit_price*quantity-unit_price*quantity*discount) >1000;


