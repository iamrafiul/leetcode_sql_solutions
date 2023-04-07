SELECT
    s.product_id,
    SUM(s.quantity) AS total_quantity
FROM sales s
GROUP BY s.product_id;
