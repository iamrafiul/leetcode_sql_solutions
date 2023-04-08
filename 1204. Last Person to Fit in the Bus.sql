WITH weight_calculator AS (
    SELECT
        turn,
        person_name,
        SUM(weight) OVER(ORDER BY turn) AS total_weight
    FROM queue
)

SELECT
    person_name
FROM weight_calculator
WHERE total_weight <= 1000
ORDER BY total_weight DESC
LIMIT 1;
