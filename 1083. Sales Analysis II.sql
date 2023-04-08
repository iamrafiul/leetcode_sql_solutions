# With sub-query
SELECT
    buyer_id
FROM (
    SELECT
        buyer_id,
        SUM(CASE
            WHEN p.product_name = 'S8' THEN 1 ELSE 0
        END) AS s8,
        SUM(CASE
            WHEN p.product_name = 'iPhone' THEN 1 ELSE 0
        END) AS iPhone
    FROM sales
    JOIN product p ON sales.product_id = p.product_id
    GROUP BY buyer_id

) cte
WHERE cte.s8 > 0 and cte.iphone = 0;


# Same logic with HAVING
SELECT
    buyer_id
FROM sales
JOIN product p ON sales.product_id = p.product_id
GROUP BY buyer_id
HAVING SUM(CASE WHEN p.product_name = 's8' THEN 1 ELSE 0 END) > 0
AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;
