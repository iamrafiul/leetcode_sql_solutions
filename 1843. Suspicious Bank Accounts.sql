WITH monthly_dist AS (
    SELECT
        account_id,
        transaction_id,
        MONTH(day) as month,
        SUM(
            CASE
                WHEN type = 'Creditor' THEN amount ELSE 0
            END 
        ) AS total_income
    FROM transactions 
    GROUP BY account_id, MONTH(day)
)

SELECT
    DISTINCT md1.account_id
FROM monthly_dist md1
JOIN monthly_dist md2 ON md1.account_id = md2.account_id AND ABS(md1.month - md2.month) = 1
LEFT JOIN accounts a ON md1.account_id = a.account_id
WHERE md1.total_income > a.max_income AND md2.total_income > a.max_income
ORDER BY md1.transaction_id;
