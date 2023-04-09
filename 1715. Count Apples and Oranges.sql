# Solution with CTE
WITH fruits_count AS (
    SELECT
        b.box_id,
        b.apple_count + IFNULL(c.apple_count, 0) AS apple_count,
        b.orange_count + IFNULL(c.orange_count, 0) AS orange_count
    FROM boxes b
    LEFT JOIN chests c ON b.chest_id = c.chest_id
    GROUP BY b.box_id
)

SELECT
    SUM(apple_count) AS apple_count,
    SUM(orange_count) AS orange_count
FROM fruits_count;


# Concise solution without CTE
SELECT
    SUM(b.apple_count + IFNULL(c.apple_count, 0)) AS apple_count,
    SUM(b.orange_count + IFNULL(c.orange_count, 0)) AS orange_count
FROM boxes b
LEFT JOIN chests c ON b.chest_id = c.chest_id;
