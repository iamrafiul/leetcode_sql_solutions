WITH cte AS(
    SELECT * FROM transactions WHERE state = 'approved'
    UNION ALL
    SELECT trans_id as id, t.country, 'backs' AS state, t.amount, c.trans_date 
    FROM chargebacks c LEFT JOIN transactions t ON t.id =  c.trans_id
)

SELECT
    LEFT(trans_date, 7) AS month,
    country,
    SUM(state = 'approved') AS approved_count,
    SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_amount,
    SUM(state = 'backs') AS chargeback_count,
    SUM(CASE WHEN state = 'backs' THEN amount ELSE 0 END) AS chargeback_amount
FROM cte
GROUP BY LEFT(trans_date, 7), country;
