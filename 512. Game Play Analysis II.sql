# With sub-qeury and MIN
SELECT
    a.player_id,
    a.device_id
FROM activity a
WHERE a.event_date = (
    SELECT 
        MIN(event_date)
    FROM activity
    WHERE player_id = a.player_id 
);


# With sub-query and RANK
SELECT player_id, device_id FROM (
    SELECT 
        player_id,
        device_id,
        RANK() OVER (PARTITION BY player_id ORDER BY event_date) as login_rank
    FROM Activity
) rank_table
WHERE rank_table.login_rank = 1;
