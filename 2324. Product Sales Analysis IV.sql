WITH product_ranker AS (
    SELECT
        s.user_id,
        s.product_id,
        SUM(s.quantity * p.price),
        RANK() OVER(PARTITION BY s.user_id ORDER BY SUM(s.quantity * p.price) DESC) AS p_rank
    FROM sales s
    LEFT JOIN product p ON s.product_id = p.product_id
    GROUP BY s.product_id, s.user_id
)

SELECT
    user_id,
    product_id
FROM product_ranker
WHERE p_rank = 1
ORDER BY user_id, product_id;
