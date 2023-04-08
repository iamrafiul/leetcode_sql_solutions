SELECT
    s.seller_name
FROM seller s
WHERE s.seller_id NOT IN (
    SELECT DISTINCT seller_id FROM orders WHERE YEAR(sale_date) = 2020
)
ORDER BY s.seller_name;
