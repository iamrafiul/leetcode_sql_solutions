# Solution with multi JOIN, concise but difficult to understand
SELECT 
    distinct a.id, 
    a.name
FROM Logins l1 
JOIN Logins l2 ON
    l1.id = l2.id and 
    datediff(l2.login_date, l1.login_date) between 0 and 4
JOIN Accounts a ON l1.id = a.id
GROUP BY l1.id, l1.login_date
HAVING COUNT(distinct l2.login_date) = 5;


# Solution with CTE and single JOIN, easier to understand
WITH login_ranker AS(
    SELECT
        id,
        login_date,
        DAYOFYEAR(login_date) - DENSE_RANK() OVER(PARTITION BY id ORDER BY login_date) AS seq
    FROM logins
    ORDER BY id
)

SELECT 
    DISTINCT l.id,
    a.name
FROM login_ranker l
LEFT JOIN accounts a ON l.id = a.id
GROUP BY l.id, l.seq
HAVING COUNT(DISTINCT l.login_date) >= 5
ORDER BY id;
