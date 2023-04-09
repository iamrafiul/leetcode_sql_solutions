# Solution with multiple CTEs, easier to understand
WITH contest_pivot AS (
    SELECT gold_medal AS user_id, contest_id, 'gold' AS medal FROM contests
    UNION 
    SELECT silver_medal AS user_id, contest_id, 'silver' AS medal FROM contests
    UNION 
    SELECT bronze_medal AS user_id, contest_id, 'bronze' AS medal FROM contests
)
, three_cons_wins AS (
    SELECT
        c.user_id
    FROM contest_pivot c
    LEFT JOIN contest_pivot c1 ON c.user_id = c1.user_id
    LEFT JOIN contest_pivot c2 ON c.user_id = c2.user_id
    WHERE c.contest_id + 1 = c1.contest_id AND c.contest_id + 2 = c2.contest_id
)
, three_gold_medals AS (
    SELECT
        user_id
    FROM contest_pivot
    WHERE medal = 'gold'
    GROUP BY user_id
    HAVING COUNT(*) >= 3
)
, final_result AS (
    SELECT user_id FROM three_cons_wins
    UNION
    SELECT user_id FROM three_gold_medals
)
SELECT 
    u.name,
    u.mail
FROM final_result f
LEFT JOIN users u ON f.user_id = u.user_id;


# Solution with LEAD and LAG
WITH pivot_contest AS (
    SELECT contest_id, gold_medal AS 'winner' FROM contests
    UNION ALL 
    SELECT contest_id, silver_medal AS 'winner' FROM contests
    UNION ALL
    SELECT contest_id, bronze_medal AS 'winner' FROM contests
)

, consecutive_wins AS(
    SELECT
        winner,
        Users.name,
        Users.mail,
        contest_id,
        LAG(contest_id) OVER(PARTITION BY winner ORDER BY contest_id) AS prev_contest,
        LEAD(contest_id) OVER(PARTITION BY winner ORDER BY contest_id) AS next_contest
    FROM pivot_contest
    LEFT JOIN Users ON winner = Users.user_id
)
, gold_medalists AS (
    SELECT
        gold_medal as winner,
        Users.name,
        Users.mail
    FROM contests
    LEFT JOIN Users ON gold_medal = Users.user_id
    GROUP BY gold_medal
    HAVING COUNT(contest_id) >= 3
)
SELECT DISTINCT name, mail FROM consecutive_wins WHERE prev_contest + 1 = contest_id AND contest_id + 1 = next_contest
UNION
SELECT DISTINCT name, mail FROM gold_medalists;
