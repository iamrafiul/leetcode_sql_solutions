WITH RECURSIVE months AS (
    SELECT 1 AS month
    UNION ALL
    SELECT month + 1 AS month FROM months WHERE months.month < 10
),
ride_calc AS (
    SELECT
        MONTH(r.requested_at) as month,
        IFNULL(SUM(ar.ride_distance), 0) AS total_dist,
        IFNULL(SUM(ar.ride_duration), 0) AS total_dur
    FROM Rides r
    JOIN AcceptedRides ar ON r.ride_id = ar.ride_id
    WHERE YEAR(r.requested_at) = 2020
    GROUP BY MONTH(r.requested_at)
)

SELECT 
    m.month,
    IFNULL(ROUND(SUM(rc.total_dist) / 3, 2), 0.00) AS average_ride_distance,
    IFNULL(ROUND(SUM(rc.total_dur) / 3, 2), 0.00) AS average_ride_duration
FROM months m
LEFT OUTER JOIN ride_calc rc ON rc.month BETWEEN m.month AND m.month + 2
GROUP BY m.month;
