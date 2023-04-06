# Single query with JOINs
SELECT
    request_at AS `Day`,
    ROUND(SUM(
        CASE WHEN status IN ('cancelled_by_driver', 'cancelled_by_client') THEN 1 ELSE 0 END
    ) / 
    COUNT(id), 2) AS `Cancellation Rate`
FROM trips
JOIN users u1 ON client_id = u1.users_id AND u1.banned = 'No'
JOIN users u2 ON driver_id = u2.users_id AND u2.banned = 'No'
WHERE request_at BETWEEN "2013-10-01" and "2013-10-03"
GROUP BY request_at;


# Single query with sub-query
SELECT
    request_at as Day,
    ROUND(
        SUM(
            CASE when status IN ('cancelled_by_driver', 'cancelled_by_client') THEN 1 ELSE 0 END
        ) /
        COUNT(status),
        2
    ) AS "Cancellation Rate"
FROM trips
WHERE 
    client_id NOT IN (SELECT users_id FROM users where banned='Yes') AND
    driver_id NOT IN (SELECT users_id FROM users where banned='Yes') AND
    request_at BETWEEN '2013-10-01' AND '2013-10-03'
GROUP by request_at;


# With CTE and JOINs
WITH unbanned_users AS (
    SELECT
        users_id
    FROM users
    WHERE banned = 'No'
)

SELECT
    request_at AS `Day`,
    ROUND(
        SUM(CASE WHEN status in ('cancelled_by_driver', 'cancelled_by_client') THEN 1 ELSE 0 END)
        /
        COUNT(*)
    , 2) AS `Cancellation Rate`
FROM trips t
JOIN unbanned_users u ON t.driver_id = u.users_id
JOIN unbanned_users u1 ON t.client_id = u1.users_id
WHERE request_at BETWEEN "2013-10-01" AND "2013-10-03"
GROUP BY request_at;
