# With sub-qeury and without DENSE_RANK
SELECT
    product_id,
    year AS first_year,
    quantity,
    price
FROM sales
WHERE (product_id, year) IN (
    SELECT product_id, MIN(year) FROM sales GROUP BY product_id
);


# With sub-query and DENSE_RANK
SELECT
    s.product_id,
    s.year AS first_year,
    s.quantity,
    s.price
FROM (
    SELECT
        product_id,
        year,
        quantity,
        price,
        DENSE_RANK() OVER(PARTITION BY product_id ORDER BY year) as p_rank
    FROM sales
) s
WHERE s.p_rank = 1;


# With CTE and DENSE_RANK
WITH sales_rank AS (
SELECT
    product_id,
    year,
    quantity,
    price,
    DENSE_RANK() OVER(PARTITION BY product_id ORDER BY year) as p_rank
FROM sales
)

SELECT
    s.product_id,
    s.year AS first_year,
    s.quantity,
    s.price
FROM sales_rank s
WHERE s.p_rank = 1;
