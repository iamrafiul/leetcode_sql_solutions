# With sub-query
SELECT 
    seller_id 
FROM (
    SELECT
        seller_id,
        RANK() OVER(ORDER BY SUM(price) DESC) as s_rank
    FROM sales
    GROUP BY seller_id
) cte
WHERE cte.s_rank = 1;


# With CTE
WITH seller_with_price AS (
    SELECT
        seller_id,
        SUM(price) AS total_price
    FROM sales
    GROUP BY seller_id
)

SELECT 
    seller_id 
FROM seller_with_price 
WHERE total_price = (
    SELECT MAX(total_price) FROM seller_with_price
);
