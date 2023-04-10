WITH yearly_products_cnt AS (
    SELECT
        product_id,
        YEAR(purchase_date) as `year`
    FROM orders
    GROUP BY product_id, YEAR(purchase_date)
    HAVING COUNT(*) >= 3
)

SELECT 
    DISTINCT y1.product_id
FROM yearly_products_cnt y1
JOIN yearly_products_cnt y2 ON 
    y1.product_id = y2.product_id AND 
    y1.year + 1 = y2.year;
