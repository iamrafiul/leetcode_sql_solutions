SELECT
    p1.id AS p1,
    p2.id AS p2,
    (
        ABS(p1.x_value - p2.x_value) * ABS(p1.y_value - p2.y_value)
    ) AS area
FROM points p1
JOIN points p2 ON p1.id != p2.id
HAVING area != 0 AND p1.id < p2.id
ORDER BY area DESC, p1.id, p2.id;
