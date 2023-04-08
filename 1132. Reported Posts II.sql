WITH posts AS (
    SELECT
        a.action_date,
        COUNT(DISTINCT r.post_id) / COUNT(DISTINCT a.post_id) * 100 AS percentage
    FROM actions a
    LEFT JOIN removals r ON a.post_id = r.post_id
    WHERE a.extra = 'spam'
    GROUP BY a.action_date
)

SELECT 
    ROUND(
        SUM(percentage) / COUNT(action_date), 2 
    ) AS average_daily_percent
FROM posts;
