WITH transaction_ranker AS(
    SELECT
        transaction_id,
        RANK() OVER(PARTITION BY DATE(day) ORDER BY amount DESC) AS t_rank
    FROM transactions
)

SELECT
    transaction_id
FROM transaction_ranker 
WHERE t_rank = 1
ORDER BY transaction_id;
