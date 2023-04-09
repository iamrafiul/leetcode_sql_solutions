WITH RECURSIVE months_unpivot AS (
    SELECT 1 AS month
    UNION ALL
    SELECT month + 1 AS month FROM months_unpivot WHERE months_unpivot.month < 12
),
active_drivers AS (
    SELECT driver_id, 
          CASE 
            WHEN year(join_date) < 2020 then 1 else month(join_date) 
          END as active_month 
    FROM drivers
    WHERE year(join_date) < 2021
),
total_driver AS (
    SELECT
        m.month,
        COUNT(d.driver_id) AS total_drivers
    FROM active_drivers d
    LEFT JOIN months_unpivot m ON d.active_month <= m.month  
    GROUP BY m.month
),
total_acc_rides AS (
    SELECT 
        ride_id, 
        requested_at 
    FROM rides 
    JOIN acceptedrides using(ride_id)
    HAVING year(requested_at) = 2020    
)

SELECT
    mu.month,
    IFNULL(td.total_drivers, 0) AS active_drivers,
    IFNULL(COUNT(tar.ride_id), 0) AS accepted_rides
FROM months_unpivot mu
LEFT JOIN total_driver td ON mu.month = td.month
LEFT JOIN total_acc_rides tar ON td.month = MONTH(tar.requested_at)
GROUP BY td.month
ORDER BY td.month;
