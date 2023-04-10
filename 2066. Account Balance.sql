WITH adjusted_transaction AS (
    SELECT
        account_id,
        day,
        CASE
            WHEN type = 'Withdraw' THEN -1 * amount
            ELSE amount
        END AS amount
    FROM transactions
)

SELECT
    account_id,
    day,
    SUM(amount) OVER(PARTITION BY account_id ORDER BY day) AS balance
FROM adjusted_transaction
ORDER BY account_id, day;
