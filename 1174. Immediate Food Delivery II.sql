WITH delivery_ranker AS (
    SELECT
        customer_id,
        CASE
            WHEN order_date = customer_pref_delivery_date THEN 'immediate'
            ELSE 'scheduled'
        END as order_type,
        RANK() OVER(PARTITION BY customer_id ORDER BY order_date) as d_rank
    FROM delivery
)

SELECT 
    ROUND(
        SUM(CASE WHEN order_type = 'immediate' AND d_rank = 1 THEN 1 ELSE 0 END) 
        /
        (1.0 * (SELECT COUNT(*) FROM delivery_ranker WHERE d_rank = 1)) * 100
    , 2) AS immediate_percentage
FROM delivery_ranker;
