# With sub-query JOIN
SELECT 
    distinct a.product_id,
    ifnull(temp.new_price,10) as price 
FROM products as a
LEFT JOIN
(
    SELECT 
        * 
    FROM products 
    WHERE (product_id, change_date) in (
        select 
            product_id,
            max(change_date) 
        from products 
        where change_date<="2019-08-16" 
        group by product_id
    )
) as temp on a.product_id = temp.product_id;


# Modular with two CTEs, easy to understand
WITH ids_with_no_change AS(
    SELECT
        product_id
    FROM products
    GROUP BY product_id
    HAVING MIN(change_date) > '2019-08-16'
    
)
, ids_with_change AS (
    SELECT
        product_id,
        change_date,
        new_price AS price
    FROM products
    WHERE (product_id, change_date) IN (
        SELECT 
            product_id, 
            MAX(change_date)
        FROM products
        WHERE change_date <= '2019-08-16'
        GROUP BY product_id
    )
)

SELECT product_id, 10 AS price FROM ids_with_no_change
UNION
SELECT product_id, price FROM ids_with_change;


# More modular with three CTEs, easier to understand
WITH id_with_no_change AS(
    SELECT
        product_id
    FROM products
    GROUP BY product_id
    HAVING MIN(change_date) > '2019-08-16'
)
, max_change_date AS (
    SELECT
        product_id,
        MAX(change_date) AS change_date
    FROM products
    WHERE change_date <= '2019-08-16'
    GROUP BY product_id
)
, id_with_change AS (
    SELECT
        product_id,
        change_date,
        new_price
    FROM products
    WHERE (product_id, change_date) IN (
        SELECT product_id, change_date FROM max_change_date
    )
)

SELECT product_id, 10 AS price FROM id_with_no_change
UNION
SELECT product_id, new_price AS price FROM id_with_change;
