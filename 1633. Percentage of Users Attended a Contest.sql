SELECT
    r.contest_id,
    ROUND(
        (
            COUNT(DISTINCT r.user_id) / 
            (SELECT COUNT(DISTINCT user_id) FROM users)
        ) * 100
    , 2) AS percentage
FROM register r
GROUP BY r.contest_id
ORDER BY percentage DESC, r.contest_id;
