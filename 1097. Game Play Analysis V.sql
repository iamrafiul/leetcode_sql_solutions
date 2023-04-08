WITH install_dates AS(
    SELECT
        player_id,
        event_date,
        RANK() OVER(PARTITION BY player_id ORDER BY event_date) as date_rank,
        LEAD(event_date) OVER(PARTITION BY player_id ORDER BY event_date) as next_date
    FROM activity
)

SELECT
    event_date AS install_dt,
    COUNT(DISTINCT player_id) as installs,
    ROUND(
        SUM(
            CASE WHEN ABS(DATEDIFF(event_date, next_date)) = 1 THEN 1 ELSE 0 END
        ) /
        (1.0 * COUNT(DISTINCT player_id))
    , 2) AS Day1_retention
FROM install_dates
WHERE date_rank = 1
GROUP BY event_date;
