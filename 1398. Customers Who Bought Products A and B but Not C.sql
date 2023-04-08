WITH buying_condition AS (
    SELECT
        customer_id,
        SUM(
            CASE WHEN product_name = 'A' THEN 1 ELSE 0 END
        ) AS a_sum,
        SUM(
            CASE WHEN product_name = 'B' THEN 1 ELSE 0 END
        ) AS b_sum,
        SUM(
            CASE WHEN product_name = 'C' THEN 1 ELSE 0 END
        ) AS c_sum
    FROM orders
    GROUP BY customer_id
)
SELECT 
    bc.customer_id,
    c.customer_name
FROM buying_condition bc
LEFT JOIN customers c ON bc.customer_id = c.customer_id
WHERE bc.a_sum > 0 AND bc.b_sum > 0 AND bc.c_sum = 0
ORDER BY bc.customer_id;
