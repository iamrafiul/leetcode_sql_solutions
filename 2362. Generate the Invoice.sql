WITH product_ranker AS(
    SELECT
        pc.invoice_id,
        SUM(pc.quantity * p.price) AS price
    FROM purchases pc
    LEFT JOIN products p ON pc.product_id = p.product_id
    GROUP BY pc.invoice_id
    ORDER BY price DESC, pc.invoice_id ASC
    LIMIT 1
)

SELECT
    p.product_id,
    p.quantity,
    p.quantity * pp.price AS price
FROM purchases p
LEFT JOIN products pp ON p.product_id = pp.product_id
RIGHT JOIN product_ranker pr ON p.invoice_id = pr.invoice_id;
