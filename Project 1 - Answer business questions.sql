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

'audio', 'cine_foto', 'consoles_games', 'eletronicos', 'informatica_acessorios', 'pc_gamer', 'pcs', 'telefonia'

*/


/*

How many products of these tech categories have been sold 
(within the time window of the database snapshot)? What percentage does that 
represent from the overall number of products sold?

15584 rows returned for the tech category sells

Percentage = (16924 / 112650) x 100
Percentage = 15,23 %

Audio :364
cine_foto : 72
consoles_games : 1137
eletronicos : 2767
informatica_acessorios : 7827
pc_gamer : 9
pcs : 203
telefonia : 4545

*/

SELECT
	COUNT(*)
FROM
	order_items
;


SELECT 
    DISTINCT products.product_category_name,
    COUNT(products.product_category_name) AS Count
FROM 
	order_items
LEFT JOIN 
	orders 
		ON orders.order_id = order_items.order_id
LEFT JOIN products 
	ON order_items.product_id = products.product_id
WHERE
	 products.product_category_name IN ('audio', 'cine_foto', 'consoles_games', 'eletronicos', 'informatica_acessorios', 'pc_gamer', 'pcs', 'telefonia')
GROUP BY 
	products.product_category_name
;

SELECT 
    COUNT(products.product_category_name) AS Total
FROM 
	order_items
LEFT JOIN 
	orders 
		ON orders.order_id = order_items.order_id
LEFT JOIN products 
	ON order_items.product_id = products.product_id
WHERE
	 products.product_category_name IN ('audio', 'cine_foto', 'consoles_games', 'eletronicos', 'informatica_acessorios', 'pc_gamer', 'pcs', 'telefonia')
;

SELECT 
	((SELECT 
    COUNT(products.product_category_name) AS Total
FROM 
	order_items
LEFT JOIN 
	orders 
		ON orders.order_id = order_items.order_id
LEFT JOIN products 
	ON order_items.product_id = products.product_id
WHERE
	 products.product_category_name IN ('audio', 'cine_foto', 'consoles_games', 'eletronicos', 'informatica_acessorios', 'pc_gamer', 'pcs', 'telefonia')
)
/
(SELECT
	COUNT(*)
FROM
	order_items
    ))
* 100
AS sales_percentage_tech
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

We definied as an expensive product, a product of price of 300 euros or more
=> 910 expensive products on the total of the 16924 sell products (Approx = 5,37%)

*/

SELECT 
    price_category,
    COUNT(*) AS count
FROM (
    SELECT 
	 order_id,
     order_item_id,
     price,
CASE
	WHEN price > 300 then 'expensive'
    WHEN price <= 300 and price > 100 then 'not so expensive'
    else 'cheap'
    end as price_category
FROM 
	magist.order_items
LEFT JOIN products 
	ON order_items.product_id = products.product_id
WHERE
	products.product_category_name IN ('audio', 'cine_foto', 'consoles_games', 'eletronicos', 'informatica_acessorios', 'pc_gamer', 'pcs', 'telefonia')
) AS subquery
GROUP BY 
	price_category
ORDER BY 
	count DESC
;

SELECT 
    price_category,
    COUNT(*) AS count
FROM (
    SELECT 
	 order_id,
     order_item_id,
     price,
CASE
	WHEN price > 300 then 'expensive'
    WHEN price <= 300 and price > 100 then 'not so expensive'
    else 'cheap'
    end as price_category
FROM 
	magist.order_items
LEFT JOIN products 
	ON order_items.product_id = products.product_id
WHERE
	products.product_category_name IN ('audio', 'cine_foto', 'consoles_games', 'eletronicos', 'informatica_acessorios', 'pc_gamer', 'pcs', 'telefonia')
AND price > 300
) AS subquery
GROUP BY 
	price_category
;

SELECT
	((SELECT 
    COUNT(*) AS count
FROM (
    SELECT 
	 order_id,
     order_item_id,
     price,
CASE
	WHEN price > 300 then 'expensive'
    WHEN price <= 300 and price > 100 then 'not so expensive'
    else 'cheap'
    end as price_category
FROM 
	magist.order_items
LEFT JOIN products 
	ON order_items.product_id = products.product_id
WHERE
	products.product_category_name IN ('audio', 'cine_foto', 'consoles_games', 'eletronicos', 'informatica_acessorios', 'pc_gamer', 'pcs', 'telefonia')
AND price > 300
) AS subquery
GROUP BY 
	price_category
)
/
(SELECT 
    COUNT(products.product_category_name) AS Total
FROM 
	order_items
LEFT JOIN 
	orders 
		ON orders.order_id = order_items.order_id
LEFT JOIN products 
	ON order_items.product_id = products.product_id
WHERE
	 products.product_category_name IN ('audio', 'cine_foto', 'consoles_games', 'eletronicos', 'informatica_acessorios', 'pc_gamer', 'pcs', 'telefonia')
))
*
100
AS percentage
;
