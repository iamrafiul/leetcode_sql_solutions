WITH global_ranks AS (
    SELECT
        team_id,
        name,
        points,
        DENSE_RANK() OVER(ORDER BY points DESC, name) AS g_rank
    FROM teampoints
)
, changed_ranks AS (
    SELECT
        t.team_id,
        t.name,
        t.g_rank,
        DENSE_RANK() OVER(ORDER BY (t.points + p.points_change) DESC, t.name) AS c_rank
    FROM global_ranks t
    LEFT JOIN pointschange p ON t.team_id = p.team_id
)

SELECT
    team_id,
    name,
    CAST(g_rank AS DECIMAL) - CAST(c_rank AS DECIMAL) AS rank_diff
FROM changed_ranks
ORDER BY c_rank, name;
