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
CREATE VIEW vw_category_revenue AS
SELECT
    c.product_category_english,
    SUM(oi.price + oi.freight_value) AS revenue
FROM order_items oi
JOIN products p 
    ON oi.product_id = p.product_id
JOIN category_translation c
    ON p.product_category_name = c.product_category_name
GROUP BY c.product_category_english;


select*from view_monthly_rev
select*from view_rev
select*from vw_category_revenue



