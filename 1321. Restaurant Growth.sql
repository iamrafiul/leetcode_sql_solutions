WITH daily_sum AS (
    SELECT
        visited_on,
        SUM(amount) AS total_amount
    FROM customer
    GROUP BY visited_on
)
SELECT
    d.visited_on,
    SUM(d1.total_amount) AS amount,
    ROUND(SUM(d1.total_amount) / 7.0, 2) AS average_amount
FROM daily_sum d
JOIN daily_sum d1 
WHERE DATEDIFF(d.visited_on, d1.visited_on) BETWEEN 0 AND 6
GROUP BY d.visited_on
HAVING COUNT(d1.visited_on) = 7
ORDER BY d.visited_on;
