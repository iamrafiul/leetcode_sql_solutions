WITH win_rank AS (
    SELECT  
        player_id,
        result,
        RANK() OVER(PARTITION BY player_id ORDER BY match_day) AS RNK1,
        RANK() OVER(PARTITION BY player_id, result  ORDER BY match_day) RNK2
    FROM Matches 
)
, win_cluster AS (
    SELECT
        player_id,
        COUNT(*) AS streak
    FROM win_rank
    WHERE result = 'Win'
    GROUP BY player_id, ABS(RNK1 - RNK2)
)

SELECT 
    p.player_id,
    IFNULL(
        MAX(w.streak), 0
    ) AS longest_streak
FROM (SELECT DISTINCT player_id FROM matches) p 
LEFT JOIN win_cluster w ON p.player_id = w.player_id
GROUP BY p.player_id;
