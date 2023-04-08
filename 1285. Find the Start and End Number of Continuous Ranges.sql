WITH log_ranker AS (
    SELECT
        log_id,
        RANK() OVER(ORDER BY log_id) AS l_rank,
        ABS(log_id - RANK() OVER(ORDER BY log_id)) AS diff
    FROM logs
)

SELECT
    MIN(l1.log_id) AS start_id,
    MAX(l2.log_id) AS end_id
FROM log_ranker l1
JOIN log_ranker l2 ON l1.diff = l2.diff
GROUP BY l1.diff
ORDER BY start_id;
