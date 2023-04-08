WITH match_pivot AS (
    SELECT
        match_id, 
        host_team as team1,
        guest_team as team2,
        host_goals as team1_goals,
        guest_goals as team2_goals
    FROM matches
    UNION
    SELECT
        match_id, 
        guest_team as team1,
        host_team as team2,
        guest_goals as team1_goals,
        host_goals as team2_goals
    FROM matches
)

SELECT
    t.team_id,
    t.team_name,
    IFNULL(
        SUM(
            CASE
            WHEN team1_goals > team2_goals THEN 3
            WHEN team1_goals < team2_goals THEN 0
            WHEN team1_goals = team2_goals THEN 1
        END)
    , 0) AS num_points
FROM teams t
LEFT JOIN match_pivot mp ON t.team_id = mp.team1
GROUP BY team_id
ORDER BY num_points DESC, team_id;
