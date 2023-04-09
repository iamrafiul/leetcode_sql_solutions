# Solution with CTE
WITH login_counter AS (
    SELECT
        l1.account_id,
        SUM(
            CASE
                WHEN (l1.login BETWEEN l2.login AND l2.logout) OR 
                    (l1.logout BETWEEN l2.login AND l2.logout) THEN 1 
                ELSE 0
            END
        ) AS total_sim_login
    FROM LogInfo l1
    LEFT JOIN LogInfo l2 ON 
        l1.account_id = l2.account_id AND 
        l1.ip_address <> l2.ip_address
    GROUP BY l1.account_id
)

SELECT 
    account_id 
FROM login_counter
WHERE total_sim_login > 0;


# Solution with CROSS JOIN
SELECT 
    l1.account_id
FROM LogInfo l1
CROSS JOIN LogInfo l2 ON 
    l1.account_id = l2.account_id AND 
    l1.ip_address <> l2.ip_address AND 
    l1.login >= l2.login AND 
    l1.login <= l2.logout
GROUP BY l1.account_id;
