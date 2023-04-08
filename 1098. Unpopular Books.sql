WITH books_with_orders AS (
    SELECT
        b.book_id,
        b.name,
        SUM(
            CASE
                WHEN o.dispatch_date BETWEEN '2018-06-23' AND '2019-06-23' THEN o.quantity 
                ELSE 0
            END
        ) AS total_sold
    FROM books b
    LEFT JOIN orders o ON b.book_id = o.book_id
    GROUP BY b.book_id
)

SELECT
    cte.book_id,
    cte.name
FROM books_with_orders cte
LEFT JOIN books b ON b.book_id = cte.book_id
WHERE ABS(DATEDIFF(b.available_from, '2019-06-23')) > 30 AND total_sold < 10;
