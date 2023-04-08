# CTE with RANK, JOIN in final query
WITH order_ranker AS (
    SELECT
        customer_id,
        product_id,
        # COUNT(product_id), #OVER(PARTITION BY customer_id, product_id)
        RANK() OVER(PARTITION BY customer_id ORDER BY COUNT(product_id) DESC) AS c_rank
    FROM orders
    GROUP BY customer_id, product_id
)

SELECT
    rr.customer_id,
    rr.product_id,
    p.product_name
FROM order_ranker rr
LEFT JOIN products p ON rr.product_id = p.product_id
WHERE rr.c_rank = 1;


# CTE with RANK and JOIN
WITH order_ranker AS (
    SELECT
        o.customer_id,
        o.product_id,
        p.product_name,
        RANK() OVER(PARTITION BY o.customer_id ORDER BY COUNT(o.product_id) DESC) AS c_rank
    FROM orders o
    LEFT JOIN products p ON o.product_id = p.product_id
    GROUP BY o.customer_id, o.product_id
)

SELECT
    rr.customer_id,
    rr.product_id,
    rr.product_name
FROM order_ranker rr
WHERE rr.c_rank = 1;


# A different way of solving with COUNT instead on RANK
WITH freq_count AS (
    SELECT
        customer_id,
        product_id,
        COUNT(product_id) AS total_order
    FROM orders
    GROUP BY customer_id, product_id
)
, max_order AS (
    SELECT
        customer_id,
        product_id        
    FROM freq_count f
    WHERE total_order = (SELECT MAX(total_order) FROM freq_count WHERE customer_id = f.customer_id)
)
SELECT
    customer_id,
    product_id,
    product_name
FROM max_order 
LEFT JOIN products using(product_id);


# Another solution with COUNT
WITH prod_count AS (
    SELECT
        customer_id,
        product_id,
        COUNT(*) AS total_buy
    FROM orders
    GROUP BY customer_id, product_id
)

SELECT
    p.customer_id,
    p.product_id,
    pr.product_name
FROM prod_count p
LEFT JOIN products pr ON p.product_id = pr.product_id
WHERE total_buy = (
    SELECT MAX(total_buy) FROM prod_count WHERE customer_id = p.customer_id 
);
