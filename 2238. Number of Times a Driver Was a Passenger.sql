# With CTE for distinct driver
WITH drivers AS (
    SELECT
        DISTINCT driver_id
    FROM rides
)

SELECT
    r1.driver_id, 
    COUNT(r2.passenger_id) AS cnt
FROM drivers r1
LEFT JOIN rides r2 ON r1.driver_id = r2.passenger_id
GROUP BY r1.driver_id;


# Single query solution without CTE
SELECT
    r1.driver_id, 
    COUNT(DISTINCT r2.ride_id) AS cnt
FROM rides r1
LEFT JOIN rides r2 ON r1.driver_id = r2.passenger_id
GROUP BY r1.driver_id;
