# Step by step solution with CTEs, easier to read and understand
WITH ny_count AS (
    SELECT COUNT(*) AS total FROM NewYork WHERE score >= 90
),
ca_count AS (
    SELECT COUNT(*) AS total FROM California WHERE score >= 90
)

SELECT
    CASE
        WHEN ny.total > ca.total THEN 'New York University'
        WHEN ny.total < ca.total THEN 'California University'
        WHEN ny.total = ca.total THEN 'No Winner'
    END AS winner
FROM ny_count ny, ca_count ca;


# Concise and short solution, bit hard to read
SELECT
    CASE
        WHEN (SELECT COUNT(*) FROM NewYork WHERE score >= 90) > (SELECT COUNT(*) FROM California WHERE score >= 90) THEN 'New York University'
        WHEN (SELECT COUNT(*) FROM NewYork WHERE score >= 90) < (SELECT COUNT(*) FROM California WHERE score >= 90) THEN 'California University'
        WHEN (SELECT COUNT(*) FROM NewYork WHERE score >= 90) = (SELECT COUNT(*) FROM California WHERE score >= 90) THEN 'No Winner'
    END AS winner;
