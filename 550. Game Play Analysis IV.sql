# Solution 1
with player_login as 
(
    select 
        player_id, 
        min(event_date) as date
    from Activity
    group by 1
),
main as 
(
    select 
        p.player_id
    from player_login p
    join activity a on 
        p.player_id = a.player_id
        and date_add(p.date, interval 1 DAY) = a.event_date
)

select 
    round(
        (select count(*) from main) / count(distinct(player_id)), 2
    ) as fraction
from activity;


# Solution 2
WITH first_login AS (
    SELECT
        player_id,
        MIN(event_date) AS first_date
    FROM activity
    GROUP BY player_id
)
, next_login AS (
    SELECT
        a.player_id,
        MIN(a.event_date) AS next_date
    FROM activity a
    LEFT JOIN first_login f ON f.player_id = a.player_id
    WHERE a.event_date <> f.first_date
    GROUP BY player_id
)

SELECT
    ROUND(
        SUM(
            CASE WHEN ABS(f.first_date - IFNULL(n.next_date, f.first_date)) = 1 THEN 1 ELSE 0 END
        ) /
        COUNT(f.player_id)
    , 2) AS fraction
FROM first_login f
LEFT JOIN next_login n ON f.player_id = n.player_id;
