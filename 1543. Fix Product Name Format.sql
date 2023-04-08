# Consice, without CTE
SELECT
    trim(lower(product_name)) product_name,
    DATE_FORMAT(sale_date, '%Y-%m') sale_date,
    COUNT(sale_id) AS total
FROM sales
GROUP BY 1, 2
ORDER BY 1, 2;


# With CTE
WITH correcter AS (
    SELECT
        trim(lower(product_name)) product_name,
        DATE_FORMAT(sale_date, '%Y-%m') sale_date
    FROM sales
)

SELECT
    product_name,
    sale_date,
    COUNT(*) AS total
FROM correcter
GROUP BY product_name, sale_date
ORDER BY product_name, sale_date;
