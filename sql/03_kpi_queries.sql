--KPI 1: TOTAL REVENUE
Select 
	sum(price+freight_value) as total_revenue
from order_items;

--KPI 2: MONTHLY REVENUE
Select	
	format(o.order_purchase_timestamp,'yyyy-MM') as month,
	sum(oi.price+oi.freight_value) as revenue
from orders o
join order_items oi
	on o.order_id=oi.order_id
group by format(o.order_purchase_timestamp,'yyyy-MM')
order by month;

--KPI 3: AVERAGE ORDER VALUE
With revenue_cte as (
	select sum(price+freight_value) as total_revenue
	from order_items
),
orders_cte as(
	select count(distinct order_id) as total_orders
	from orders
)
select
	r.total_revenue*1.0/o.total_orders as AOV
from revenue_cte r, orders_cte o;

--KPI 4: TOTAL ORDERS AND CUSTOMERS
select
	count(distinct order_id) as total_orders,
	count(distinct customer_id) as total_customers
from orders;

--KPI 5: TOP CATEGORIES
select top 10
	isnull(ct.column2,'Other') as category,
	SUM(oi.price+oi.freight_value) as revenue
from order_items oi
join products p
	on oi.product_id=p.product_id
left join category_translation ct
	on p.product_category_name=ct.column2
group by ct.column2
order by revenue desc;

--KPI 5: DELIVERY PERFORMANCE
select
	is_delivered,
	count(*) as orders
from orders
group by is_delivered

