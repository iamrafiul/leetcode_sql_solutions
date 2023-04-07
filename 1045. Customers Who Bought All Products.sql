SELECT
    c.customer_id
FROM customer c
LEFT JOIN product p ON c.product_key = p.product_key
GROUP BY c.customer_id
HAVING COUNT(DISTINCT c.product_key) = (SELECT COUNT(*) FROM product); 
