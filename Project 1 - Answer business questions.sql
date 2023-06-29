/*

Answer Business questions

We determinate the following products as category Tech : 
'audio'
'cine_photo' / 'cine_foto'
'console_games' 
'electronics' 
'computer' 
'computers_accessories' 
'pc_gamer' 
'telephony'

*/


/*

How many products of these tech categories have been sold 
(within the time window of the database snapshot)? What percentage does that 
represent from the overall number of products sold?

15584 rows returned for the tech category sells

Percentage = (15584 / 112650) x 100
Percentage = 13,83 %

*/

SELECT
	product_id,
    product_category_name
FROM
	products
GROUP BY
	product_id
;
	
SELECT 
	orders.order_id, order_items.product_id , products.product_category_name , product_category_name_translation.product_category_name_english
FROM 
	orders
JOIN 
	order_items 
		ON orders.order_id = order_items.order_id
JOIN products 
	ON order_items.product_id = products.product_id
JOIN product_category_name_translation 
	ON products.product_category_name = product_category_name_translation.product_category_name
;

SELECT 
	orders.order_id, 
    order_items.product_id , 
    products.product_category_name , 
    product_category_name_translation.product_category_name_english
FROM 
	orders
JOIN 
	order_items 
		ON orders.order_id = order_items.order_id
JOIN products 
	ON order_items.product_id = products.product_id
JOIN product_category_name_translation 
	ON products.product_category_name = product_category_name_translation.product_category_name 
WHERE
	product_category_name_translation.product_category_name_english IN ('audio', 'cine_photo', 'console_games', 'electronics', 'computer', 'computers_accessories', 'pc_gamer', 'telephony')
;

/*

What’s the average price of the products being sold?

AVG price of the products being sold = 120.65
AVG price of the payment value = 154.10

*/

SELECT
	AVG (price)
FROM
	order_items
;
	

SELECT
	AVG (payment_value)
FROM
	order_payments
;


/*

Are expensive tech products popular?

*/



