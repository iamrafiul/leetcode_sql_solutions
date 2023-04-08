SELECT
    sell_date,
    COUNT(DISTINCT product) as num_sold,
    GROUP_CONCAT(DISTINCT product) as products
FROM activities
GROUP BY sell_date
ORDER BY sell_date;
