# Easier to understand, with CTE
WITH activity_ranker AS(
    SELECT
        username,
        activity,
        startDate,
        endDate,
        RANK() OVER(PARTITION BY username ORDER BY startDate desc) AS a_rank,
        COUNT(activity) over (partition by username) as a_cnt
    FROM UserActivity
)

SELECT
    username,
    activity,
    startDate,
    endDate
FROM activity_ranker
WHERE a_rank = 2 OR a_cnt = 1;


# A bit complex solution with two CTEs
WITH activity_ranker AS(
    SELECT
        username,
        activity,
        startDate,
        endDate,
        RANK() OVER(PARTITION BY username ORDER BY startDate desc) AS a_rank
    FROM UserActivity
)
,users_filter AS (
    SELECT username, 2 AS r_rank FROM activity_ranker WHERE a_rank = 2
    UNION ALL
    SELECT username, 1 AS r_rank FROM activity_ranker GROUP BY username HAVING MAX(a_rank) = 1
)

SELECT
    uf.username,
    ar.activity,
    ar.startDate,
    ar.endDate
FROM users_filter uf
LEFT JOIN activity_ranker ar ON 
    ar.username = uf.username AND 
    ar.a_rank = uf.r_rank;
