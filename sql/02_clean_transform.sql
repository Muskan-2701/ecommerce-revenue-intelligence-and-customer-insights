-- Adding delivery flag (if not already present)
update orders
set is_delivered = 
    case 
        when order_delivered_customer_date IS NOT NULL then 1
        else 0
    end;

-- Handle missing product category
update products
set product_category_name = 'Unknown'
where product_category_name IS NULL;

--Updating column name
select*from category_translation

DELETE FROM category_translation
WHERE product_category_name = 'product_category_name'
  AND product_category_english = 'product_category_name_english';
