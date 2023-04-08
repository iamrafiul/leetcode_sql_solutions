SELECT
    activity_date AS day,
    COUNT(DISTINCT user_id) as active_users
FROM activity
WHERE DATEDIFF('2019-07-27', activity_date) < 30
GROUP BY activity_date
HAVING COUNT(DISTINCT user_id) > 0;
