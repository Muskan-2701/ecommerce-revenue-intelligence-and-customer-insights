--REVENUE VIEW
Create view view_rev as
select
	o.order_id,
	o.customer_id,
	o.order_purchase_timestamp,
	oi.price,
	oi.freight_value,
	(oi.price+oi.freight_value) as revenue
from orders o
join order_items oi
	on o.order_id=oi.order_id;
GO

-- MONTHLY REVENUE VIEW 
Create view view_monthly_rev as
select
    DATEFROMPARTS(YEAR(o.order_purchase_timestamp), MONTH(o.order_purchase_timestamp), 1) as month_date,
    sum(oi.price + oi.freight_value) as revenue
from orders o
join order_items oi
    on o.order_id = oi.order_id
group by 
    DATEFROMPARTS(YEAR(o.order_purchase_timestamp), MONTH(o.order_purchase_timestamp), 1);
GO

-- CATEGORY REVENUE VIEW
Create view vw_category_revenue as
select
	p.product_category_name,
	sum(oi.price + oi.freight_value) AS revenue
from dbo.order_items oi
join dbo.products p 
    on oi.product_id = p.product_id
group by p.product_category_name;

select*from view_monthly_rev