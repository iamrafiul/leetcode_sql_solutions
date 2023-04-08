# Single query with HAVING
SELECT
    c.customer_id,
    c.name
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
LEFT JOIN product p ON o.product_id = p.product_id
GROUP BY customer_id
HAVING SUM(CASE WHEN MONTH(order_date) = 06 THEN quantity * price END) >= 100
AND SUM(CASE WHEN MONTH(order_date) = 07 THEN quantity * price END) >= 100;


# With CTE and without HAVING
WITH spend_calc AS (
    SELECT
        o.customer_id,
        SUM(
            CASE WHEN MONTH(order_date) = 6 THEN p.price * o.quantity ELSE 0 END
        ) AS june_spend,
        SUM(
            CASE WHEN MONTH(order_date) = 7 THEN p.price * o.quantity ELSE 0 END
        ) AS july_spend
    FROM orders o
    LEFT JOIN product p ON o.product_id = p.product_id
    WHERE MONTH(order_date) IN (6, 7) AND YEAR(order_date) = 2020
    GROUP BY o.customer_id
)

SELECT
    s.customer_id,
    c.name AS name
FROM spend_calc s
LEFT JOIN customers c ON s.customer_id = c.customer_id
WHERE s.june_spend >= 100 AND s.july_spend >= 100;
