-- KPI 1: TOTAL REVENUE
SELECT
    SUM(price + freight_value) AS total_revenue
FROM order_items;

-- KPI 2: MONTHLY REVENUE
SELECT
    FORMAT(o.order_purchase_timestamp, 'yyyy-MM') AS month,
    SUM(oi.price + oi.freight_value) AS revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY FORMAT(o.order_purchase_timestamp, 'yyyy-MM')
ORDER BY month;

-- KPI 3: AVERAGE ORDER VALUE (AOV)
WITH revenue_cte AS (
    SELECT SUM(price + freight_value) AS total_revenue
    FROM order_items
),
orders_cte AS (
    SELECT COUNT(DISTINCT order_id) AS total_orders
    FROM orders
)
SELECT
    ROUND(r.total_revenue * 1.0 / o.total_orders, 2) AS AOV
FROM revenue_cte r, orders_cte o;

-- KPI 4: TOTAL ORDERS AND CUSTOMERS
SELECT
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers
FROM orders;

-- KPI 5: TOP 10 CATEGORIES BY REVENUE (English names)
SELECT TOP 10
    ISNULL(ct.product_category_english, 'Other') AS category,
    SUM(oi.price + oi.freight_value) AS revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
LEFT JOIN category_translation ct
    ON p.product_category_name = ct.product_category_name
GROUP BY ct.product_category_english
ORDER BY revenue DESC;

-- KPI 6: DELIVERY PERFORMANCE
SELECT
    is_delivered,
    COUNT(*) AS orders
FROM orders
GROUP BY is_delivered;


