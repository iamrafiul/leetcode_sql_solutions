WITH match_pivot AS(
    SELECT home_team_id as team_id, home_team_goals, away_team_goals FROM matches
    UNION ALL
    SELECT away_team_id as team_id, away_team_goals, home_team_goals FROM matches
)

SELECT 
    team_name
    , count(*) as matches_played
    , sum(case when home_team_goals > away_team_goals then 3 when home_team_goals = away_team_goals then 1 else 0 end) as points
    , sum(home_team_goals) as goal_for
    , sum(away_team_goals) as goal_against
    , sum(home_team_goals) - sum(away_team_goals) as goal_diff
FROM match_pivot m
JOIN teams t ON m.team_id = t.team_id
GROUP BY team_name
ORDER BY points DESC, goal_diff DESC, team_name;
