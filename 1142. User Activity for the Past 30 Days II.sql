# With CTE 
WITH total_sessions AS (
    SELECT
        DISTINCT user_id,
        session_id
    FROM activity
    WHERE activity_date >= '2019-06-28' and activity_date <= '2019-07-27'
)

SELECT
    CASE
     WHEN (SELECT COUNT(DISTINCT user_id) FROM total_sessions) = 0 THEN 0 
     ELSE ROUND(COUNT(DISTINCT session_id) / (1.0 * COUNT(DISTINCT user_id)), 2)
    END as average_sessions_per_user
FROM total_sessions;


# Without CTE, small and concise
SELECT
    IFNULL(
        ROUND(
            COUNT(DISTINCT session_id) / (1.0 * COUNT(DISTINCT user_id))
        ,2)
    , 0.00) AS average_sessions_per_user
FROM activity
WHERE activity_date >= '2019-06-28' AND activity_date <= '2019-07-27';
