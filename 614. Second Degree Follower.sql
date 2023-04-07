SELECT
    f.follower,
    CASE
        WHEN (SELECT COUNT(*) FROM follow where followee = f.follower) > 0 THEN (SELECT COUNT(*) FROM follow where followee = f.follower) ELSE 0
    END AS num
FROM follow f
GROUP BY f.follower
HAVING num > 0
ORDER BY f.follower;
