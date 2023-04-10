WITH category_calc AS (
    SELECT
        m.member_id,
        m.name,
        CASE 
            WHEN COUNT(v.member_id) = 0 THEN -1
            ELSE ((100 * COUNT(p.visit_id)) / COUNT(v.member_id))
        END AS conversion_rate        
    FROM members m
    LEFT JOIN visits v ON m.member_id = v.member_id
    LEFT JOIN purchases p ON v.visit_id = p.visit_id
    GROUP BY m.member_id, m.name
)

SELECT
    member_id,
    name,
    CASE
        WHEN conversion_rate >= 80 THEN 'Diamond'
        WHEN conversion_rate >= 50 AND conversion_rate < 80 THEN 'Gold'
        WHEN conversion_rate < 50 AND conversion_rate >= 0 THEN 'Silver'
        ELSE 'Bronze'
    END category
FROM category_calc;
