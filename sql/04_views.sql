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

--MONTHLY REVENUE VIEW
Create view view_monthly_rev as
select
	format(o.order_purchase_timestamp,'yyyy-MM') as month,
	sum(oi.price+oi.freight_value) as revenue
from orders o
join order_items oi
	on o.order_id=oi.order_id
group by format(o.order_purchase_timestamp,'yyyy-MM');
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