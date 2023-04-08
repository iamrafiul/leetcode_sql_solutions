SELECT
    u.name,
    SUM(t.amount) as balance
FROM transactions t
LEFT JOIN users u on t.account = u.account
GROUP BY t.account
HAVING SUM(t.amount) > 10000;
