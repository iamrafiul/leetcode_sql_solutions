SELECT
    LEFT(order_date, 7) AS month,
    COUNT(order_id) AS order_count,
    COUNT(DISTINCT customer_id) AS customer_count
FROM orders
WHERE invoice > 20
GROUP BY LEFT(order_date, 7);
