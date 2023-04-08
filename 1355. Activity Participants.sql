WITH activity_ranker AS(
    SELECT
        activity,
        COUNT(DISTINCT id) AS total_count
    FROM friends
    GROUP BY activity
)

SELECT
    activity
FROM activity_ranker
WHERE 
    total_count != (SELECT MAX(total_count) FROM activity_ranker) AND 
    total_count != (SELECT MIN(total_count) FROM activity_ranker);
