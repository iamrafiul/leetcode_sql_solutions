SELECT
    sp.salesperson_id,
    sp.name,
    IFNULL(SUM(price), 0) as total
FROM salesperson sp
LEFT JOIN customer c ON sp.salesperson_id = c.salesperson_id
LEFT JOIN sales s ON s.customer_id = c.customer_id
GROUP BY sp.salesperson_id;
