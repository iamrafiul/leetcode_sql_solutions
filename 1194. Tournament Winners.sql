WITH cte_1 AS (
	SELECT
		first_player as player,
		first_score as score
	FROM matches
	UNION ALL
	SELECT
		second_player as player,
		second_score as score
	FROM matches
),
cte_2 AS (
	SELECT
		player,
		SUM(score) as total_score
	FROM cte_1
	GROUP BY player
)

SELECT
	DISTINCT p.group_id,
	FIRST_VALUE(cte_2.player) OVER(PARTITION BY p.group_id ORDER BY cte_2.total_score DESC) as player_id
FROM cte_2
LEFT JOIN players p ON p.player_id = cte_2.player;
