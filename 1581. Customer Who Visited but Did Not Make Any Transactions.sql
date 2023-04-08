# Concise solution with one query
SELECT
    v.customer_id,
    COUNT(v.visit_id) as count_no_trans
FROM visits v 
WHERE v.visit_id NOT IN (SELECT visit_id from transactions)
GROUP BY v.customer_id;


# Elaborate query with CTE, easier to understand
WITH visit_wo_transaction AS (
    SELECT
        visit_id,
        customer_id
    FROM visits
    WHERE visit_id NOT IN (
        SELECT DISTINCT visit_id FROM transactions
    )
)

SELECT
    customer_id,
    COUNT(visit_id) AS count_no_trans
FROM visit_wo_transaction
GROUP BY customer_id;
