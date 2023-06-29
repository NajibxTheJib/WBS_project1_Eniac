/*

Question 1

99441

*/

SELECT 
    COUNT(*) AS orders_count
FROM
    orders;
;

/*

Question 2



*/

SELECT
	order_status,
    COUNT(*) AS orders
FROM
	orders
GROUP BY
	order_status
;

/*

Question 3



*/

SELECT 
    YEAR(order_purchase_timestamp) AS year_,
    MONTH(order_purchase_timestamp) AS month_,
    COUNT(customer_id)
FROM
    orders
GROUP BY year_ , month_
ORDER BY year_ , month_;

/*

Question 4



*/

SELECT 
    COUNT(DISTINCT product_id) AS products_count
FROM
    products;
    
    /*

Question 5



*/

SELECT 
    product_category_name, 
    COUNT(DISTINCT product_id) AS n_products
FROM
    products
GROUP BY product_category_name
ORDER BY COUNT(product_id) DESC;



/*

Question 6



*/

SELECT 
	count(DISTINCT product_id) AS n_products
FROM
	order_items;
    
    /*

Question 7



*/

SELECT 
    MIN(price) AS cheapest, 
    MAX(price) AS most_expensive
FROM 
	order_items;
    
 /*

Question 8



*/

SELECT 
	MAX(payment_value) as highest,
    MIN(payment_value) as lowest
FROM
	order_payments;
    
