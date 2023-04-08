# With two CTEs
WITH occurences_avg AS (
    SELECT
        DISTINCT event_type,
        AVG(occurences) avg_occurences
    FROM events
    GROUP BY event_type
),
event_count AS(
    SELECT
        e.business_id,
        COUNT(*) as total
    FROM events e
    LEFT JOIN occurences_avg o ON o.event_type = e.event_type 
    WHERE e.occurences > o.avg_occurences
    GROUP BY e.business_id
)

SELECT business_id FROM event_count WHERE total > 1;


# With one CTE
WITH occurences_avg AS (
    SELECT
        DISTINCT event_type,
        AVG(occurences) avg_occurences
    FROM events
    GROUP BY event_type
)

SELECT
    e.business_id
FROM events e
LEFT JOIN occurences_avg o ON o.event_type = e.event_type 
WHERE e.occurences > o.avg_occurences
GROUP BY e.business_id
HAVING COUNT(*) > 1;
