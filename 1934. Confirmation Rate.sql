WITH conf_detail AS (
    SELECT
        s.user_id,
        SUM(
            CASE WHEN c.action = 'confirmed' THEN 1 ELSE 0 END
        ) AS total_confirmed,
        COUNT(*) AS total_actions
    FROM signups s
    LEFT JOIN confirmations c ON s.user_id = c.user_id
    GROUP BY s.user_id
)

SELECT
    user_id,
    CASE 
        WHEN total_actions = 0 THEN 0 
        ELSE ROUND((1.0 * total_confirmed)/(1.0 * total_actions), 2) 
    END as confirmation_rate
FROM conf_detail;
