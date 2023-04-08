WITH log_unpivot AS (
    SELECT 
        fail_date as p_date, 
        'failed' AS state,
        DAYOFYEAR(fail_date) - row_number() over (order by fail_date) as seq
    FROM failed WHERE fail_date BETWEEN '2019-01-01' AND '2019-12-31'
    UNION ALL
    SELECT 
        success_date as p_date, 
        'succeeded' AS state,
        DAYOFYEAR(success_date) - row_number() OVER (order by success_date) AS seq
    FROM succeeded WHERE success_date BETWEEN '2019-01-01' AND '2019-12-31'
)

SELECT 
    state AS period_state,
    MIN(p_date) AS start_date,
    MAX(p_date) AS end_date
FROM log_unpivot 
GROUP BY state, seq
ORDER BY MIN(p_date);
