# Solution 1
WITH rich_counter AS (
    SELECT
        customer_id,
        SUM(
            CASE
                WHEN amount > 500 THEN 1 ELSE 0
            END
        ) AS total_purchase
    FROM store 
    GROUP BY customer_id
)

SELECT
    COUNT(customer_id) AS rich_count
FROM rich_counter
WHERE total_purchase > 0;


# Solution 2
SELECT
    COUNT(DISTINCT customer_id) AS rich_count
FROM store
WHERE amount > 500;
