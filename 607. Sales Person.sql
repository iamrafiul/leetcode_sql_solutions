SELECT
    s.name
FROM salesperson s
WHERE sales_id NOT IN(
    SELECT
        o.sales_id
    FROM orders o
    JOIN company c ON c.com_id = o.com_id # LEFT JOIN will also work
    WHERE c.name = 'RED'
);
