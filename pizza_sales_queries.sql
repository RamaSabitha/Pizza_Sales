create database piz;
use piz;
select * from pizza_sales;

-- Total Revenue
select sum(total_price) as total_revenue 
from pizza_sales;

-- Average Order Value
select sum(total_price)/count(distinct order_id) as avg_order_value
from pizza_sales;

-- Total Pizzas Sold
select sum(quantity) as total_pizzas_sold 
from pizza_sales;

--Total Orders
select count(distinct order_id) as total_orders
from pizza_sales;

--Average Pizzas per Order
select cast(sum(quantity) as decimal(10,2)) /count(distinct order_id) as avg_pizzas_per_order
from pizza_sales;

-- Daily Trends for Total Orders
with daily_trends as(
select datename(weekday,order_date) as week_day,count(distinct order_id) as total_orders
from pizza_sales
group by order_date)
select week_day,sum(total_orders) as total_orders
from daily_trends
group by week_day
order by total_orders;

--Monthly Trends for Orders
with monthly_trends as(
select datename(month,order_date) as month_name,count(distinct order_id) as total_orders
from pizza_sales
group by order_date)
select month_name,sum(total_orders) as total_orders
from monthly_trends
group by month_name
order by total_orders;

-- % of Sales by Pizza Category
select pizza_category,
round(sum(total_price),2) as total_revenue,
round(sum(total_price)*100 / (select sum(total_price) from pizza_sales),2) as PCT
from pizza_sales
group by pizza_category;

-- % of Sales by Pizza Size
select pizza_size,
round(sum(total_price),2) as total_revenue,
round(sum(total_price)*100 / (select sum(total_price) from pizza_sales),2) as PCT
from pizza_sales
group by pizza_size;

--Total Pizzas sold by Pizza Category
select pizza_category, sum(quantity) as total_quantity_Sold
from pizza_sales
group by pizza_category;

-- Top 5 pizzas by Revenue
select top 5 pizza_name,sum(total_price) as total_revenue
from pizza_sales
group by pizza_name
order by total_revenue desc;

--Bottom 5 Pizzas by Revenue
select top 5 pizza_name,sum(total_price) as total_revenue
from pizza_sales
group by pizza_name
order by total_revenue asc;

-- Top 5 pizzas by Quantity
select top 5 pizza_name,sum(quantity) as total_pizza_sold
from pizza_sales
group by pizza_name
order by total_pizza_sold desc;

--Bottom 5 Pizzas by Quantity
select top 5 pizza_name,sum(quantity) as total_pizza_sold
from pizza_sales
group by pizza_name
order by total_pizza_sold asc;

-- Top 5 pizzas by Total Orders
select top 5 pizza_name,count(distinct order_id) as total_orders
from pizza_sales
group by pizza_name
order by total_orders desc;

-- Bottom 5 pizzas by Total Orders
select top 5 pizza_name,count(distinct order_id) as total_orders
from pizza_sales
group by pizza_name
order by total_orders asc;