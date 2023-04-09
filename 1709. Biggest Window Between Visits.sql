WITH cte AS (
    SELECT
        user_id,
        ABS(DATEDIFF(LEAD(visit_date, 1, '2021-01-01') 
            OVER(PARTITION BY user_id ORDER BY visit_date), visit_date)) as date_diff
    FROM UserVisits
)

SELECT 
    cte.user_id, 
    MAX(cte.date_diff) as biggest_window
FROM cte
GROUP BY cte.user_id
ORDER BY cte.user_id;
