WITH product_ranker AS (
    SELECT
        product_id,
        order_id,
        order_date,
        DENSE_RANK() OVER(PARTITION BY product_id ORDER BY order_date DESC) AS p_rank
    FROM orders
    GROUP BY product_id, order_id
)
SELECT
    p.product_name,
    pr.product_id,
    pr.order_id,
    pr.order_date
FROM product_ranker pr
LEFT JOIN products p ON pr.product_id = p.product_id
WHERE pr.p_rank = 1
ORDER BY p.product_name, pr.product_id, pr.order_id;
