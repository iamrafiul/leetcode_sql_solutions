SELECT
    t1.team_name AS home_team,
    t2.team_name AS away_team
FROM teams t1
JOIN teams t2 ON t1.team_name <> t2.team_name;
