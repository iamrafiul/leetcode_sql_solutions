# With UNION ALL 
WITH id_unpivot AS(
    SELECT requester_id as id FROM RequestAccepted
    UNION ALL
    SELECT accepter_id as id FROM RequestAccepted
)

SELECT
    id,
    COUNT(*) as num
FROM id_unpivot
GROUP BY id
ORDER BY num DESC LIMIT 1;


# With UNION ALL and sub-query
WITH id_unpivot AS(
    SELECT requester_id as id FROM RequestAccepted
    UNION ALL
    SELECT accepter_id as id FROM RequestAccepted
),
total_occ AS(
    SELECT
        id,
        COUNT(*) as num
    FROM  id_unpivot
    GROUP BY id
)

SELECT
    id,
    num
FROM total_occ 
WHERE num = (SELECT MAX(num) FROM total_occ);
