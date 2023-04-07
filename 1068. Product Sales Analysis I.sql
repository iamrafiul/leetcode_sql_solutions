SELECT
    p.product_name,
    s.year,
    s.price
FROM sales s 
LEFT JOIN product p ON s.product_id = p.product_id;
