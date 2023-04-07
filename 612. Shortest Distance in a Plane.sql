SELECT
    ROUND(
        SQRT(
            MIN(
                (POW(p1.x - p2.x, 2) + POW(p1.y - p2.y, 2)
            )
        )
    ), 2) AS shortest
FROM point2d p1 JOIN point2d p2 WHERE p1.x != p2.x OR p2.y != p1.y;
