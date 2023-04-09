WITH RECURSIVE months AS (
    SELECT 1 AS month
    UNION ALL
    SELECT month + 1 AS month FROM months WHERE months.month < 12
),
available_drivers AS (
    SELECT
        driver_id,
        CASE
            WHEN YEAR(join_date) < 2020 THEN 1 ELSE MONTH(join_date)
        END AS available_month
    FROM drivers
    WHERE YEAR(join_date) < 2021
),
available_drivers_per_month AS(
    SELECT
        m.month,
        COUNT(DISTINCT driver_id) AS total_driver
    FROM months m
    LEFT JOIN available_drivers ad ON ad.available_month <= m.month
    GROUP BY m.month
),
drivers_with_acc_rides_per_month AS(
    SELECT
        DISTINCT ar.driver_id,
        MONTH(r.requested_at) as acc_month
    FROM AcceptedRides ar
    LEFT JOIN rides r ON ar.ride_id = r.ride_id
    WHERE year(r.requested_at) = 2020    
)

SELECT
    ad.month,
    CASE
        WHEN ad.total_driver = 0 THEN 0.00
        ELSE ROUND(
            (COUNT(dr.driver_id) / ad.total_driver) * 100.00
        , 2)
    END AS working_percentage
FROM available_drivers_per_month ad
LEFT JOIN drivers_with_acc_rides_per_month dr ON ad.month = dr.acc_month
GROUP BY ad.month
ORDER BY ad.month;
