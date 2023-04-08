SELECT
    LEFT(trans_date, 7) AS month,
    country,
    COUNT(*) AS trans_count,
    SUM(
        CASE
            WHEN state = 'approved' THEN 1 ELSE 0
        END
    ) AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM(
        CASE 
            WHEN state = 'approved' THEN amount ELSE 0
        END
    ) AS approved_total_amount
FROM transactions
GROUP BY LEFT(trans_date, 7), country;
