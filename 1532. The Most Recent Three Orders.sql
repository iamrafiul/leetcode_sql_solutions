# JOIN inside CTE
WITH order_rank AS(
    SELECT
        c.name AS customer_name,
        o.customer_id,
        o.order_id,
        o.order_date,
        RANK() OVER(PARTITION BY o.customer_id ORDER BY order_date DESC) AS o_rank
    FROM orders o
    LEFT JOIN customers c ON o.customer_id = c.customer_id 
)
SELECT 
    customer_name,
    customer_id,
    order_id,
    order_date
FROM order_rank
WHERE o_rank <= 3
ORDER BY customer_name, customer_id, order_date DESC;


# JOIN outside CTE
WITH order_rank AS(
    SELECT 
        o.customer_id,
        o.order_id,
        o.order_date,
        RANK() OVER(PARTITION BY o.customer_id ORDER BY order_date DESC) AS o_rank
    FROM orders o
)
SELECT
    c.name AS customer_name,
    o.customer_id,
    o.order_id,
    o.order_date
FROM order_rank o
LEFT JOIN customers c ON o.customer_id = c.customer_id 
WHERE o.o_rank <= 3
ORDER BY c.name, o.customer_id, o.order_date DESC;
