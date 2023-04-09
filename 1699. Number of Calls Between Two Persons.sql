# Solution with CASE
SELECT 
    CASE
        WHEN from_id > to_id THEN to_id
        ELSE from_id
    END AS person1,
    CASE
        WHEN from_id > to_id THEN from_id
        ELSE to_id
    END AS person2,
    COUNT(duration) AS call_count,
    SUM(duration) AS total_duration       
FROM Calls
GROUP BY person1, person2;


# Solution with UNIONing
WITH call_pivot AS (
    SELECT from_id id1, to_id id2, duration FROM calls
    UNION ALL
    SELECT to_id id1, from_id id2, duration FROM calls
)

SELECT
    id1 as person1,
    id2 as person2,
    COUNT(*) as call_count,
    SUM(duration) AS total_duration
FROM call_pivot 
WHERE id1 < id2
GROUP BY id1, id2;
