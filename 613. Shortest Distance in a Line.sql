# Straight forward JOIN
SELECT
    MIN(ABS(p1.x - p2.x)) AS shortest
FROM point p1 JOIN point p2 ON p1.x != p2.x;


# With CTE
WITH distance AS (
    SELECT
        ABS(a.x - b.x) AS distance
    FROM point a
    JOIN point b ON a.x != b.x
)

SELECT
    MIN(distance) AS shortest
FROM distance;


# Same logic of second query with sub-squery
SELECT 
    MIN(diff) AS shortest
FROM (
    SELECT
        ABS(p1.x - p2.x) AS diff
    FROM point p1 JOIN point p2 ON p1.x != p2.x

) cte;
