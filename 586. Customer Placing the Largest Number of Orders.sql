# Without CTE
SELECT 
    customer_number 
FROM orders 
GROUP BY customer_number 
ORDER BY COUNT(order_number) DESC 
LIMIT 1;


# With CTE
WITH order_counts AS (
    SELECT
        customer_number,
        COUNT(order_number) AS order_count
    FROM orders
    GROUP BY customer_number
)

SELECT
    customer_number
FROM order_counts
WHERE order_count = (SELECT MAX(order_count) FROM order_counts);
