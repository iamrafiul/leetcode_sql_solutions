WITH machine_activity AS(
    SELECT
        machine_id,
        SUM(CASE
            WHEN activity_type = 'end' THEN timestamp ELSE 0.0
        END) AS end_times,
        SUM(CASE
            WHEN activity_type = 'start' THEN timestamp ELSE 0.0
        END) AS start_times,
        COUNT(*) / 2 AS total_count
    FROM activity
    GROUP BY machine_id
)

SELECT
    machine_id,
    ROUND((end_times - start_times) / (1.0 * total_count), 3) AS processing_time
FROM machine_activity;
